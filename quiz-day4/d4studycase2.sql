USE sakila;

-- Task 1
SELECT
c.customer_id,
c.first_name,
c.last_name,
c.email,
COUNT(*) AS late_amount
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date > DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY)
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY late_amount DESC;

-- Task 2
SELECT
c.first_name,
c.last_name,
SUM(p.amount) AS total_sales
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sales DESC;

-- Task 3
SELECT
c.name AS genre,
COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY rental_count DESC
LIMIT 1;

-- Task 4
SELECT DISTINCT
c.first_name,
c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = (
SELECT cat2.name
FROM rental r2
JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
JOIN film_category fc2 ON i2.film_id = fc2.film_id
JOIN category cat2 ON fc2.category_id = cat2.category_id
GROUP BY cat2.name
ORDER BY COUNT(*) DESC
LIMIT 1
);

-- Task 5
SELECT
c.name AS genre,
ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) AS avg_rental_days
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE r.return_date IS NOT NULL
GROUP BY c.name
ORDER BY avg_rental_days DESC;

-- Task 6
SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL
ORDER BY f.title;

-- Task 7
SELECT
f.title,
SUM(p.amount) AS revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY revenue DESC;

-- Task 8
SELECT genre, title, revenue
FROM (
SELECT
	c.name AS genre,
	f.title,
	SUM(p.amount) AS revenue,
	RANK() OVER (PARTITION BY c.name ORDER BY SUM(p.amount) DESC) AS rnk
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, f.film_id, f.title
) ranked
WHERE rnk = 1
ORDER BY genre;

-- Task 9
SELECT
c.first_name,
c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) = (
SELECT COUNT(DISTINCT fc2.film_id)
FROM film_category fc2
JOIN category cat2 ON fc2.category_id = cat2.category_id
WHERE cat2.name = 'Action'
);

-- Task 10
SELECT
c.first_name,
c.last_name,
ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) AS avg_rental_days
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.return_date IS NOT NULL
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_rental_days DESC;