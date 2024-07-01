-- stg__orders.sql
-- import raw_superstore
WITH raw_superstore AS (
    SELECT
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
    FROM {{ source('raw', 'superstore') }}
    WHERE _file = 'superstore/supestore_orders.csv'
)

SELECT
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
    CASE
        WHEN city = 'Burlington' AND postal_code IS NULL THEN '05401'
        ELSE postal_code
    END AS postal_code, -- clean piece of data
    region,
    product_id,
    category AS product_category,
    sub_category AS product_subcategory,
    product_name,
    sales,
    quantity,
    discount,
    profit
FROM raw_superstore
