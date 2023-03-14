-- Allison Tipan V00848862
-- Retrieve alphabetically the names of industries that
-- employ at least five million workers across
-- the US, excluding California.
-- 1.1 marks: <9 operators
-- 1.0 marks: <11 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

SELECT name 
FROM 
	(SELECT industry.name AS name, 
	SUM(employees) AS employed 
	FROM state 
	JOIN county ON state.id = county.state AND abbr NOT IN ('CA') 
	JOIN countyindustries ON county.fips = countyindustries.county  
	JOIN industry ON countyindustries.industry = industry.id 
	GROUP BY industry) AS industries 
WHERE employed >= 5000000 
ORDER BY industries.name;