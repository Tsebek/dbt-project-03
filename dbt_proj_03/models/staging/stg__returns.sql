-- stg__returns.sql
-- import raw_superstore
WITH raw_superstore AS (
    SELECT
        returned,
        order_id
    FROM {{ source('raw', 'superstore') }}
    WHERE _file = 'superstore/supestore_returns.csv'
)

SELECT
    order_id,
    coalesce(returned = 'Yes', FALSE) AS returned
FROM raw_superstore
