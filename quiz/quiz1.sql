USE sakila;
SELECT
    rating,
CASE
	WHEN length <= 60 THEN "Short"
	WHEN length <= 120 THEN "Medium"
	ELSE "Long"
END AS kategori_durasi,
COUNT(*) AS total_film,
ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY
    rating,
    CASE
        WHEN length <= 60 THEN "Short"
        WHEN length <= 120 THEN "Medium"
        ELSE "Long"
    END
ORDER BY total_film DESC;