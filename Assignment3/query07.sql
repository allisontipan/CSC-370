-- Allison Tipan V00848862
-- Show which county has the largest relative population decrease
-- from 2010 to 2019.
-- 1.1 marks: <11 operators
-- 1.0 marks: <13 operators
-- 0.9 marks: <16 operators
-- 0.8 marks: correct answer


SELECT name, 
Pop2010.population AS `2010`, 
Pop2019.population AS `2019`, 
abbr, 
(Pop2010.population - Pop2019.population)/Pop2010.population*100 AS `Loss (%)` 
FROM county 
JOIN countypopulation AS Pop2010 ON county.fips = Pop2010.county AND Pop2010.year = '2010' 
JOIN countypopulation AS Pop2019 ON county.fips = Pop2019.county AND Pop2019.year = '2019' 
JOIN state ON county.state = state.id 
ORDER BY `Loss (%)` DESC 
LIMIT 1;