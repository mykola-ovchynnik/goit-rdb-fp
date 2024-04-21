USE pandemic;

SELECT 
	t.entity,
    t.Year,
    t.start_date,
    t.todays_date,
    TIMESTAMPDIFF(YEAR, t.start_date, t.todays_date) as years_difference
FROM 
    (
        SELECT 
			e.entity,
            icn.Year,
            STR_TO_DATE(CONCAT(icn.Year, '-01-01'), '%Y-%m-%d') as start_date,
            CURDATE() as todays_date
        FROM 
            infectious_cases_normalized icn
            JOIN entities e ON e.id = icn.entity_id
    ) as t;
