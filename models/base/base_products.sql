{{
  config(
    materialized='view'
  )
}}

-- Base model for products table
-- This should map to your actual table structure in PostgreSQL

select
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    unit_price,
    cost_price,
    supplier_id,
    is_active,
    created_at,
    updated_at
from {{ source('raw_data', 'products') }}