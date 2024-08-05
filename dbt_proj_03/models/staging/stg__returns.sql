-- stg__returns.sql
-- import raw_superstore
with raw_superstore as (
    select
        returned,
        order_id
    from {{ source('raw', 'superstore') }}
    where _file = 'superstore/supestore_returns.csv'
)

select
    order_id,
    coalesce(returned = 'Yes', FALSE) as returned
from raw_superstore
