Create database Ecommerce_Retail_Sales_Data;
use Ecommerce_Retail_Sales_Data;

-- Import table Sucessfully


-- Data Understanding Queries
select * 
from sales_data limit 10;

select count(*)
from sales_data;

alter table sales_data
rename column `Product Name` to Product_Name;

select *
from sales_data 
where Order_Date is null
 or Product_Name is null
 or Sales is null;
 
-- Overall Business Performance

-- Total Sales
select sum(Sales) as total_sales
from sales_data;

-- Total Profit
select round(sum(Profit), 2) as total_profit
from sales_data;

Create database Ecommerce_Sales;
use Ecommerce_sales;

-- Import table Sucessfully

-- Data Understanding Queries
select * 
from sales_data limit 10;

select count(*)
from sales_data;

alter table sales_data
rename column `Product Name` to Product_Name;

select *
from sales_data 
where Order_Date is null
 or Product_Name is null
 or Sales is null;
 
-- Overall Business Performance

-- Total Sales
select sum(Sales) as total_sales
from sales_data;

-- Total Profit
select round(sum(Profit), 2) as total_profit
from sales_data;

-- Total Quantity Sold
select sum(Quantity) as total_quantity
from sales_data;

-- Average Order Value
select round(avg(Sales), 2) as avg_order_value
from sales_data;


-- Product Analysis

-- Top Selling Product
select Product_Name, sum(sales) as total_sales
from sales_data
group by Product_Name
order by total_sales  desc;

-- Most Profitable Products
select Product_Name, round(sum(Profit), 2) as total_profit
from sales_data
group by Product_Name
order by total_profit desc;

-- Least Profitable Products
select Product_Name, round(sum(Profit), 2) as total_profit
from sales_data
group by Product_Name
order by total_profit asc;


-- Category Analysis

-- Sales by Category
select Category, sum(Sales) as total_sales
from sales_data
group by Category
order by total_sales;

-- Profit by Category
select Category, round(sum(Profit), 2) as total_profit
from sales_data
group by Category
order by total_profit;

-- Category by Profit Margin
select Category,
round(sum(profit)/sum(Sales) * 100, 2) as profit_margin
from sales_data
group by Category;

-- Regional Performance Analysis

-- Sales by region
select Region, sum(Sales) as total_sales
from sales_data
group by Region
order by total_sales desc;

-- Profit by Region
select Region,round(sum(Profit), 2) as total_profit
from sales_data
group by Region
order by total_profit desc;

-- Best Performing Region
select Region, round(sum(Profit), 2) as Profit
from Sales_data
group by region
order by Profit desc
limit 1;

-- Loss Analysis

-- Loss Making Orders
select *
from sales_data
where Profit < 0;

-- Loss Making Products
select Product_Name, round(sum(Profit), 2) as total_loss
from sales_data
where Profit < 0
group by Product_Name;

-- Loss by Region
select Region, round(sum(Profit), 2) as Total_loss
from sales_data
where Profit < 0
group by Region;


-- Date Error Cleaning
select * from sales_data
where Order_Date;

SELECT DATE_FORMAT(Order_Date, '%d/%m/%Y') AS Order_Date
FROM sales_data;

DESCRIBE sales_data;

UPDATE sales_data
SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y')
WHERE Order_Date IS NOT NULL;

SELECT 
DATE_FORMAT(Order_Date, '%d/%m/%Y') AS Order_Date
FROM sales_data;


-- Time-Based Analysis

-- Yearly Sales
select year(Order_Date) as year,
sum(sales) as yearly_sales
from yearly_data
group by year;

-- Monthly Sales Trend
select year(Order_Date) as year,
month(Order_Date) as month,
sum(Sales) as Monthly_Sales
from sales_data
group by year, month
order by year, month;

-- Monthly Profit Trend
select month(Order_Date) as month,
round(sum(Profit), 2) as monthly_profit
from sales_data
group by month 
order by monthly_profit desc;

-- Quantity Analysis
select Product_Name, sum(Quantity) as total_quantity
from sales_data
group by Product_Name
order by total_quantity  desc;


-- Profit Margin Analysis
SELECT Product_Name,
       round(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin
FROM sales_data
GROUP BY Product_Name
ORDER BY Profit_Margin DESC;

-- Top 5 Products
select * from (
select Product_Name,
sum(Sales) as total_sales,
rank() over(order by sum(Sales) desc) rnk
from sales_data
group by Product_Name)
ranked
where rnk <=5;

-- Region-wise Ranking
select Region,
sum(Sales) as total_sales,
rank() over(order by sum(Sales) desc) rank_no
from sales_data
group by region;

-- Running Total Sales
select Order_Date,
sum(Sales) over(order by Order_Date) as running_total
from sales_data;


-- Business Recommendation Queries

-- Best Category per Region
select Region, Category,
sum(Sales) as total_sales
from Sales_data
group by Region, Category
order by Region, total_sales desc;

-- High Revenue but Low Profit Products
select Product_Name,
sum(Sales) as Sales,
round(sum(Profit), 2) as Profit
from sales_data
group by Product_Name
having sales > 10000 and profit > 1000;


