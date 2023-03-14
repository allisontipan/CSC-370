-- Allison Tipan V00848862
-- Retrieve by increasing snowfall the number of employees
-- in 'Mining, quarrying, and oil and gas extraction' for all
-- counties that have the words 'iron', 'coal', or 'mineral'
-- in their name.
-- 1.1 marks: <13 operators
-- 1.0 marks: <15 operators
-- 0.9 marks: <20 operators
-- 0.8 marks: correct answer

SELECT Counties.name AS name, 
Counties.abbr AS abbr, 
MiningIndustries.employees AS employees 
FROM 
	(SELECT * 
	FROM county 
	JOIN  state ON county.state = state.id 
	WHERE name LIKE '%iron%' OR name LIKE '%coal%' OR name LIKE '%mineral%') AS Counties 
LEFT JOIN 
	(SELECT * 
	FROM countyindustries 
	JOIN industry ON industry = industry.id 
	WHERE industry.name = 'Mining, quarrying, and oil and gas extraction') AS MiningIndustries 
ON Counties.fips = MiningIndustries.county 
ORDER BY Counties.snow ASC;