-- Rank products by total revenue within each region
SELECT 
    p.product_id,
    p.product_name,
    c.region_id,
    SUM(o.total_amount) AS total_revenue,
    RANK() OVER(PARTITION BY c.region_id ORDER BY SUM(o.total_amount) DESC) AS revenue_rank
FROM Orders o
INNER JOIN Products p ON o.product_id = p.product_id
INNER JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY p.product_id, p.product_name, c.region_id
ORDER BY c.region_id, revenue_rank;
