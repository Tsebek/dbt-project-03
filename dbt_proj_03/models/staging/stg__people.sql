-- stg__people.sql
-- import raw_superstore
with raw_superstore as (
    select
        person,
        region
    from {{ source('raw', 'superstore') }}
    where _file = 'superstore/supestore_people.csv'
)

select
    person as manager_name,
    region
from raw_superstore
