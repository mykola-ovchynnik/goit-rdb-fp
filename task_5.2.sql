USE pandemic;
DROP FUNCTION IF EXISTS AverageCases;

DELIMITER //
CREATE FUNCTION AverageCases(cases FLOAT, period INT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE averageCases FLOAT;

    SET averageCases = cases / period;

    RETURN averageCases;
END //
DELIMITER ;

SELECT 
	e.entity,
	icn.Year,
	AverageCases(icn.Number_malaria, 12) as malaria_avg_per_month,
    AverageCases(icn.Number_malaria, 4) as malaria_avg_per_quarter,
    AverageCases(icn.Number_malaria, 2) as malaria_avg_per_halfyear
FROM infectious_cases_normalized icn
	JOIN entities e ON e.id = icn.entity_id
WHERE
    Number_malaria <> '';