                                                         --- RETAIL SALES ANALYTICS ---

CREATE DATABASE Project1


                                                            --- CREATING A TABLE ---

CREATE TABLE  Retail_sales
             (
                transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(10),
				age INT,
				category VARCHAR(25),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			 )

SELECT * FROM RETAIL_SALES

SELECT 
     COUNT(*)
FROM RETAIL_SALES;


                                                             --- DATA CLEANING ---

SELECT * FROM retail_sales
WHERE
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or 
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantity is null 
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;


DELETE FROM retail_sales
WHERE
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or 
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantity is null 
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;



SELECT * FROM RETAIL_SALES;


                                                         --- DATA EXPLORATION ---

--How many total sales transactions are recorded?

SELECT 
     COUNT(*) AS total_transactions 
	 FROM Retail_sales;
	 

--How many individual customers have made purchases?

SELECT 
     COUNT(DISTINCT customer_id) AS Unique_customers
FROM Retail_sales;


                                               --- DATA INSIGHTS AND BUSINESS GROWTH BARRIERS & SOLUTIONS ---

--Q.1 What is the Total revenue generated?

SELECT 
     SUM(total_sale) AS Total_revenue 
	 FROM Retail_sales;


--Q.2 What’s the Average sale amount per transaction?

SELECT 
     AVG(total_sale) AS Average_transaction
	 FROM Retail_sales;
	 

--Q.3 How many sales were made by male vs female customers?

SELECT gender, 
            COUNT(*) AS sales_count
FROM Retail_sales
GROUP BY gender;


--Q.4 Find all transactions where the total_sale is greater than "1000"?

SELECT * 
FROM retail_sales
WHERE total_sale > 1000


--Q.5 Which sales transactions occurred on "2022-11-05"?

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


--Q.6 What is the Percentage of male vs female customers?

SELECT gender, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Retail_sales) AS percentage
FROM Retail_sales
GROUP BY gender;


--Q.7 Find out the top 5 customers based on the highest total sales?

SELECT 
    customer_id,
    SUM(total_sale) as total_spent
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q.8 How does the total sales for each category?

SELECT 
     category,
     SUM(total_sale) as Net_sale,
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--Q.9 What is the revenue generated by each age group (e.g., 10-year intervals)?

SELECT 
     FLOOR(age / 10) * 10 AS age_group, 
	 SUM(total_sale) AS Revenue
FROM Retail_sales
GROUP BY age_group
ORDER BY age_group;


--Q.10 Find the average age of customers who purchased items from the 'Electronics' category?

SELECT
     ROUND(AVG (age),2) AS AVERAGE_AGE
FROM retail_sales
WHERE category = 'Electronics'


--Q.11 Find out the total number of transactions made by each gender in each category?

SELECT 
    category,
    gender,
    COUNT(*) as total_transactions
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY 1


--Q.12 Which Category has highest quantity sold?

SELECT 
     category, 
     SUM(quantity) AS total_quantity
FROM Retail_sales
GROUP BY category
ORDER BY total_quantity DESC
LIMIT 1;


--Q.13 Which day has the highest revenue occured?

SELECT 
     EXTRACT(HOUR FROM sale_time) AS hour, 
	 SUM(total_sale) AS total_sales
FROM Retail_sales
GROUP BY hour
ORDER BY hour;


--Q.14 What’s the month-wise revenue distribution?

SELECT 
     TO_CHAR(sale_date, 'YYYY-MM') AS month, 
	 SUM(total_sale) AS monthly_revenue
FROM Retail_sales
GROUP BY month
ORDER BY month;


--Q.15 Find out each shift and number of orders (Eg. Morning <12, Afternoon Between 12 & 17, Evening >17)?
SELECT 
     CASE 
     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
     WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
     ELSE 'Evening'
     END AS shift,
     COUNT(*) AS order_count
FROM Retail_sales
GROUP BY 1;



                                                              --- END OF ANALYSIS ---
