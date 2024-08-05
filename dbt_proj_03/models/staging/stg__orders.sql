-- stg__orders.sql
-- import raw_superstore
with raw_superstore as (
    select
        row_id,
        order_id,
        order_date,
        ship_date,
        ship_mode,
        customer_id,
        customer_name,
        segment,
        country,
        city,
        state,
        postal_code,
        region,
        product_id,
        category,
        sub_category,
        product_name,
        sales,
        quantity,
        discount,
        profit
    from {{ source('raw', 'superstore') }}
    where _file = 'superstore/supestore_orders.csv'
)

select
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    region, -- clean piece of data
    product_id,
    category as product_category,
    sub_category as product_subcategory,
    product_name,
    sales,
    quantity,
    discount,
    profit,
    case
        when city = 'Burlington' and postal_code is NULL then '05401'
        else postal_code
    end as postal_code
from raw_superstore
