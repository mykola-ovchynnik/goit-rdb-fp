USE pandemic;

SELECT 
    e.entity as entity,
    AVG(icn.number_rabies) AS average_value,
    MIN(icn.number_rabies) AS min_value,
    MAX(icn.number_rabies) AS max_value,
    SUM(icn.number_rabies) AS total_cases
FROM infectious_cases_normalized icn
        JOIN entities e ON e.id = icn.entity_id
WHERE number_rabies <> ''
GROUP BY entity
ORDER BY average_value DESC
LIMIT 10;