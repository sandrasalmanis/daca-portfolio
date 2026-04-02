-- Mitu toodet on kokku?
select count(*) AS "toodete_arv"
from products

--Millised veerud ja andmed on tabelis
select * from products
limit 5

--Kõik unikaalsed tootekategooriad
select distinct category
from products

--10 kallemat toodet
select product_name, category, cost_price
from products
order by cost_price desc
limit 10

select product_name, category, cost_price
from products
order by retail_price desc
limit 10

--10 odavamat
select product_name, category, cost_price
from products
order by cost_price asc
limit 10

select product_name, category, cost_price
from products
order by retail_price asc
limit 10

--Kindla kategooria tooted
select *
from products
where subcategory = 'jakid'

--puuduvad hinnad
select 
   count(*) - count(cost_price) AS "puuduvad_hinnad"
from products

select 
   count(*) - count(retail_price) AS "puuduvad_hinnad"
from products

--puuduvad kategooriad
select
count(*) - count(category) AS puuduvad_kategooriad
from products

select
count(*) - count(subcategory) AS puuduvad_kategooriad
from products

--Loetlen tootede kategooriad kokku
select category,
  count(*) AS "toodete_arv"
from products
group by category
order by toodete_arv desc

--Keskmised hinnad kategooriati
select category,
  count(*) AS "toodete_arv",  
  min(cost_price) AS "min_hind",
  max(cost_price) AS "max_hind"
  from products
  group by category
  order by max_hind desc

  select category,
  count(*) AS "toodete_arv",  
  min(retail_price) AS "min_hind",
  max(retail_price) AS "max_hind"
  from products
  group by category
  order by max_hind desc

  --Hind üle 50 kindlas kategoorias
  select
  from products
  where cost_price > 50 and subcategory='sandaalid'
  order by cost_price desc
