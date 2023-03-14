-- Allison Tipan V00848862
-- Out of those counties with at least 25000 residents,
-- retrieve the pair from the same state
-- that had the absolute closest
-- population in 2018
-- 1.1 marks: <11 operators
-- 1.0 marks: <12 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

SELECT county1.name AS name, 
C1.population AS population, 
county2.name AS name, 
C2.population AS population 
FROM countypopulation AS C1 
JOIN countypopulation AS C2 ON C1.year = '2018' AND C2.year = '2018' AND C1.county > C2.county AND C1.population >= 25000 AND C2.population >= 25000 
JOIN county AS county1 ON C1.county = county1.fips 
JOIN county AS county2 ON C2.county = county2.fips AND county1.state = county2.state 
ORDER BY ABS(C1.population - C2.population) 
LIMIT 1;