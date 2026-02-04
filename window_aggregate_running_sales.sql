-- Calculate cumulative monthly sales per region
SELECT 
    c.region_id,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) OVER(
        PARTITION BY c.region_id 
        ORDER BY DATE_TRUNC('month', o.order_date) 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_monthly_sales
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region_id, DATE_TRUNC('month', o.order_date)
ORDER BY c.region_id, month;
