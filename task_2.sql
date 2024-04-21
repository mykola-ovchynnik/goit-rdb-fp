USE pandemic;

CREATE TABLE entities(
id INT PRIMARY KEY AUTO_INCREMENT,
code VARCHAR(8) UNIQUE,
entity VARCHAR(32) NOT NULL UNIQUE
);

INSERT INTO entities (code, entity)
SELECT DISTINCT code, entity FROM infectious_cases;

CREATE TABLE infectious_cases_normalized 
AS SELECT * FROM infectious_cases;

ALTER TABLE infectious_cases_normalized
ADD id INT PRIMARY KEY AUTO_INCREMENT FIRST,
ADD entity_id INT AFTER id,
ADD CONSTRAINT fk_entity_id FOREIGN KEY (entity_id) REFERENCES entities(id);

UPDATE infectious_cases_normalized i, entities e  
SET i.entity_id = e.id WHERE e.code = i.code;

ALTER TABLE infectious_cases_normalized
DROP COLUMN entity,
DROP COLUMN code;