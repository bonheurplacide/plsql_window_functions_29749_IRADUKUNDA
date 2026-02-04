-- Segment customers into quartiles based on total spending
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent,
    NTILE(4) OVER(ORDER BY SUM(o.total_amount) DESC) AS spending_quartile,
    CUME_DIST() OVER(ORDER BY SUM(o.total_amount) DESC) AS cumulative_distribution
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;
