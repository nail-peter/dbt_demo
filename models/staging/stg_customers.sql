{{
  config(
    materialized='view'
  )
}}

-- Staging model for customers with data cleaning and standardization

with source_data as (
    select * from {{ ref('base_customers_mock') }}
),

cleaned_customers as (
    select
        customer_id,

        -- Clean names
        trim(initcap(first_name)) as first_name,
        trim(initcap(last_name)) as last_name,
        trim(first_name) || ' ' || trim(last_name) as full_name,

        -- Clean email
        lower(trim(email)) as email,

        -- Clean phone (remove formatting)
        regexp_replace(phone, '[^0-9+]', '', 'g') as phone,

        registration_date,

        -- Standardize customer segments
        case
            when customer_segment ilike '%premium%' then 'Premium'
            when customer_segment ilike '%gold%' then 'Gold'
            when customer_segment ilike '%silver%' then 'Silver'
            when customer_segment ilike '%bronze%' then 'Bronze'
            else 'Standard'
        end as customer_segment,

        -- Geographic data cleaning
        upper(trim(country)) as country,
        trim(initcap(city)) as city,
        upper(trim(postal_code)) as postal_code,

        created_at,
        updated_at,

        -- Calculate customer lifetime
        current_date - registration_date::date as days_since_registration,

        -- Customer age category based on registration
        case
            when current_date - registration_date::date <= 30 then 'New'
            when current_date - registration_date::date <= 365 then 'Recent'
            when current_date - registration_date::date <= 1095 then 'Established'
            else 'Veteran'
        end as customer_tenure

    from source_data
    where email is not null  -- Filter out invalid records
)

select * from cleaned_customers