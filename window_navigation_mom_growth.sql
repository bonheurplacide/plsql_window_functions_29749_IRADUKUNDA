-- Compare current month sales to previous month
SELECT 
    c.region_id,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) AS current_month_sales,
    LAG(SUM(o.total_amount)) OVER(
        PARTITION BY c.region_id 
        ORDER BY DATE_TRUNC('month', o.order_date)
    ) AS previous_month_sales,
    SUM(o.total_amount) - LAG(SUM(o.total_amount)) OVER(
        PARTITION BY c.region_id 
        ORDER BY DATE_TRUNC('month', o.order_date)
    ) AS month_over_month_growth
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.region_id, DATE_TRUNC('month', o.order_date)
ORDER BY c.region_id, month;
