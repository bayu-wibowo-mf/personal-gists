WITH
unused_table AS (
  SELECT  CONCAT("\"", "projects", "/", f0_, "/datasets/", f1_, "/tables/", f2_, "\"") AS table_name
  FROM    `gcp-data-lake-prod-mfcojp.tmp.cloudbi_unused_fractal_table_repo`
)
SELECT  *
FROM    `inhouse-bpr.common_data_mart.query_logs` ql
JOIN UNNEST(ql.referencedTables) AS ref_table
JOIN unused_table
ON      unused_table.table_name = ref_table 
WHERE   DATE(ql.startTime) >= DATE_SUB(CURRENT_DATE("Asia/Tokyo"), INTERVAL 1 YEAR)
;