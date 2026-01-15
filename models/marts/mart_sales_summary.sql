{{
  config(
    materialized='table',
    indexes=[
      {'columns': ['order_date'], 'type': 'btree'},
      {'columns': ['customer_id'], 'type': 'btree'}
    ]
  )
}}

-- Sales summary mart combining orders, customers, and products
-- This is the main fact table for our semantic layer

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

-- Assuming you have an order_items table linking orders to products
-- For now, creating a simplified version
sales_fact as (
    select
        o.order_id,
        o.customer_id,
        c.full_name as customer_name,
        c.customer_segment,
        c.customer_tenure,
        c.country,
        c.city,

        o.order_date,
        o.order_year,
        o.order_month,
        o.order_day,
        o.order_day_of_week,
        o.order_status,
        o.order_value_segment,

        o.total_amount,
        o.currency,
        o.payment_method,

        -- Time dimensions for easier analysis
        case
            when extract(month from o.order_date) in (12, 1, 2) then 'Winter'
            when extract(month from o.order_date) in (3, 4, 5) then 'Spring'
            when extract(month from o.order_date) in (6, 7, 8) then 'Summer'
            else 'Fall'
        end as season,

        case
            when extract(dow from o.order_date) in (0, 6) then 'Weekend'
            else 'Weekday'
        end as weekend_flag,

        -- Customer metrics
        count(*) over (partition by o.customer_id) as customer_lifetime_orders,
        sum(o.total_amount) over (partition by o.customer_id) as customer_lifetime_value,

        -- Running totals
        row_number() over (partition by o.customer_id order by o.order_date) as customer_order_sequence,

        o.created_at,
        o.updated_at

    from orders o
    left join customers c on o.customer_id = c.customer_id
    where o.order_status != 'Cancelled'
)

select * from sales_fact