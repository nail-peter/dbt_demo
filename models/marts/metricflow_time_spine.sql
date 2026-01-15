{{
  config(
    materialized='table'
  )
}}

-- Time spine for dbt Semantic Layer
-- This creates a daily time spine for MetricFlow

with date_spine as (
    select
        date_day
    from (
        select
            '2020-01-01'::date + (n || ' day')::interval as date_day
        from generate_series(0, 3652) as n  -- ~10 years of daily data
    ) dates
)

select
    date_day,
    extract(year from date_day) as date_year,
    extract(month from date_day) as date_month,
    extract(day from date_day) as date_day_of_month,
    extract(dow from date_day) as date_day_of_week
from date_spine