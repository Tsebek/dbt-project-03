-- int__dim_customers.sql
with
customers as (
    select distinct
        customer_id,
        customer_name
    from {{ ref("stg__orders") }}
)

select
    *,
    100 + row_number() over (order by null) as id
from customers
