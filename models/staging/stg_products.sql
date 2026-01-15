{{
  config(
    materialized='view'
  )
}}

-- Staging model for products with data cleaning and standardization

with source_data as (
    select * from {{ ref('base_products_mock') }}
),

cleaned_products as (
    select
        product_id,
        trim(product_name) as product_name,

        -- Standardize categories
        initcap(trim(category)) as category,
        initcap(trim(subcategory)) as subcategory,
        initcap(trim(brand)) as brand,

        -- Price validation and cleaning
        case
            when unit_price is null or unit_price <= 0 then 0
            else unit_price
        end as unit_price,

        case
            when cost_price is null or cost_price <= 0 then 0
            else cost_price
        end as cost_price,

        -- Calculate margin
        case
            when unit_price > 0 and cost_price > 0
            then ((unit_price - cost_price) / unit_price) * 100
            else 0
        end as profit_margin_percent,

        supplier_id,
        is_active,
        created_at,
        updated_at,

        -- Product categorization
        case
            when unit_price >= 500 then 'Premium'
            when unit_price >= 100 then 'Mid-Range'
            else 'Budget'
        end as price_segment,

        -- Profitability classification
        case
            when ((unit_price - cost_price) / unit_price) * 100 >= 50 then 'High Margin'
            when ((unit_price - cost_price) / unit_price) * 100 >= 25 then 'Medium Margin'
            when ((unit_price - cost_price) / unit_price) * 100 > 0 then 'Low Margin'
            else 'No Margin'
        end as margin_category

    from source_data
    where product_name is not null
      and is_active = true  -- Only include active products
)

select * from cleaned_products