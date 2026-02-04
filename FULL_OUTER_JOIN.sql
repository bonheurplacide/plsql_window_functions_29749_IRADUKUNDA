SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_id,
    p.product_name,
    o.order_id
FROM Customers c
FULL OUTER JOIN Orders o ON c.customer_id = o.customer_id
FULL OUTER JOIN Products p ON o.product_id = p.product_id;
