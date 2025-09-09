/*Sample SQL queries*/
/*Countries by revenue*/
WITH revenue_tab AS(
SELECT 
    ship_country,
    ROUND(SUM((unit_price * quantity * (1 - discount))::numeric),2) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY ship_country)

SELECT 
	ship_country, 
	total_revenue,
	DENSE_RANK() OVER(
		ORDER BY total_revenue DESC) AS rank
FROM revenue_tab;

/*Average order value*/
SELECT 
    ROUND(AVG(total_revenuel), 2) AS average_order_value
FROM order_revenue;
