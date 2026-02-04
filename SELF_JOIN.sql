SELECT 
    c1.customer_id AS customer1_id,
    c1.first_name || ' ' || c1.last_name AS customer1_name,
    c2.customer_id AS customer2_id,
    c2.first_name || ' ' || c2.last_name AS customer2_name,
    c1.region_id
FROM Customers c1
INNER JOIN Customers c2 
    ON c1.region_id = c2.region_id
    AND c1.customer_id < c2.customer_id;
