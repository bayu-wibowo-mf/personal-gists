-- Gender ratio
with gender_counter as (
	select
		gender,
		COUNT(*) as gender_count
	from employee_data ed
	group by gender
)
select 
	gender,
	gender_count,
	(gender_count * 1.0) / sum(gender_count) over () as gender_ratio
from gender_counter;
 
-- Nationality ratio
with nationality_counter as (
	select
		nationality,
		count(*) as row_count
	from employee_data ed
	group by nationality
)
select 
	nationality,
	row_count,
	(row_count * 1.0) / sum(row_count) over () as ratio
from nationality_counter;

-- Employee turn over rate
WITH hire_count AS (
    SELECT
        extract(year from hire_date) AS hire_year,
        COUNT(*) AS hired_employee_count
    FROM
        employee_data
    GROUP BY
        extract(year from hire_date)
),
termination_count AS (
    SELECT
		extract(year from termination_date) AS termination_year,
        COUNT(*) AS terminated_employee_count
    FROM
        employee_data
    GROUP BY
        extract(year from termination_date)
)
SELECT
    ec.hire_year,
    ecd.terminated_employee_count,
    ec.hired_employee_count,
    (ecd.terminated_employee_count * 1.0) / ec.hired_employee_count AS turn_over_rate
FROM
    hire_count ec
LEFT JOIN
    termination_count ecd ON ec.hire_year = ecd.termination_year;

-- Employee retention rate
WITH hire_count AS (
    SELECT
        extract(year from hire_date) AS hire_year,
        COUNT(*) AS hired_employee_count
    FROM
        employee_data
    GROUP BY
        extract(year from hire_date)
),
termination_count AS (
    SELECT
		extract(year from termination_date) AS termination_year,
        COUNT(*) AS terminated_employee_count
    FROM
        employee_data
    GROUP BY
        extract(year from termination_date)
)
SELECT
    ec.hire_year,
    ecd.terminated_employee_count,
    ec.hired_employee_count,
    (ec.hired_employee_count - ecd.terminated_employee_count * 1.0) / ec.hired_employee_count AS turn_over_rate
FROM
    hire_count ec
LEFT JOIN
    termination_count ecd ON ec.hire_year = ecd.termination_year;