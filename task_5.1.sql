USE pandemic;
DROP FUNCTION IF EXISTS YearDifference;

DELIMITER //
CREATE FUNCTION YearDifference(year INT)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE startDate DATE;
    DECLARE yearsDiff INT;

    SET startDate = STR_TO_DATE(CONCAT(year, '-01-01'), '%Y-%m-%d');
    SET yearsDiff = TIMESTAMPDIFF(YEAR, startDate, CURDATE());

    RETURN yearsDiff;
END //
DELIMITER ;

SELECT 
	e.entity,
	icn.Year,
	YearDifference(Year) as years_difference
FROM infectious_cases_normalized icn
	JOIN entities e ON e.id = icn.entity_id