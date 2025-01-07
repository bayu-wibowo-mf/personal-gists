create table dm_employee_demography AS
with gender_data as (
	select
		tenant_uuid,
		gender,
		COUNT(*) as gender_count
	from employee_data ed 
	group by tenant_uuid, gender
),
nationality_data as (
	select
		tenant_uuid,
		nationality,
		count(*) as nationality_count
	from employee_data ed 
	group by 1, 2
)
select 
	current_date as date_key,
	tenant_uuid,
	'gender' as demography_category,
	gender as demography_name,
	(gender_count * 1.0) / sum(gender_count) over (partition by tenant_uuid) as demography_value
from gender_data
union ALL
select
	current_date as date_key,
	tenant_uuid,
	'nationality' as demography_category,
	nationality,
	(nationality_count * 1.0) / sum(nationality_count) over (partition by tenant_uuid) as demography_value
from nationality_data;