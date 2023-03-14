-- Allison Tipan V00848862
-- Show which industries in which states (except DC)
-- employed at least 7.5% of the state's 2019 population,
-- ordered by the total payroll for that industry
-- in that state.
-- 1.1 marks: <26 operators
-- 1.0 marks: <30 operators
-- 0.9 marks: <35 operators
-- 0.8 marks: correct answer


SELECT abbr, 
name, 
payroll AS `Total Payrolls`, 
Percentage AS `% of Population` 
FROM  
	(SELECT *, 
	IndustryEmployees.employees/StatePopulation.population*100 AS Percentage 
	FROM 
		(SELECT industry.name AS name, 
		state AS state1, 
		SUM(employees) AS employees, 
		SUM(payroll) AS payroll 
		FROM countyindustries 
		JOIN industry ON industry = industry.id 
		JOIN county ON countyindustries.county = county.fips 
		GROUP BY industry, industry.id, 
		state)  AS IndustryEmployees 
	JOIN 
		(SELECT state.abbr AS abbr, state AS state2, 
		SUM(population) AS population 
		FROM 
			(SELECT * 
			FROM state 
			WHERE abbr = 'DC') AS DC, 
		countypopulation 
		JOIN county ON countypopulation.county = county.fips 
		JOIN state ON county.state = state.id 
		WHERE county.state NOT IN (DC.id) AND countypopulation.year = 2019 
		GROUP BY state) AS StatePopulation 
	ON IndustryEmployees.state1 = StatePopulation.state2) AS Results 
WHERE Percentage > 7.5 
ORDER BY payroll DESC;
