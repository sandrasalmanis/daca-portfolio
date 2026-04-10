-- Leia duplikaatsed sale_id väärtused
SELECT
    sale_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;

-- Anna igale reale number oma grupi sees
SELECT
    sale_id,
    customer_id,
    total_price,
    sale_date,
    ROW_NUMBER() OVER (PARTITION BY sale_id ORDER BY sale_date) AS rn
FROM sales;

-- Leia kõik duplikaatsed sale_id väärtused sales tabelis
SELECT
    sale_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC
LIMIT 10;

-- Duplikaatide mõju müüginumbritele
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate,
    SUM(total_price) AS summa_duplikaatidega,
    (SELECT SUM(total_price) FROM (
        SELECT DISTINCT ON (sale_id) total_price
        FROM sales
        ORDER BY sale_id, sale_date
    ) unikaalsed) AS summa_ilma_duplikaatideta
FROM sales;

--Sama email mitu korda
SELECT * FROM (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY customer_id) AS rn
    FROM customers
    WHERE email IS NOT NULL
) numbered
WHERE rn > 1
ORDER BY email;

--Dublikaadi leidmine
SELECT email, Count(*) AS koopiate_arv
FROM customers
GROUP BY email
HAVING COUNT(*) > 1 --näitab tulemusi mis on suurem kui 1
ORDER BY koopiate_arv DESC

SELECT *
FROM customers
LIMIT 5;

-- Leia tellimused, kus klient on teadmata
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;

-- Leia kliendid, kellel ON e-mail olemas
SELECT customer_id, first_name, email
FROM customers
WHERE email IS NOT NULL;

-- Asenda puuduv kliendi nimi vaikeväärtusega
SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(email, 'puudub@urbanstyle.ee') AS email
FROM customers;

-- Mitu asendusväärtust (valib esimese mitte-NULL väärtuse)
SELECT COALESCE(NULL, NULL, 'Kolmas valik');
-- Tulemus: 'Kolmas valik'

-- NULLIF(a, b): kui a = b, tagastab NULL; muidu tagastab a
SELECT NULLIF(100, 100);  -- Tulemus: NULL
SELECT NULLIF(100, 200);  -- Tulemus: 100

-- Muuda 0-hinnaga tooted NULL-iks (hind pole tegelikult 0, vaid puudub)
SELECT
    product_id,
    product_name,
    NULLIF(cost_price, 0) AS puhas_hind
FROM products;

SELECT 100 + NULL;     -- Tulemus: NULL
SELECT NULL * 5;       -- Tulemus: NULL
SELECT SUM(total_price) FROM sales;  -- SUM ignoreerib NULL-e!

-- NULL-ide ülevaade customers tabelis
SELECT
    COUNT(*) AS kliente_kokku,
    COUNT(first_name) AS eesnimi_olemas,
    COUNT(*) - COUNT(first_name) AS eesnimi_puudub,
    COUNT(email) AS email_olemas,
    COUNT(*) - COUNT(email) AS email_puudub,
    COUNT(phone) AS telefon_olemas,
    COUNT(*) - COUNT(phone) AS telefon_puudub
FROM customers;

-- Kliendid, kellel puudub nimi VÕI e-mail
SELECT customer_id, first_name, last_name, email, city
FROM customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL
ORDER BY customer_id
LIMIT 15;

--Tühja rea asemel tundmatu klient
SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(last_name, '') AS perekonnanimi,
    COALESCE(NULLIF(email, ''), 'Puudub') AS email,
    COALESCE(phone, 'Puudub') AS telefoni_nr
FROM customers
WHERE first_name IS NULL OR first_name = ''
   OR last_name IS NULL OR last_name = ''
   OR email IS NULL OR email = ''
   OR phone IS NULL OR phone = '';

   SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(last_name, '') AS perenimi,
    COALESCE(email, 'puudub') AS email,
    COALESCE(phone, 'puudub') AS telefon,
    city
FROM customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL
   OR phone IS NULL
ORDER BY customer_id;

-- Võrdlus: SUM kõigist vs SUM mitte-NULL väärtustest
SELECT
    COUNT(*) AS ridu,
    COUNT(total_price) AS summa_olemas,
    COUNT(*) - COUNT(total_price) AS summa_puudub,
    SUM(total_price) AS kogusumma,
    AVG(total_price) AS keskmine
FROM sales;

-- CAST süntaks (standardne SQL)
SELECT CAST('125.50' AS NUMERIC);  -- Tekst -> number
SELECT CAST('2024-01-15' AS DATE); -- Tekst -> kuupäev

-- :: süntaks (PostgreSQL-i kiirviis)
SELECT '125.50'::NUMERIC;          -- Sama tulemus
SELECT '2024-01-15'::DATE;        -- Sama tulemus

SELECT CAST('pole number' AS NUMERIC);  -- VIGA!

-- Kuupäev erinevates formaatides
SELECT
    sale_date,
    TO_CHAR(sale_date, 'DD.MM.YYYY') AS eesti_formaat,
    TO_CHAR(sale_date, 'YYYY-MM-DD') AS iso_formaat,
    TO_CHAR(sale_date, 'DD. Month YYYY') AS pikk_formaat
FROM sales
LIMIT 5;

-- Tekst -> kuupäev (pead ütlema, millises formaadis tekst on)
SELECT TO_DATE('15/03/2024', 'DD/MM/YYYY');  -- Tulemus: 2024-03-15
SELECT TO_DATE('2024-01-15', 'YYYY-MM-DD');  -- Tulemus: 2024-01-15

SELECT TRIM('  Tallinn  ');  -- Tulemus: 'Tallinn'
SELECT TRIM('  ');           -- Tulemus: '' (tühi string)

SELECT UPPER('tallinn');   -- Tulemus: 'TALLINN'
SELECT LOWER('TALLINN');   -- Tulemus: 'tallinn'

-- Leia kõik unikaalsed linnade kirjaviisid
SELECT DISTINCT city
FROM customers
ORDER BY city;

-- Ühtlusta: eemalda tühikud, muuda algustäht suureks
SELECT DISTINCT
    city AS originaal,
    TRIM(city) AS trimitud,
    UPPER(TRIM(city)) AS suurtahtedega,
    INITCAP(TRIM(city)) AS esitaht_suur
FROM customers
WHERE city IS NOT NULL
ORDER BY city;

-- Kuupäevade formateerimine UrbanStyle'i andmetes
SELECT
    sale_id,
    sale_date,
    TO_CHAR(sale_date, 'DD.MM.YYYY') AS eesti_kuupaev,
    TO_CHAR(sale_date, 'Day') AS nadalapäev,
    TO_CHAR(sale_date, 'YYYY-"Q"Q') AS kvartal,
    EXTRACT(DOW FROM sale_date) AS paev_nr
FROM sales
ORDER BY sale_date DESC
LIMIT 10;

-- Linnade ühtlustamise diagnostika
SELECT
    city AS originaal,
    TRIM(city) AS trimitud,
    INITCAP(TRIM(city)) AS puhastatud,
    COUNT(*) AS kliente
FROM customers
GROUP BY city
ORDER BY city;

--Customer tabeli linnad
SELECT
    INITCAP(TRIM(city)) AS puhastatud_linn,
    COUNT(*) AS kliente,
    COUNT(DISTINCT city) AS erinevaid_kirjaviise
FROM customers
WHERE city IS NOT NULL
GROUP BY INITCAP(TRIM(city))
ORDER BY kliente DESC;

-- Kontrolli hinnaveeru tüüpi ja väärtusi
SELECT
    product_id,
    product_name,
    cost_price,
    CASE
        WHEN cost_price IS NULL THEN 'NULL'
        WHEN cost_price = 0 THEN 'NULL (0 = puudub?)'
        WHEN cost_price < 0 THEN 'NEGATIIVNE!'
        ELSE 'OK'
    END AS hinna_staatus
FROM products
WHERE cost_price IS NULL OR cost_price <= 0
ORDER BY cost_price;

SELECT
    product_id,
    product_name,
    retail_price,
    CASE
        WHEN retail_price IS NULL THEN 'NULL'
        WHEN retail_price = 0 THEN 'NULL (0 = puudub?)'
        WHEN retail_price < 0 THEN 'NEGATIIVNE!'
        ELSE 'OK'
    END AS hinna_staatus
FROM products
WHERE retail_price IS NULL OR retail_price <= 0
ORDER BY retail_price;

-- Duplikaatide ülevaade kõigis tabelites
SELECT 'sales' AS tabel,
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales
UNION ALL
SELECT 'customers',
    COUNT(*),
    COUNT(DISTINCT email),
    COUNT(*) - COUNT(DISTINCT email)
FROM customers
UNION ALL
SELECT 'products',
    COUNT(*),
    COUNT(DISTINCT product_id),
    COUNT(*) - COUNT(DISTINCT product_id)
FROM products;

--NULL väärtuste ülevaade kõigis tabelites
SELECT 'sales' AS tabel,
       COUNT(*) AS ridu_kokku,
       COUNT(*) - COUNT(invoice_id) AS puuduv_invoice_id,
       COUNT(*) - COUNT(sale_date) AS puuduv_sale_date,
       COUNT(*) - COUNT(customer_id) AS puuduv_customer_id,
       COUNT(*) - COUNT(product_id) AS puuduv_product_id,
       COUNT(*) - COUNT(store_location) AS puuduv_store_location,
       COUNT(*) - COUNT(payment_method) AS puuduv_payment_method
FROM sales
UNION ALL
SELECT 'customers' AS tabel,
       COUNT(*) AS ridu_kokku,
       COUNT(*) - COUNT(first_name) AS puuduv_first_name,
       COUNT(*) - COUNT(last_name) AS puuduv_last_name,
       COUNT(*) - COUNT(email) AS puuduv_email,
       COUNT(*) - COUNT(phone) AS puuduv_phone,
       COUNT(*) - COUNT(city) AS puuduv_city,
       COUNT(*) - COUNT(loyalty_tier) AS puuduv_loyalty_tier
FROM customers
UNION ALL
SELECT 'products' AS tabel,
       COUNT(*) AS ridu_kokku,
       COUNT(*) - COUNT(product_name) AS puuduv_product_name,
       COUNT(*) - COUNT(category) AS puuduv_category,
       COUNT(*) - COUNT(supplier) AS puuduv_supplier,
       COUNT(*) - COUNT(cost_price) AS puuduv_costprice,
       COUNT(*) - COUNT(retail_price) AS puuduv_retailprice,
       COUNT(*) - COUNT(eco_certified) AS puuduv_ecocertified
FROM products;

--Unikaalsede linnade kirjaviisid
SELECT DISTINCT
    city AS originaal,
    INITCAP(TRIM(city)) AS puhastatud
FROM customers
WHERE city IS NOT NULL
ORDER BY originaal;


--Kirjuta SQL päring, mis näitab iga linna kohta: klientide arvu, puuduvate e-mailide arvu ja protsentuaalselt, kui suur osa klientidest on puuduva e-mailiga. Kasuta customers tabelit ja grupeeri puhastatud linnanime järgi
SELECT
    INITCAP(TRIM(city)) AS linn,
    COUNT(*) AS kliente_kokku,
    COUNT(*) - COUNT(email) AS email_puudub,
    ROUND(
        100.0 * (COUNT(*) - COUNT(email)) / COUNT(*), 1
    ) AS puudub_protsent
FROM customers
GROUP BY INITCAP(TRIM(city))
ORDER BY kliente_kokku DESC;
