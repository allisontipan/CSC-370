-- Allison Tipan V00848862
-- Retrieve alphabetically the states that had
-- over 100 counties with unemployment rates above 6.0%
-- in 2008.
-- Hint: Unemployment rate = unemployed / labour force
-- 1.1 marks: <8 operators
-- 1.0 marks: <9 operators
-- 0.9 marks: <11 operators
-- 0.8 marks: correct answer


SELECT abbr 
FROM countylabourstats 
JOIN county ON countylabourstats.county = county.fips AND year = '2008' AND unemployed/labour_force > .06 
JOIN state ON county.state = state.id 
GROUP BY county.state 
HAVING COUNT(county) > 100  
ORDER BY abbr;