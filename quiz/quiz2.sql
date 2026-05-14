USE world;
SELECT
    CASE
        WHEN population < 1000000 THEN "Small"
        WHEN population BETWEEN 1000000 AND 50000000 THEN "Medium"
        ELSE "Large"
    END AS pop_group,

    CASE
        WHEN lifeexpectancy >= 75 THEN "High"
        WHEN lifeexpectancy BETWEEN 60 AND 74.9 THEN "Moderate"
        ELSE "Low"
    END AS life_status,

    COUNT(*) AS total_negara,
    AVG(lifeexpectancy) AS avg_life_exp,
    AVG(gnp) AS avg_gnp

FROM country

GROUP BY
    CASE
        WHEN population < 1000000 THEN "Small"
        WHEN population BETWEEN 1000000 AND 50000000 THEN "Medium"
        ELSE "Large"
    END,

    CASE
        WHEN lifeexpectancy >= 75 THEN "High"
        WHEN lifeexpectancy BETWEEN 60 AND 74.9 THEN "Moderate"
        ELSE "Low"
    END

HAVING AVG(lifeexpectancy) > 70

ORDER BY total_negara DESC;