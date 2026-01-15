-- Test to validate that our semantic layer setup is correct

-- Test 1: Check that staging models have proper structure
{{ config(severity = 'warn') }}

with staging_orders as (
    select count(*) as order_count
    from {{ ref('stg_orders') }}
    where order_date is not null
      and total_amount is not null
      and customer_id is not null
),

staging_customers as (
    select count(*) as customer_count
    from {{ ref('stg_customers') }}
    where customer_id is not null
      and email is not null
)

select
    'staging_validation' as test_name,
    case
        when (select order_count from staging_orders) = 0 then 'FAIL: No valid orders in staging'
        when (select customer_count from staging_customers) = 0 then 'FAIL: No valid customers in staging'
        else 'PASS: Staging tables have valid data'
    end as test_result