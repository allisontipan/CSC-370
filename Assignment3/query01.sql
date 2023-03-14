-- Allison Tipan V00848862
-- Retrieve the state with the median number of
-- employees in 'Education Services'
-- 1.1 marks: < 10 operators
-- 1.0 marks: < 11 operators
-- 0.8 marks: correct answer


SELECT state.abbr, 
SUM(employees) AS TotalEmployees 
FROM industry 
JOIN countyindustries ON id = countyindustries.industry 
JOIN county ON county = county.fips 
JOIN state ON county.state = state.id AND industry.name =  'Educational services' 
GROUP BY state.id 
ORDER BY TotalEmployees 
LIMIT 1 
OFFSET 25;