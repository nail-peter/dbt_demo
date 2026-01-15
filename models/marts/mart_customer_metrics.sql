{{
  config(
    materialized='table'
  )
}}

-- Customer-level aggregated metrics for analysis

with sales_data as (
    select * from {{ ref('mart_sales_summary') }}
),

customer_metrics as (
    select
        customer_id,
        customer_name,
        customer_segment,
        customer_tenure,
        country,
        city,

        -- Order metrics
        count(distinct order_id) as total_orders,
        sum(total_amount) as total_revenue,
        avg(total_amount) as avg_order_value,
        min(total_amount) as min_order_value,
        max(total_amount) as max_order_value,

        -- Time-based metrics
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        max(order_date) - min(order_date) as customer_lifespan_days,

        -- Calculate days since last order
        current_date - max(order_date) as days_since_last_order,

        -- Frequency metrics
        case
            when count(distinct order_id) = 1 then 'One-time'
            when count(distinct order_id) <= 5 then 'Occasional'
            when count(distinct order_id) <= 15 then 'Regular'
            else 'Frequent'
        end as order_frequency_segment,

        -- Value-based segmentation (RFM-style)
        case
            when sum(total_amount) >= 5000 then 'High Value'
            when sum(total_amount) >= 1000 then 'Medium Value'
            else 'Low Value'
        end as value_segment,

        -- Recency segmentation
        case
            when current_date - max(order_date) <= 30 then 'Active'
            when current_date - max(order_date) <= 90 then 'Lapsed'
            else 'Churned'
        end as recency_segment,

        -- Payment method preferences
        mode() within group (order by payment_method) as preferred_payment_method,

        -- Seasonal behavior
        count(case when extract(month from order_date) in (12, 1, 2) then 1 end) as winter_orders,
        count(case when extract(month from order_date) in (3, 4, 5) then 1 end) as spring_orders,
        count(case when extract(month from order_date) in (6, 7, 8) then 1 end) as summer_orders,
        count(case when extract(month from order_date) in (9, 10, 11) then 1 end) as fall_orders,

        current_timestamp as updated_at

    from sales_data
    group by
        customer_id,
        customer_name,
        customer_segment,
        customer_tenure,
        country,
        city
)

select * from customer_metrics