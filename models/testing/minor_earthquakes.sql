with earthquakes as (
    select
        substr("identifier", 0, 8) as id,
        action_values as magnitude,
        place as area,
        date
    from
        dbt-demo-earthquakes
)
select
    *
from
    earthquakes
where
    magnitude < 1
