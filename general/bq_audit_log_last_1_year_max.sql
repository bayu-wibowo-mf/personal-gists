with
raw as(
  select
    principalEmail,
    table_name,
    max(startTime) AS max_start_time
  from `gcp-data-lake-prod-mfcojp.tmp.cloudbi_fractal_access_1_year`
  group by 1, 2
)
select
  principalEmail,
  CONCAT(
    split(table_name, "/")[1], ".",
    split(table_name, "/")[3], ".",
    split(replace(table_name, "\"", ""), "/")[5]) AS full_table_name,
  max_start_time
from raw
ORDER BY full_table_name;