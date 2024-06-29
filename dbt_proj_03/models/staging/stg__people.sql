-- stg__people.sql
-- import raw_superstore
WITH raw_superstore AS (
    SELECT
        person,
        region
    FROM {{ source('raw', 'superstore') }}
    WHERE _file = 'superstore/supestore_people.csv'
)

SELECT
    person AS manager_name,
    region
FROM raw_superstore
