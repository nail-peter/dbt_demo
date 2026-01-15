{{
  config(
    materialized='view'
  )
}}

-- Staging model for orders with data cleaning and standardization

with source_data as (
    select * from {{ ref('base_orders_mock') }}
),

cleaned_orders as (
    select
        order_id,
        customer_id,
        order_date,
        case
            when order_status = 'pending' then 'Pending'
            when order_status = 'shipped' then 'Shipped'
            when order_status = 'delivered' then 'Delivered'
            when order_status = 'cancelled' then 'Cancelled'
            else 'Unknown'
        end as order_status,

        -- Clean and validate monetary amounts
        case
            when total_amount is null or total_amount < 0 then 0
            else total_amount
        end as total_amount,

        upper(currency) as currency,

        -- Standardize payment methods
        case
            when payment_method ilike '%credit%' then 'Credit Card'
            when payment_method ilike '%debit%' then 'Debit Card'
            when payment_method ilike '%paypal%' then 'PayPal'
            when payment_method ilike '%bank%' then 'Bank Transfer'
            else 'Other'
        end as payment_method,

        created_at,
        updated_at,

        -- Add calculated fields
        extract(year from order_date) as order_year,
        extract(month from order_date) as order_month,
        extract(day from order_date) as order_day,
        extract(dow from order_date) as order_day_of_week,

        -- Business logic flags
        case
            when total_amount >= 1000 then 'High Value'
            when total_amount >= 100 then 'Medium Value'
            else 'Low Value'
        end as order_value_segment

    from source_data
)

select * from cleaned_orders