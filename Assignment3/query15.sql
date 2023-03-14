-- Allison Tipan V00848862
-- Show the percentage of counties that have more
-- females than males.
-- 1.1 marks: <8 operators
-- 1.0 marks: <10 operators
-- 0.9 marks: <13 operators
-- 0.8 marks: correct answer


SELECT COUNT(Females.county)/3142 AS `Fraction`
FROM 
	(SELECT * 
	FROM genderbreakdown 
	WHERE gender = 'female') AS Females 
JOIN 
	(SELECT * 
	FROM genderbreakdown 
	WHERE gender = 'male') AS Males 
ON Females.county = Males.county AND Females.population > Males.population;
