-- sales, quantity, discount are positive numbers

SELECT
    sales
FROM {{ ref('stg__orders') }}
WHERE sales < 0
