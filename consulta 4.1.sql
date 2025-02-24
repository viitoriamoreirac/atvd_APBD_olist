SELECT s.seller_id, SUM(op.payment_value) AS total_vendas
FROM seller s
JOIN order_item oi ON s.seller_id = oi.seller_id
JOIN `order` o ON oi.order_id = o.order_id
JOIN order_payment op ON o.order_id = op.order_id
GROUP BY s.seller_id
ORDER BY total_vendas DESC;