-- Adjust the output --
SET ECHO ON;
SET LINESIZE 132;
SET PAGESIZE 66;

-- 1.List authors --
SELECT fname AS First, 
       lname AS Last
  FROM author; 
  
-- 2.List Order Items and totals --
SELECT order# || '-' || item# AS "Order-Item #",
       isbn AS "Book ISBN",
       quantity AS "Qty",
       paideach AS "Price",
       paideach * quantity AS "Line Total",
       (paideach * quantity) * 0.05 AS "GST",
       (paideach * quantity) + ((paideach * quantity) * 0.05) AS "Total Price"
  FROM orderitems;
  
-- 3.List Author IDs --
SELECT DISTINCT authorid
  FROM bookauthor;
  
-- 4. List orders and its days took to ship --
SELECT customer# || '-' || order# AS "Cust#-Order#",
       shipdate - orderdate AS "Days to Ship"
  FROM orders;

-- 5. Show customers' information
SELECT lastname || ', ' || firstname AS "Name",
       address || ', ' || city || ', ' || state || ', ' || zip AS "Address"
  FROM customers;





