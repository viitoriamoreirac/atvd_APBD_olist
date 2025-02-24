-- 4.1 uso de subquery e indice para melhorar o join
EXPLAIN ANALYZE
SELECT s.seller_id, SUM(p.total_pago) AS total_vendas
FROM seller s
JOIN order_item oi ON s.seller_id = oi.seller_id
JOIN (
    SELECT o.order_id, SUM(op.payment_value) AS total_pago
    FROM `order` o
    JOIN order_payment op ON o.order_id = op.order_id
    GROUP BY o.order_id
) p ON oi.order_id = p.order_id
GROUP BY s.seller_id
ORDER BY total_vendas DESC;

-- 4.2 indice para melhorar filtragem
EXPLAIN ANALYZE
SELECT c.customer_id, SUM(op.payment_value) AS total_gasto
FROM customer c
JOIN `order` o ON c.customer_id = o.customer_id
JOIN order_payment op ON o.order_id = op.order_id
WHERE o.order_purchase_timestamp >= '2017-01-01' 
      AND o.order_purchase_timestamp < '2017-07-01'  -- Melhor para índice
GROUP BY c.customer_id
ORDER BY total_gasto DESC
LIMIT 10;

-- 4.3 uso de subquery
EXPLAIN ANALYZE
SELECT seller_id, 
       (SELECT AVG(review_score) 
        FROM order_review orw 
        JOIN order_item oi ON oi.order_id = orw.order_id
        WHERE oi.seller_id = s.seller_id) AS media_avaliacao
FROM seller s
ORDER BY media_avaliacao DESC;

-- 4.4 uso de indice e remoção de group by desncessario
EXPLAIN ANALYZE
SELECT o.order_id, c.customer_id, o.order_status, op.payment_value AS total_pago
FROM `order` o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_payment op ON o.order_id = op.order_id
WHERE o.order_purchase_timestamp >= '2017-01-01' 
      AND o.order_purchase_timestamp < '2018-01-01'; 
      
-- 4.5 uso de indice e diminuição do periodo a ser pesquisado
EXPLAIN ANALYZE
SELECT oi.product_id, COUNT(*) AS total_vendas
FROM order_item oi
JOIN `order` o ON oi.order_id = o.order_id
WHERE o.order_purchase_timestamp >= '2017-01-01' 
      AND o.order_purchase_timestamp < '2023-07-01'
GROUP BY oi.product_id
ORDER BY total_vendas DESC
LIMIT 5;


-- 4.6 uso de TIMESTAMPDIFF
EXPLAIN ANALYZE
SELECT o.order_id, 
       TIMESTAMPDIFF(DAY, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS atraso_dias
FROM `order` o
WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date
ORDER BY atraso_dias DESC
LIMIT 10;

-- 4.7 uso de indice
EXPLAIN ANALYZE
SELECT o.customer_id, SUM(op.payment_value) AS total_gasto
FROM `order` o
JOIN order_payment op ON o.order_id = op.order_id
GROUP BY o.customer_id
ORDER BY total_gasto DESC
LIMIT 10;

-- 4.8 uso de indice
EXPLAIN ANALYZE
SELECT c.customer_state, 
       AVG(TIMESTAMPDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date)) AS media_tempo_entrega
FROM customer c
JOIN `order` o ON c.customer_id = o.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY media_tempo_entrega DESC;




