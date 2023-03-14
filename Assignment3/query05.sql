-- Allison Tipan V00848862
-- Retrieve in descending order of labour force size
-- all counties that had unemployment rates over 10%
-- in the 2008 census.
-- Hint: Unemployment rate = unemployment / labour force
-- 1.1 marks: <9 operators
-- 1.0 marks: <10 operators
-- 1.0 marks: <15 operators
-- 0.8 marks: correct answer

SELECT name, 
	abbr, 
	labour_force, 
	Rate*100 AS `Unemployment Rate` 
FROM 
	(SELECT *, 
	unemployed/labour_force AS Rate 
	FROM county 
	JOIN countylabourstats ON fips = countylabourstats.county 
	JOIN state ON state = state.id 
	WHERE year = '2008') AS Results 
WHERE Rate > 0.1 
ORDER BY labour_force DESC;
