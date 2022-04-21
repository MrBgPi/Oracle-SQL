SET ECHO ON
SET LINESIZE 220
SET PAGESIZE 66
SPOOL D:\DB\Lab_11.6\Lab_11.6_output.txt




-- 1. Which customers ordered the same books as customers in Texas? 
-- Show the book title, state and customer #. 

COLUMN title FORMAT A30
SELECT state "ST", 
customer#, 
title
FROM orderitems
JOIN orders USING(order#)
JOIN customers USING(customer#)
JOIN books USING(isbn)
WHERE isbn IN (SELECT isbn
				FROM orderitems
				JOIN orders USING(order#)
				JOIN customers USING(customer#)
				JOIN books USING(isbn)
				WHERE state = 'TX')
AND state != 'TX'
ORDER BY title, state;
CLEAR COLUMNS;


-- 2. Which books have been ordered by customers in greatest
-- number of different states?
-- List all the titles and the states the books has been ordered in.

SELECT DISTINCT title, state
FROM orderitems
JOIN orders USING(order#)
JOIN customers USING(customer#)
JOIN books USING(isbn)
WHERE isbn IN (SELECT isbn
			   FROM orderitems
			   JOIN orders USING(order#)
			   JOIN customers USING(customer#)
			   GROUP BY isbn
			   HAVING COUNT(DISTINCT state) >= (SELECT MAX(COUNT(DISTINCT state)) "ST"
							        			FROM orderitems
							        			JOIN orders USING(order#)
							        			JOIN customers USING(customer#)
							        			GROUP BY isbn))
ORDER BY title, state;


-- 3. Which books were ordered the most?
			
COLUMN title FORMAT A30
SELECT title
FROM orderitems
JOIN books USING(isbn)
GROUP BY title 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) "Count"
				   FROM orderitems
				   JOIN books USING(isbn)
				   GROUP BY isbn);
CLEAR COLUMNS;


-- 4. What was the most recent book ordered in each category and when was it ordered?

SELECT DISTINCT category,
title,
TO_CHAR(orderdate, 'DD-MON-YY') "ORDERDATE"
FROM orders o,
orderitems oi,
books b
WHERE o.order# = oi.order#
AND b.isbn = oi.isbn
AND o.orderdate = (SELECT MAX(orderdate)
					FROM orders
					JOIN orderitems USING(order#)
					JOIN books USING(isbn)
					WHERE category = b.category
					GROUP BY category)
ORDER BY category;


-- 5. Which customers have ordered books that NO other customer has ordered? 
-- Show the customer and the title.

SELECT customer#,
title 
FROM orderitems oi
JOIN orders o USING(order#)
JOIN books b USING(isbn)
WHERE isbn NOT IN (SELECT isbn 
				   FROM orderitems
				   JOIN orders USING(order#)
				   WHERE customer# <> o.customer#)
ORDER BY customer#;


