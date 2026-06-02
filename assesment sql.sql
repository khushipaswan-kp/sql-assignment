create database sales;
use sales;

select * from superstore;

##  Section A 

## Q-1 	What is the functional difference between SELECT * and specifying column names, and when is each preferred?
/*
| SELECT *                                                | Specifying Column Names               |
| ------------------------------------------------------- | ------------------------------------- |
| Retrieves all columns from a table.                     | Retrieves only the required columns.  |
| Easier for quick exploration.                           | Improves performance and readability. |
| Returns unnecessary data if the table has many columns. | Reduces network and memory usage.     |  */

-- Select all columns
SELECT *
FROM superstore;

-- Select specific columns
SELECT country,sales,profit
FROM superstore;

## Q-2 Which keyword renames a column in the output, and does this alias change the actual table structure in the database? 

##  The AS keyword is used to create an alias (temporary name).

select sales as total_sales,
       profit as net_profit
from superstore;

## Q-3 Why does wrapping a numeric value in quotes (e.g., '5000') in a WHERE clause create a data type conflict in SQL?

## Quotes make SQL treat the value as a string (VARCHAR) instead of a number.

-- Incorrect:
SELECT *
FROM superstore
WHERE Sales > '5000';

-- Correct:
SELECT *
FROM superstore
WHERE Sales > 5000;

/* Reason:
Sales is numeric.
'5000' is text.
SQL must perform implicit conversion, which can reduce performance or cause errors depending on the database engine.*/

## Q-4 Contrast the results of ORDER BY Profit DESC versus ASC when the goal is to identify the top 10 most profitable orders.

-- Descending order highest profit first
select 
      Order_ID,
      profit
from superstore
order by profit desc
limit 10;

-- Ascending order lowest profit first
select 
      Order_ID,
      profit
from superstore
order by profit
limit 10;

## Q-5 What is the T-SQL equivalent of the LIMIT clause in MS SQL Server, and why does syntax vary across SQL engines?

-- SQL
SELECT *
FROM superstore
ORDER BY Profit DESC
LIMIT 10;

-- T-SQL
SELECT TOP 10 *
FROM superstore
ORDER BY Profit DESC;

/* SQL is standardized, but database vendors implement their own extensions.
Examples:
MySQL → LIMIT
SQL Server → TOP
Oracle → ROWNUM, FETCH FIRST */

## Q-6  Explain the logical execution order of a query containing SELECT, WHERE, ORDER BY, and LIMIT clauses.

SELECT Order_ID, Sales, Profit
FROM superstore
WHERE Profit > 100
ORDER BY Profit DESC
LIMIT 10;

/* Logical Execution Order
    Step	Clause	        Purpose
	 1	     FROM	   Reads data from table
     2	     WHERE	   Filters rows
     3	    SELECT	   Chooses columns
     4	   ORDER BY	   Sorts data
     5	  LIMIT/TOP	   Returns required rows */

##  Section B 

## Q-1 Execute a query to retrieve the first 20 records from the orders table to verify data ingestion

     select * from superstore
     limit 20;
     
     
     
## Q-2 Select Order ID, Order Date, Sales, and Profit, applying a column alias to display Sales as Total_Sales
      
      ALTER TABLE superstore
             RENAME COLUMN `Order Date` TO Order_Date;
	select * from superstore;

      select 
           order_id,
           order_date,
           profit,
           sales as total_sales
		from superstore;
        
## Q-3 Filter the dataset to isolate all high-value transactions where the Sales figure exceeds 5000. 

    SELECT * FROM superstore
     WHERE Sales > 5000;

## Q-4 Generate a report of the top 10 most profitable orders by sorting the records by Profit in descending order

        SELECT Order_ID,
       Order_Date,
       Sales,
       Profit
FROM superstore
ORDER BY Profit DESC
LIMIT 10;

##  Section C 

 
## Q-1 Title: Retail Profitability & Market Segment Analysis

create database Retail_Profitability_Market_Segment_Analysis;
 
 use Retail_Profitability_Market_Segment_Analysis;
## Q-3 Dataset Recommendation: Sample Superstore Dataset 
-- (SampleSuperstore.csv) - 
-- https://www.kaggle.com/datasets/vivek468/superstore-dataset-final  

select * from superstore;

## Q-2 Problem Statement: Identify underperforming product categories and regions by analyzing the relationship between discount rates and net profit margins. 

-- Category-wise Performance (Identify Weak Categories)
SELECT Category,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit,
       ROUND(AVG(Discount),2) AS Avg_Discount,
       ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Category
ORDER BY Profit_Margin_Percent ASC;

-- Region-wise Profitability Analysis
SELECT Region,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit,
       ROUND(AVG(Discount),2) AS Avg_Discount,
       ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Region
ORDER BY Profit_Margin_Percent ASC;

-- Loss-Making Transactions
SELECT Order_ID,
       Category,
       Region,
       Sales,
       Discount,
       Profit
FROM superstore
WHERE Profit < 0
ORDER BY Profit ASC;

-- Correlation Insight (Discount Impact on Profit)

SELECT Discount,
       ROUND(AVG(Profit),2) AS Avg_Profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

## Q-4 Required Deliverables: SQL script for database schema creation, multi-condition filtering queries, 
-- aggregated performance report by region, and a summary of loss-making transactions.

-- Database Schema Creation
   create database sales;
   use sales;
   select * from superstore;

--  Multi-Condition Filtering Queries

-- High Discount + Loss Orders
SELECT Order_ID,
       Category,
       Region,
       Sales,
       Discount,
       Profit
FROM superstore
WHERE Discount >= 0.20
  AND Profit < 0
ORDER BY Discount DESC;

-- High Sales but Low Profit Orders

 SELECT Order_ID,
       Category,
       Sales,
       Profit
FROM superstore
WHERE Sales > 1000
  AND Profit < 0
ORDER BY Profit ASC;

-- Discount Above Average
SELECT *
FROM superstore
WHERE Discount > (SELECT AVG(Discount) FROM superstore);

-- Aggregated Performance Report by Region

-- Region-wise Sales & Profit Summary
SELECT Region,
       COUNT(*) AS Total_Orders,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit,
       AVG(Discount) AS Avg_Discount
FROM superstore
GROUP BY Region
ORDER BY Total_Profit ASC;

-- Region-wise Profit Margin Analysis
SELECT Region,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit,
       ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Region
ORDER BY Profit_Margin_Percent ASC;

-- Summary of Loss-Making Transactions
 use sales;
-- Total Loss Summary
SELECT COUNT(*) AS Loss_Orders,
       SUM(Profit) AS Total_Loss
FROM supertore
WHERE Profit < 0;
SHOW TABLES;

-- Top 10 Loss-Making Orders
SELECT Order_ID,
       Category,
       Region,
       Sales,
       Discount,
       Profit
FROM superstore
WHERE Profit < 0
ORDER BY Profit ASC
LIMIT 10;

-- Region-wise Loss Analysis
SELECT Region,
       COUNT(*) AS Loss_Orders,
       SUM(Profit) AS Total_Loss
FROM superstore
WHERE Profit < 0
GROUP BY Region
ORDER BY Total_Loss ASC;

/* Final Insight
This SQL analysis clearly shows that
High discounts strongly reduce profitability
Some regions consistently underperform
Loss-making orders are concentrated in high-discount segments
Profit optimization requires controlling discount strategy */