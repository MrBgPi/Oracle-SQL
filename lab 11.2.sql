SET ECHO ON
SET LINESIZE 132
SET PAGESIZE 66
SPOOL d:\DB\lab_11.2\lab_11.2_output.txt



-- 1. Find all Computer books that whose retail price is less than $30. 
-- Also include any book published after 31-Dec-05. Sort by date published.

SELECT title AS "Title", TO_CHAR(pubdate, 'DD-MON-YY') AS "Pub Date", category AS "Category", 
retail AS "Retail Price"
FROM books
WHERE ( retail < 30 AND category = 'COMPUTER' )
   OR pubdate > to_date('31 Dec 2005', 'DD MON YYYY')
ORDER BY pubdate;

-- 2. Find all orders that have not been shipped. Sort by customer # 
-- and then order #.

SELECT order# AS "Order #", customer# AS "Customer #", 
TO_CHAR(orderdate, 'DD-MON-YY') AS "Date Ord"
FROM orders
WHERE shipdate IS NULL
ORDER BY customer#, order#;

-- 3. Find all orders shipped between April 1, 2009 and 
-- April 3, 2009 (inclusive). Don’t include orders shipped to 
-- Washington State. Sort by ship date.

SELECT order#, TO_CHAR(shipdate, 'DD-MON-YY') AS "SHIPDATE", shipstate AS "SH"
FROM orders
WHERE shipdate BETWEEN to_date('1 Apr 2009', 'DD MON YYYY') 
                   AND to_date('3 Apr 2009', 'DD MON YYYY')
  AND shipstate <> 'WA'
ORDER BY shipdate;

-- 4.  Find all books published by pubid: 2, 3 or 4. Also include books 
-- whose retail price is less than $30. Sort by book title.

SELECT title, pubid, retail
FROM books
WHERE pubid IN (2,3,4)
  OR retail < 30
ORDER BY title;

-- 5. Find all customers who have been referred by Leila Smith (1003) or 
-- have a PO Box in their address or have a domain name of 'axe.com' in 
-- their email address. Sort by customer#.

SELECT customer#, address, referred, email
FROM customers
WHERE address LIKE 'P.O. BOX%'
   OR referred = '1003'
   OR email LIKE '%@axe.com'
ORDER BY customer#;

