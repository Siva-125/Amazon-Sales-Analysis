-- ----------------------------
-- Exploratory Data Analysis
-- ----------------------------

SELECT * FROM amazon_sales;

-- 1. Total Shipped, Delivered and Cancelled Orders
SELECT 
	status, 
	COUNT(status) AS Total_Orders
FROM amazon_sales
WHERE status IN ('Shipped', 'Delivered', 'Cancelled')
GROUP BY status
ORDER BY Total_Orders DESC;

-- 2. Top 5 Categories that ordered and shipped successfully
SELECT 
	category,
	COUNT(category) AS Total_sales
FROM amazon_sales
WHERE status IN ('Shipped', 'Delivered', 'Shipping', 'Shipped - Picked Up')
GROUP BY category
ORDER BY Total_sales DESC
LIMIT 5;

-- 3. Total Business to Business Orders
SELECT
	COUNT(b2b) AS total_Business_to_Business_orders
FROM amazon_sales
WHERE b2b = 'true';

-- 4. Total Easy and Self ship & success and Unsuccess orders
SELECT 
	fulfilled_by,
	CASE
		WHEN courier_status = 'Shipped' THEN 'Success'
		WHEN courier_status != 'Unshipped' THEN 'Partial'
		WHEN courier_status != 'Cancelled' THEN 'Unsuccess'
	END AS shipment_status,
	COUNT(fulfilled_by) AS Total_orders
FROM amazon_sales
GROUP BY fulfilled_by, courier_status;

-- 5. Total revenue gained by each category
SELECT
	category,
	SUM(amount)::numeric AS Total_Revenue
FROM amazon_sales
GROUP BY category
ORDER BY Total_Revenue DESC;

-- 6. Highest and Least sales month by Revenue
(
	SELECT
		month,
		SUM(amount)::numeric AS total_revenue
	FROM amazon_sales
	WHERE courier_status != 'Cancelled'
	GROUP BY month
	ORDER BY total_revenue DESC
	LIMIT 1
) UNION ALL
(
	SELECT
		month,
		SUM(amount)::numeric AS total_revenue
	FROM amazon_sales
	WHERE courier_status != 'Cancelled'
	GROUP BY month
	ORDER BY total_revenue
	LIMIT 1
);
-- 7. Least sold categories
SELECT 
	category,
	COUNT(category) AS Total_sales
FROM amazon_sales
WHERE status IN ('Shipped', 'Delivered', 'Shipping', 'Shipped - Picked Up')
GROUP BY category
ORDER BY Total_sales
LIMIT 5;

-- 8. Total expedited and standard orders
SELECT 
	ship_service_level,
	COUNT(ship_service_level) AS total_orders
FROM amazon_sales
GROUP BY ship_service_level;

-- 9. Top 3 Cities in each State by orders
SELECT ship_state,
       ship_city,
       Total_orders
FROM (
    SELECT 
        ship_state,
        ship_city,
        COUNT(*) AS Total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY ship_state 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM amazon_sales
    GROUP BY ship_state, ship_city
) ranked
WHERE rn <= 3
ORDER BY ship_state, Total_orders DESC;
