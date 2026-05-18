USE sakila;

SELECT
category.category_id,
category.name AS nama_kategori,
COUNT(rental.rental_id) AS total_rental
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id  = category.category_id
WHERE rental.customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) >= 10
)
GROUP BY category.category_id, category.name
ORDER BY total_rental DESC
LIMIT 5;