-- Nädal 3 isiklik JOIN-analüüs
-- Roll A: Müük + kliendid (INNER JOIN)

-- 1. TOP 10 klienti kogumüügi järgi
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    COUNT(DISTINCT s.sale_id) AS ostude_arv,
    ROUND(SUM(s.total_price)::numeric, 2) AS kogumüük
FROM sales s
INNER JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY kogumüük DESC
LIMIT 10;


-- 2. Müük linnade kaupa
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS kliente,
    COUNT(s.sale_id) AS oste,
    ROUND(SUM(s.total_price)::numeric, 2) AS kogumüük
FROM sales s
INNER JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY kogumüük DESC;


-- 3. Müük loyalty_tier järgi
SELECT
    c.loyalty_tier,
    COUNT(DISTINCT c.customer_id) AS kliente,
    ROUND(SUM(s.total_price)::numeric, 2) AS kogumüük
FROM sales s
INNER JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY c.loyalty_tier
ORDER BY kogumüük DESC;


-- 4. Üle keskmise kulutajad (subquery)
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    ROUND(SUM(s.total_price)::numeric, 2) AS kogumüük
FROM sales s
INNER JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_price) > (
    SELECT AVG(kliendi_myyk)
    FROM (
        SELECT SUM(total_price) AS kliendi_myyk
        FROM sales
        GROUP BY customer_id
    ) AS keskmised
)
ORDER BY kogumüük DESC;
