SET ECHO ON
SET LINESIZE 132
SET PAGESIZE 66
SPOOL d:\DB\lab_11.4\lab_11.4_output.txt





-- 1. Just Lee is looking at having a sale: 20% off all books except those
-- that already have a discount associated with them. Produce the sale price 
-- list. Carefully note the formatting of the columns in this report. Sort by book title.

SELECT isbn,
INITCAP(title) "Title",
NVL2(discount, 'Fixed Discount', '20% Discount') "Discount Type",
TO_CHAR(retail, '$9,990.00') "Orig Price",
TO_CHAR(NVL2(discount, discount, (retail * 0.2)), '$9,990.00') "Discount",
TO_CHAR(retail - NVL2(discount, discount, (retail * 0.2)), '$9,990.00') "Final $"
FROM books
ORDER BY 2;

-- 2. Show all customer orders. Carefully note the formatting of the columns.
COLUMN "Order Date" format a20
COLUMN "Ship Date" format a20
COLUMN "Days to Ship" format a15
SELECT INITCAP(firstname) || ' ' || INITCAP(lastname) "Customer",
order# "Order #",
TO_CHAR(orderdate, 'fmMonth DD, YYYY') "Order Date",
TO_CHAR(shipdate, 'fmMonth DD, YYYY') "Ship Date",
NVL2(shipdate, TO_CHAR(shipdate - orderdate), 'Not Shipped') "Days to Ship"
FROM customers
JOIN orders USING(customer#)
ORDER BY lastname, orderdate;
CLEAR COLUMNS;

-- 3. Show all Customer books orders and how old the book is when
-- it was ordered versus when it was published. Round the number 
-- of months old to the closest integer. Carefully note the 
-- formatting of the columns. Sort by lastname and order#.
COLUMN "Pub Date" format a9
SELECT INITCAP(firstname) || ' ' || INITCAP(lastname) "Customer",
order# "Order #",
title "Title",
TO_CHAR(orderdate, 'DD-MON-YY') "Order Date",
TO_CHAR(pubdate, 'DD-MON-YY') "Pub Date",
ROUND(MONTHS_BETWEEN(orderdate, pubdate),0) "Months old"
FROM customers
JOIN orders USING(customer#)
JOIN orderitems USING(order#)
JOIN books USING(isbn)
ORDER BY lastname, order#;
CLEAR COLUMNS;


