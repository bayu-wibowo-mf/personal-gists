-- Get storage information from information schema
CREATE OR REPLACE TABLE `crow-lake-prod-mfcojp.tmp.raven2nd_unused_infodb_table_size` AS (
SELECT
  *
FROM
  `crow-lake-prod-mfcojp`.`region-asia-northeast1`.INFORMATION_SCHEMA.TABLE_STORAGE
WHERE
  TABLE_SCHEMA IN ("hermes")
);
  
-- Calculate storage cost
SELECT
  project_id,
  table_schema,
  table_name,
  active_logical_bytes,
  long_term_logical_bytes,
  active_logical_bytes / power(1024, 3) as active_logical_gib,
  long_term_logical_bytes / power(1024, 3) as long_term_logical_gib,
  ((active_logical_bytes / power(1024, 3)) * 0.023) + ((long_term_logical_bytes / power(1024, 3)) * 0.016) as usd_monthly_storage_cost
FROM
  `crow-lake-prod-mfcojp.tmp.raven2nd_unused_infodb_table_size`;
