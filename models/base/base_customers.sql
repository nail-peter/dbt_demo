{{
  config(
    materialized='view'
  )
}}

-- Base model for customers table
-- This should map to your actual table structure in PostgreSQL

select
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    registration_date,
    customer_segment,
    country,
    city,
    postal_code,
    created_at,
    updated_at
from {{ source('raw_data', 'customers') }}