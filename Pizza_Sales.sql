--Calculate the Total Revenue from dataset.
select SUM(total_price) as Total_Revenue 
from pizza_sales;

select * from pizza_sales;

--Calculate the Average Order Value
select SUM(total_price) / COUNT(distinct order_id) as Avg_Order_Value 
from pizza_sales;

--Calculate the Total Amount of Pizza Sold
select SUM(quantity) as Total_Pizza_Sold 
from pizza_sales;

--Calculate Total Orders
select COUNT(distinct order_id) as Total_Orders 
from pizza_sales;

--Calculate Average Pizzas Per Order
select CAST(CAST(SUM(quantity) as decimal(10,2)) /
CAST(COUNT(distinct order_id) as decimal(10,2)) as decimal(10,2))
as Avg_Pizzas_Per_Order
from pizza_sales;

--Daily Trend for Total Orders;
select DATENAME(DW, order_date) as order_day, COUNT(distinct order_id) 
as total_orders
from pizza_sales
group by DATENAME(DW, order_date);

--Monthly Trend for Orders
select DATENAME(MONTH, order_date) as Month_Name, COUNT(distinct order_id) 
as total_orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by total_orders desc;

--Calculate Percent of Sales by Pizza Category
select pizza_category, CAST(SUM(total_price) as decimal(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales) 
as decimal(10,2)) as PCT
from pizza_sales
group by pizza_category;

--Calculate Percent of Sales by Pizza Size
select pizza_size, CAST(SUM(total_price) as decimal(10,2)) 
as total_revenue,
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)
as decimal(10,2)) as PCT
from pizza_sales
group by pizza_size
order by pizza_size;

--Total Pizzas Sold by Pizza Category
select pizza_category, SUM(quantity) as Total_Quantity_Sold
from pizza_sales
--Filters Total pizzas sold depending on month.
--where MONTH(order_date) = 3
group by pizza_category
order by Total_Quantity_Sold desc;

--Total 5 Pizzas by Revenue
select top 5 pizza_name, SUM(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

--Total Bottom 5 Pizzas by Revenue
select top 5 pizza_name, SUM(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc;

--Top 5 Pizzas by Quantity
select top 5 pizza_name, SUM(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc;

--Bottom 5 Pizzas by Quantity
select top 5 pizza_name, SUM(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc;

--Top 5 Pizzas by Total Orders
select top 5 pizza_name, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc;

--Bottom 5 Pizzas by Total Orders 
select top 5 pizza_name, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders asc;


select * from pizza_sales;
