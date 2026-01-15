{{
  config(
    materialized='view'
  )
}}

-- Mock products data for demo purposes
-- Since we don't have real source tables, we'll create sample data

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
from (
    values
    (1001, 'Wireless Headphones', 'Electronics', 'Audio', 'TechBrand', 129.99, 65.00, 501, true, '2023-01-01 00:00:00'::timestamp, '2023-01-01 00:00:00'::timestamp),
    (1002, 'Smartphone Case', 'Electronics', 'Accessories', 'ProtectPlus', 24.99, 8.50, 502, true, '2023-01-15 00:00:00'::timestamp, '2023-01-15 00:00:00'::timestamp),
    (1003, 'Coffee Maker', 'Home & Kitchen', 'Appliances', 'BrewMaster', 89.99, 45.00, 503, true, '2023-02-01 00:00:00'::timestamp, '2023-02-01 00:00:00'::timestamp),
    (1004, 'Running Shoes', 'Sports', 'Footwear', 'SpeedRun', 79.99, 35.00, 504, true, '2023-02-15 00:00:00'::timestamp, '2023-02-15 00:00:00'::timestamp),
    (1005, 'Desk Lamp', 'Home & Kitchen', 'Lighting', 'BrightLight', 45.99, 18.00, 505, true, '2023-03-01 00:00:00'::timestamp, '2023-03-01 00:00:00'::timestamp),
    (1006, 'Tablet Stand', 'Electronics', 'Accessories', 'TechBrand', 19.99, 7.50, 501, true, '2023-03-15 00:00:00'::timestamp, '2023-03-15 00:00:00'::timestamp),
    (1007, 'Yoga Mat', 'Sports', 'Equipment', 'FlexFit', 39.99, 15.00, 506, true, '2023-04-01 00:00:00'::timestamp, '2023-04-01 00:00:00'::timestamp),
    (1008, 'Bluetooth Speaker', 'Electronics', 'Audio', 'SoundWave', 69.99, 28.00, 507, true, '2023-04-15 00:00:00'::timestamp, '2023-04-15 00:00:00'::timestamp)
) as products(product_id, product_name, category, subcategory, brand, unit_price, cost_price, supplier_id, is_active, created_at, updated_at)