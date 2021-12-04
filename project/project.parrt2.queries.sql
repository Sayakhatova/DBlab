---
SELECT orders.store_id, products.UPC_code, products.name, sum(orders.amount)
FROM orders JOIN products ON orders.upc_code = products.upc_code
GROUP BY orders.store_id, products.UPC_code, products.name
ORDER BY sum(orders.amount) DESC
LIMIT 20;
---
SELECT store.city, count(orders.amount)
FROM store JOIN orders ON store.store_id = orders.store_id
GROUP BY store.city
ORDER BY count(orders.amount) DESC
LIMIT 20;
---
SELECT orders.store_id, products.UPC_code, products.name, sum(orders.amount), orders.date
FROM orders JOIN products ON orders.upc_code = products.upc_code
WHERE orders.date <= now()
GROUP BY orders.store_id, products.UPC_code, products.name, orders.date
ORDER BY orders.date DESC
LIMIT 5;
---
SELECT store.city, sum(orders.amount)
FROM store JOIN orders ON store.store_id = orders.store_id
GROUP BY store.city
ORDER BY sum(orders.amount) DESC
LIMIT 3;