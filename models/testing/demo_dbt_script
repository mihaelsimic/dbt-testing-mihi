-- models/orders_summary.sql

{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with raw_orders as (
  select
    order_id,
    user_id,
    created_at,
    amount_cents,
    status
  from {{ source('finance', 'raw_orders') }}
),

clean_orders as (
  select
    order_id,
    user_id,
    -- rename timestamp column for clarity
    created_at       as order_timestamp,
    amount_cents/100 as order_amount_usd,
    case
      when status = 'P' then 'pending'
      when status = 'C' then 'completed'
      else 'other'
    end              as order_status
  from raw_orders
  where created_at >= dateadd(day, -30, current_date())
),

aggregated as (
  select
    date_trunc('day', order_timestamp) as day,
    count(*)                    as orders_count,
    sum(order_amount_usd)       as total_revenue
  from clean_orders
  group by 1
)

select * from aggregated
