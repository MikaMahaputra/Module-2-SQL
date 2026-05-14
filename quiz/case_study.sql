-- Task 1
use world;
SELECT Name
FROM country;

-- Task 2
SELECT COUNT(*) AS total_country
FROM country
WHERE Population > 100000000;

-- Task 3
SELECT Name, Population, GovernmentForm
FROM country
WHERE GovernmentForm = "Republic"
ORDER BY Population DESC
LIMIT 5;

-- Task 4
SELECT Continent, COUNT(*) AS total_country
FROM country
GROUP BY Continent
ORDER BY total_country DESC;

-- Task 5
SELECT Name, GNP
FROM country
ORDER BY GNP DESC
LIMIT 5;

-- Task 6

-- Task 7
SELECT CountryCode, Language
FROM countrylanguage
WHERE Language = "English";

-- Task 8
SELECT ROUND(AVG(LifeExpectancy), 2) AS avg_life_expectancy
FROM country;

-- Task 9
SELECT Name, IndepYear
FROM country
WHERE IndepYear >= 1900