-- 1247 rida (iga tellimus eraldi)
SELECT sale_date, total_price
FROM sales;

-- 12 rida (iga kuu summa)
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- Müük kuude kaupa 2024. aastal
SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS kuu,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS käive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY kuu;

-- Müük linnade kaupa
SELECT 
    c.city,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS kogukäive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY kogukäive DESC;

SELECT
    c.city AS linn,
    COUNT(s.sale_id) AS tellimuste_arv,
    SUM(s.total_price) AS kogukaive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY kogukaive DESC;

-- Müük nädalapäevade kaupa
SELECT 
    TO_CHAR(sale_date, 'Day') AS päev,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS käive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
GROUP BY TO_CHAR(sale_date, 'Day')
ORDER BY päev;

--Toodete arv kategooriate kaupa
SELECT
    category,
    COUNT(*) AS toodete_arv
FROM products
GROUP BY category
ORDER BY toodete_arv DESC;

--Tellimused staatuse(paymentmethhod) järgi
SELECT
    c.customer_id,
    c.first_name,
    s.payment_method,
    COUNT(*) AS tellimuste_arv
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, s.payment_method
ORDER BY c.first_name;

SELECT
    payment_method,
    COUNT(*) AS tellimuste_arv
FROM sales
GROUP BY payment_method
ORDER BY tellimuste_arv DESC;

-- WHERE: ainult 2024. aasta tellimused
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS käive
FROM sales
WHERE sale_date >= '2024-01-01'  -- Filtreer ENNE grupeerimist
GROUP BY DATE_TRUNC('month', sale_date);

-- HAVING: ainult linnad, kus tellimusi > 10
SELECT
    c.city AS linn,
    COUNT(s.sale_id) AS tellimusi,
    SUM(s.total_price) AS kogukäive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date >= '2024-01-01'     -- WHERE: filtreer read
GROUP BY c.city
HAVING COUNT(s.sale_id) > 10          -- HAVING: filtreer gruppe
ORDER BY kogukäive DESC;

--Kliendid üle 500 ostud
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nimi,
    COUNT(s.sale_id) AS tellimuste_arv,
    SUM(s.total_price) AS kogukäive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_price) > 500
ORDER BY kogukäive DESC;

--Kategooria kus on ostetud üle 200 euri
SELECT
    p.category,
    SUM(s.quantity) AS muudud_kogus,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind,
    COUNT(DISTINCT p.product_id) AS toodete_arv
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity) > 200
ORDER BY muudud_kogus DESC;

SELECT
    p.category AS kategooria,
    SUM(s.quantity) AS müüdud_kokku,
    ROUND(AVG(p.price), 2) AS keskmine_hind,
    COUNT(DISTINCT p.product_id) AS toodete_arv
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity) > 50
ORDER BY müüdud_kokku DESC;

--Kuu käive ja kasv
WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    käive,
    LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,
    käive - LAG(käive) OVER (ORDER BY kuu) AS kasv
FROM kuu_myyk
ORDER BY kuu;

--Mitu CTE-d koos
WITH kliendiinfo AS (
    SELECT customer_id, first_name || ' ' || last_name AS nimi, city
    FROM customers
),
kliendi_tellimused AS (
    SELECT
        customer_id,
        COUNT(sale_id) AS tellimusi,
        SUM(total_price) AS kogukäive
    FROM sales
    GROUP BY customer_id
)
SELECT
    k.nimi, k.city,
    kt.tellimusi, kt.kogukäive,
    CASE
        WHEN kt.kogukäive > 1000 THEN 'VIP'
        WHEN kt.kogukäive > 500 THEN 'Aktiivne'
        ELSE 'Tavaline'
    END AS segment
FROM kliendiinfo k
JOIN kliendi_tellimused kt ON k.customer_id = kt.customer_id
ORDER BY kt.kogukäive DESC;

--Kuu käive ja kasv
WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    käive,
    LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,
    käive - LAG(käive) OVER (ORDER BY kuu) AS kasv,
    ROUND(
        100.0 * (käive - LAG(käive) OVER (ORDER BY kuu))
        / LAG(käive) OVER (ORDER BY kuu), 1
    ) AS kasv_protsent
FROM kuu_myyk
ORDER BY kuu;

--Segmenteeri kliendid VIP/Aktiive/Tavaline tase
WITH kliendi_kokkuvote AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS nimi,
        c.city,
        COUNT(s.sale_id) AS tellimuste_arv,
        SUM(s.total_price) AS kogukaive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.city
)
SELECT
    nimi,
    city,
    tellimuste_arv,
    kogukaive,
    CASE
        WHEN kogukaive > 20000 THEN 'VIP'       -- Vali ise piir!
        WHEN kogukaive > 15000 THEN 'Aktiivne'  -- Vali ise piir!
        ELSE 'Tavaline'
    END AS segment
FROM kliendi_kokkuvote
ORDER BY kogukaive DESC;

--Iga kategooria TOP 3
WITH toodete_müük AS (
    SELECT
        p.category,
        p.product_name,
        SUM(s.quantity) AS müüdud_kogus,
        ROW_NUMBER() OVER (
            PARTITION BY p.category
            ORDER BY SUM(s.quantity) DESC
        ) AS koht
    FROM products p
    JOIN sales s ON p.product_id = s.product_id
    GROUP BY p.category, p.product_name
)
SELECT
    category,
    product_name,
    müüdud_kogus,
    koht
FROM toodete_müük
WHERE koht <= 3
ORDER BY category, koht;

--TOP 5 linna koos igakuise trendiga
WITH linna_myyk AS (
    -- CTE 1: iga linna kogumüük
    SELECT
        c.city AS linn,
        COUNT(DISTINCT s.sale_id) AS tellimusi,
        SUM(s.total_price) AS kogukaive,
        ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city
    HAVING COUNT(DISTINCT s.sale_id) > 5  -- Filtreeri välja väikesed linnad
),
linna_jarjestus AS (
    -- CTE 2: lisa järjestus
    SELECT
        linn,
        tellimusi,
        kogukaive,
        keskmine_tellimus,
        ROW_NUMBER() OVER (ORDER BY kogukaive DESC) AS koht
    FROM linna_myyk
)
SELECT *
FROM linna_jarjestus
WHERE koht <= 5
ORDER BY koht;

--TOP 5 igakuine trend

WITH linna_myyk AS (
    SELECT
        c.city AS linn,
        COUNT(DISTINCT s.sale_id) AS tellimusi,
        SUM(s.total_price) AS kogukaive,
        ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city
    HAVING COUNT(DISTINCT s.sale_id) > 5
),
linna_jarjestus AS (
    SELECT
        linn,
        tellimusi,
        kogukaive,
        keskmine_tellimus,
        ROW_NUMBER() OVER (ORDER BY kogukaive DESC) AS koht
    FROM linna_myyk
),
kuu_trend AS (
    SELECT
        c.city AS linn,
        DATE_TRUNC('month', s.sale_date) AS kuu,
        SUM(s.total_price) AS kuu_kaive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city, DATE_TRUNC('month', s.sale_date)
)
SELECT
    lj.linn,
    lj.tellimusi,
    lj.kogukaive,
    lj.keskmine_tellimus,
    lj.koht,
    kt.kuu,
    kt.kuu_kaive
FROM linna_jarjestus lj
JOIN kuu_trend kt ON lj.linn = kt.linn
WHERE lj.koht <= 5
ORDER BY lj.koht, kt.kuu;

--Iga linna osakaal kogu käibest (protsentides)
WITH linna_myyk AS (
    SELECT
        c.city AS linn,
        COUNT(DISTINCT s.sale_id) AS tellimusi,
        SUM(s.total_price) AS kogukaive,
        ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city
    HAVING COUNT(DISTINCT s.sale_id) > 5
),
linna_jarjestus AS (
    SELECT
        linn,
        tellimusi,
        kogukaive,
        keskmine_tellimus,
        ROUND(100.0 * kogukaive / SUM(kogukaive) OVER (), 2) AS osakaal_protsentides,
        ROW_NUMBER() OVER (ORDER BY kogukaive DESC) AS koht
    FROM linna_myyk
)
SELECT
    linn,
    tellimusi,
    kogukaive,
    keskmine_tellimus,
    osakaal_protsentides,
    koht
FROM linna_jarjestus
WHERE koht <= 5
ORDER BY koht;

--Viimase kuu käive vs ülejäänud kuude keskmine
WITH kuu_myyk AS (
    SELECT
        c.city AS linn,
        DATE_TRUNC('month', s.sale_date) AS kuu,
        SUM(s.total_price) AS kuu_kaive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city, DATE_TRUNC('month', s.sale_date)
),
vordlus AS (
    SELECT
        linn,
        MAX(CASE 
            WHEN kuu = (SELECT MAX(kuu) FROM kuu_myyk) 
            THEN kuu_kaive 
        END) AS viimase_kuu_kaive,
        
        ROUND(AVG(CASE 
            WHEN kuu < (SELECT MAX(kuu) FROM kuu_myyk) 
            THEN kuu_kaive 
        END), 2) AS varasemate_kuude_keskmine
    FROM kuu_myyk
    GROUP BY linn
)
SELECT *
FROM vordlus
ORDER BY viimase_kuu_kaive DESC;

--TOP 3 kategooriat kogumüügi järgi
SELECT
    p.category,
    SUM(s.quantity * s.unit_price) AS kogumuuk
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY kogumuuk DESC
LIMIT 3;
