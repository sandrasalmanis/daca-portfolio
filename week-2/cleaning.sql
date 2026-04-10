--Mitu rida on sales tabelis, praegu? 15 234 rida
SELECT Count(*) AS ridade_arv
FROM sales

-- Loon tabeli sales_test
-- Eelnevalt kustutan saes_tabeli kui on olemas

DROP TABLE sales_test;

CREATE TABLE sales_test AS 
SELECT * FROM sales;



SELECT Count(*) FROM sales_test;

SELECT * FROM sales_test limit 10;

--Kustutada midagi

DELETE 
--SELECT Count(*)
FROM sales_test
WHERE store_location = 'Tartu' 
--AND payment_method = 'sularaha'
--LIMIT 100


UPDATE sales_test
SET customer_id = 0
WHERE customer_id IS NULL;

SELECT Count(*)
FROM sales_test
WHERE customer_id IS NULL
LIMIT 10;

--Customer

CREATE TABLE customers_test AS 
SELECT * FROM customers;

SELECT Count(*)
FROM customers_test;

SELECT Count(*)
FROM customers;

--Leia dublikaadid
SELECT invoice_id, Count(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1 --näitab tulemusi mis on suurem kui 1
ORDER BY koopiate_arv DESC
LIMIT 10;

--Mitu rida on dublikaadid? 
SELECT COUNT (*) AS dublikaat_read FROM sales_test
WHERE id NOT IN (
  SELECT MIN(id) FROM sales_test GROUP BY invoice_id
);

SELECT * FROM sales_test 
LIMIT 5;

-- Enne kustutamist ridade arv
SELECT COUNT(*) AS enne FROM sales_test;

--Kustutamis lause, kustutan dublikaadid
DELETE FROM sales_test
WHERE id NOT IN (
  SELECT MIN(id) FROM sales_test GROUP BY invoice_id
);

SELECT 15234-10118;


SELECT * FROM sales_test
LIMIT 100; 

SELECT invoice_id, sale_date, COALESCE(customer_id, 0), customer_id --kuvab päringus null asemel 0
FROM sales_test
LIMIT 50;

/*
CASE
  WHEN tingimus1 THEN tulemus1
  WHEN tingimus2 THEN tulemus2
  ELSE vaikimisi_tulemus
 END 
*/

/*
CASE avaldis
  WHEN väärtus1 THEN tulemus1
  WHEN väärtus2 THEN tulemus2
  ELSE vaikimisi_tulemus
 END 
*/

SELECT sale_id, sale_date,
    case
      WHEN sale_date > CURRENT_DATE THEN 'TULEVIKUS'
      WHEN sale_date < '2024-01-01' THEN 'LIIGA VANA'
      ELSE 'OK'
    END AS kuupäeva_staatus
FROM sales_test
WHERE sale_date > CURRENT_DATE OR sale_date  < '2024-01-01';

