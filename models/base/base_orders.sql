{{
  config(
    materialized='view'
  )
}}

-- Base model for orders table
-- This should map to your actual table structure in PostgreSQL

select
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    currency,
    payment_method,
    created_at,
    updated_at
from {{ source('raw_data', 'orders') }}