# Northwind-Dashboard
This repository contains a start-to-finish overview of building a sales dashboard for stakeholders at a fictional ‘Northwind’ shipping company. 

It combines PowerBI, PostgreSQL, GitBash and R to create succinct insights on the company's main KPIs (AOV, revenue) as well as dedicated tabs for specific categories.

<img width="1281" height="720" alt="Dashboard homepage" src="https://github.com/user-attachments/assets/c10114fa-31ca-4f5b-8501-83e38b949c5b" />

## Step 1: Setup in Postgres and using GitBash
This [GitHub repo]([url](https://github.com/pthom/northwind_psql/tree/master)) contains the raw data for hosting Northwind on a PostgresSQL database. Using GitBash and PgAdmin, I could extract, transform and load the data into a locally hosted database.

## Step 2: Data transformation and analysis
Once inside the database, I used SQL scripts to join the data based on the Northwind schema and transform the data and used CTEs and window functions to explore top-level trends like ranking countries by revenue or calculating average order value.

<details>
<summary>SQL example - Rank countries by revenue</summary>
<pre>
WITH revenue_tab AS(
SELECT 
    ship_country,
    ROUND(SUM((unit_price * quantity * (1 - discount))::numeric),2) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY ship_country)
<br>
SELECT 
    ship_country, 
    total_revenue,
    DENSE_RANK() OVER(
       ORDER BY total_revenue DESC) AS rank
FROM revenue_tab;
</details>

<details>
<summary>SQL example - Calculate average order value</summary>
<pre>
SELECT 
    ROUND(AVG(total_revenuel), 2) AS average_order_value
FROM order_revenue;
</details>

## Step 3: Dashboard development
I connected PowerBI to the database and used DAX expressions to write measures for critical KPIs like average order value (AOV) and YoY change in revenue, profits and orders. 

## Step 4: Dashboard design
Design focuses on delivering clear, summary insights at a glance. It included:
+ Clear data visualizations
+ A succinct summary page
+ Categories for key business branches (sales, inventory, customers)
+ Developing a colour palette and logo
+ Building custom visualizations in R

<p align="center">

| <img width="300" height="168" alt="1-Sales" src="https://github.com/user-attachments/assets/edb9e44d-6a5c-4f41-8699-d7fea6ffc857" /> | <img width="300" height="168" alt="2-Inventory" src="https://github.com/user-attachments/assets/2d0ff7de-ba63-4154-af90-6d40e8aea9ad" /> |
|:-------------------------:|:-------------------------:|
| <img width="300" height="168" alt="3-Dashboards" src="https://github.com/user-attachments/assets/f4c56f30-26a8-4ec3-b51f-a0d18170d9fd" /> | <img width="300" height="168" alt="4-Customers" src="https://github.com/user-attachments/assets/8af70748-0511-42ec-b3f7-4a357bd962a3" /> |

</p>

