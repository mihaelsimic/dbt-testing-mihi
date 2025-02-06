with earthquakes as (
    select
        substr("id", 0, 8) as id,
        action_values as magnitude,
        place as area,
        date
    from
        weba
)
select
    *
from
    earthquakes
where
    magnitude < 1
