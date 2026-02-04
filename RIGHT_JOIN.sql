SELECT 
    p.product_id,
    p.product_name,
    o.order_id
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
