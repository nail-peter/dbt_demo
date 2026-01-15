{{
  config(
    materialized='view'
  )
}}

-- Mock customers data for demo purposes
-- Since we don't have real source tables, we'll create sample data

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
from (
    values
    (101, 'John', 'Smith', 'john.smith@email.com', '555-0101', '2023-03-15'::date, 'premium', 'USA', 'New York', '10001', '2023-03-15 09:00:00'::timestamp, '2023-03-15 09:00:00'::timestamp),
    (102, 'Sarah', 'Johnson', 'sarah.johnson@email.com', '555-0102', '2023-05-20'::date, 'gold', 'USA', 'Los Angeles', '90210', '2023-05-20 10:30:00'::timestamp, '2023-05-20 10:30:00'::timestamp),
    (103, 'Michael', 'Davis', 'michael.davis@email.com', '555-0103', '2023-07-10'::date, 'silver', 'Canada', 'Toronto', 'M5V 3M6', '2023-07-10 14:15:00'::timestamp, '2023-07-10 14:15:00'::timestamp),
    (104, 'Emma', 'Wilson', 'emma.wilson@email.com', '555-0104', '2023-09-05'::date, 'bronze', 'UK', 'London', 'SW1A 1AA', '2023-09-05 11:45:00'::timestamp, '2023-09-05 11:45:00'::timestamp),
    (105, 'David', 'Brown', 'david.brown@email.com', '555-0105', '2023-11-12'::date, 'standard', 'USA', 'Chicago', '60601', '2023-11-12 16:20:00'::timestamp, '2023-11-12 16:20:00'::timestamp),
    (106, 'Lisa', 'Garcia', 'lisa.garcia@email.com', '555-0106', '2023-12-01'::date, 'premium', 'Spain', 'Madrid', '28001', '2023-12-01 13:10:00'::timestamp, '2023-12-01 13:10:00'::timestamp),
    (107, 'Robert', 'Miller', 'robert.miller@email.com', '555-0107', '2024-01-08'::date, 'gold', 'Germany', 'Berlin', '10115', '2024-01-08 08:30:00'::timestamp, '2024-01-08 08:30:00'::timestamp)
) as customers(customer_id, first_name, last_name, email, phone, registration_date, customer_segment, country, city, postal_code, created_at, updated_at)