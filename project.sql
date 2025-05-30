create database superstore;
use superstore;

--  SALES & PROFIT ANALYSIS

-- 1. Top 10 products by sales?
 
select productName ,sum(od.sales) from products p join order_details od 
on p.productID=od.productID 
group by productName
order by sum(od.sales) desc limit 10;

-- 2. Which 5 sub-categories are generating losses?

select subcategory , sum(od.sales) from products p join order_details od
using(productID)
group by SubCategory
order by sum(od.sales) limit 5;

-- 3. What is the average profit margin per product category?

select category,sum(profit)/sum(sales)*100 as profit_margin from products p join order_details od
using(productId)
group by Category
order by profit_margin desc limit 5;


-- Customer & Region Insights

-- 4. Which customer segments bring in the most revenue and profit?

SELECT 
  c.Segment,
  SUM(od.Sales) AS TotalSales,
  SUM(od.Profit) AS TotalProfit FROM Order_Details od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Segment
ORDER BY TotalSales DESC;


-- 5. Top 5 Customers by Total Profit

SELECT 
  c.CustomerName,
  SUM(od.Profit) AS TotalProfit
FROM Order_Details od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalProfit DESC
LIMIT 5;

-- 6. sales vs profit by region?

SELECT 
  c.Region,
  SUM(od.Sales) AS TotalSales,
  SUM(od.Profit) AS TotalProfit
FROM Order_Details od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY TotalSales DESC;


-- ️ Time-Based Trends

-- 7. What are the monthly sales trends over the last 2–3 years?


SELECT 
  DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
  SUM(od.Sales) AS MonthlySales
FROM Order_Details od
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY Month
ORDER BY Month;

-- 8. Most Used and Most Profitable Shipping Mode?

SELECT 
  o.ShipMode,
  COUNT(*) AS TotalOrders,
  SUM(od.Sales) AS TotalSales,
  SUM(od.Profit) AS TotalProfit
FROM Order_Details od
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.ShipMode
ORDER BY TotalOrders DESC;


-- 9.discount vs profit
SELECT Discount, AVG(Profit) AS AvgProfit
FROM Order_details
GROUP BY Discount
ORDER BY Discount;

-- 10. Sales distibution on categorys

select category,sum(sales) as total_sale from products p join order_details od
using(productID)
group by category 
order by total_sale desc limit 8;
