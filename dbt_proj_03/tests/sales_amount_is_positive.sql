-- sales, quantity, discount are positive numbers

select sales
from {{ ref('stg__orders') }}
where sales < 0
