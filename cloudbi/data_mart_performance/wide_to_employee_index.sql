create table dm_employee_stability_index
AS
WITH hire_count AS (
    select
    	tenant_uuid,
        extract(year from hire_date) AS hire_year,
        COUNT(*) AS hired_employee_count
    FROM
        employee_data
    GROUP BY
        tenant_uuid, extract(year from hire_date)
),
termination_count AS (
    select
    	tenant_uuid,
		extract(year from termination_date) AS termination_year,
        COUNT(*) AS terminated_employee_count
    FROM
        employee_data
    GROUP BY
        tenant_uuid, extract(year from termination_date)
)
select
	TO_DATE(concat(ec.hire_year, '0101'),'YYYYMMDD') as date_key,
	ec.tenant_uuid as tenant_uuid,
	'turnover_rate' as index_name,
    (ecd.terminated_employee_count * 1.0) / ec.hired_employee_count AS index_value
FROM
    hire_count ec
LEFT JOIN
    termination_count ecd ON ec.hire_year = ecd.termination_year and ec.tenant_uuid = ecd.tenant_uuid
union all 
select
	TO_DATE(concat(ec.hire_year, '0101'),'YYYYMMDD') as date_key,
	ec.tenant_uuid as tenant_uuid,
	'retention_rate' as index_name,
    ((ec.hired_employee_count - ecd.terminated_employee_count) * 1.0) / ec.hired_employee_count AS index_value
FROM
    hire_count ec
LEFT JOIN
    termination_count ecd ON ec.hire_year = ecd.termination_year and ec.tenant_uuid = ecd.tenant_uuid;