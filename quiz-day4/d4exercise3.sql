-- Task 1
USE sakila;

SELECT 
customer_id, 
rental_id, amount, 
payment_date
FROM payment
LIMIT 10;

-- Task 2
SELECT 
title, 
release_year, 
rental_duration
FROM film
WHERE title LIKE 'S%'
LIMIT 10;

-- Task 3
SELECT
rental_duration AS Durasi_Rental,
COUNT(*) AS Banyak_Film,
ROUND(AVG(length), 2) AS Rata_Rata_Durasi_Film
FROM film
GROUP BY rental_duration;

-- Task 4
SELECT 
title, 
length, 
rating
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length ASC
LIMIT 25;

-- Task 5
SELECT
rating AS Rating,
MAX(replacement_cost) AS Replacement_Cost_Tertinggi,
MIN(rental_rate) AS Rental_Rate_Terendah,
AVG(length) AS Rata_Rata_Durasi
FROM film
GROUP BY rating;

-- Task 6
SELECT
f.title AS Judul,
f.length AS Durasi,
l.name AS Bahasa_Film
FROM film f
JOIN language l on f.language_id = l.language_id
WHERE f.title LIKE '%K'
LIMIT 15;

-- Task 7
SELECT
f.title AS Judul_Film,
a.first_name AS First_Name,
a.last_name AS Last_Name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.actor_id = 14;

-- Task 8
SELECT 
city, 
country_id
FROM city
WHERE city LIKE '%d%'
  AND city LIKE '%a'
ORDER BY city ASC
LIMIT 15;

-- Task 9
SELECT
c.name AS Genre,
COUNT(f.film_id) AS Banyak_Film
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY Genre
ORDER BY Banyak_Film ASC;

-- Task 10
SELECT
title,
description,
length,
rating
FROM film
WHERE title LIKE '%h' AND length > (SELECT AVG(length) FROM film )
ORDER BY title ASC
limit 10;