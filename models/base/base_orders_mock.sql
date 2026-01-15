{{
  config(
    materialized='view'
  )
}}

-- Mock orders data for demo purposes
-- Since we don't have real source tables, we'll create sample data

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
from (
    values
    (1, 101, '2024-01-15'::date, 'completed', 125.99, 'USD', 'credit_card', '2024-01-15 10:30:00'::timestamp, '2024-01-15 10:30:00'::timestamp),
    (2, 102, '2024-01-16'::date, 'completed', 89.50, 'USD', 'paypal', '2024-01-16 14:15:00'::timestamp, '2024-01-16 14:15:00'::timestamp),
    (3, 103, '2024-01-17'::date, 'shipped', 250.00, 'USD', 'credit_card', '2024-01-17 09:45:00'::timestamp, '2024-01-17 09:45:00'::timestamp),
    (4, 101, '2024-01-18'::date, 'completed', 75.25, 'USD', 'debit_card', '2024-01-18 16:20:00'::timestamp, '2024-01-18 16:20:00'::timestamp),
    (5, 104, '2024-01-19'::date, 'pending', 199.99, 'USD', 'bank_transfer', '2024-01-19 11:10:00'::timestamp, '2024-01-19 11:10:00'::timestamp),
    (6, 105, '2024-01-20'::date, 'completed', 45.75, 'USD', 'credit_card', '2024-01-20 13:30:00'::timestamp, '2024-01-20 13:30:00'::timestamp),
    (7, 102, '2024-01-21'::date, 'completed', 310.50, 'USD', 'paypal', '2024-01-21 15:45:00'::timestamp, '2024-01-21 15:45:00'::timestamp),
    (8, 106, '2024-01-22'::date, 'shipped', 88.25, 'USD', 'credit_card', '2024-01-22 08:15:00'::timestamp, '2024-01-22 08:15:00'::timestamp),
    (9, 107, '2024-01-23'::date, 'completed', 156.75, 'USD', 'debit_card', '2024-01-23 12:00:00'::timestamp, '2024-01-23 12:00:00'::timestamp),
    (10, 103, '2024-01-24'::date, 'completed', 67.99, 'USD', 'credit_card', '2024-01-24 17:30:00'::timestamp, '2024-01-24 17:30:00'::timestamp)
) as orders(order_id, customer_id, order_date, order_status, total_amount, currency, payment_method, created_at, updated_at)