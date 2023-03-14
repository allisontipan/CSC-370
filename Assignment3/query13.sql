-- Allison Tipan V00848862
-- Retrieve alphabetically all states
-- with at least one hundred counties.
-- 1.1 marks: <6 operators
-- 1.0 marks: <8 operators
-- 0.8 marks: correct answer

SELECT abbr 
FROM state 
JOIN county ON state.id = county.state 
GROUP BY state 
HAVING COUNT(county.fips) >= 100 
ORDER BY abbr;
