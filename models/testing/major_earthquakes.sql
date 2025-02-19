with earthquakes as (
  select
    substr("IDENTIFIER", 0, 8) as identifier,
    "ACTION_VALUES" as magnitude,
    "PLACE" as area,
    "DATE"
  from
    "mia-dbt-demo-earthquakes"
)
select
  *
from
  earthquakes
where
  magnitude > 1
