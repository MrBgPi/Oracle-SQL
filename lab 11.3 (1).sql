SET ECHO ON
SET LINESIZE 132
SET PAGESIZE 66
SPOOL d:\DB\lab_11.3\lab_11.3_output.txt



-- 1. Show all authors who have no book orders. Solve with NATURAL JOIN.
-- Hint: You will also need a set operator.
SELECT authorid "AUTH", fname, lname
FROM author
MINUS
SELECT authorid "AUTH", fname, lname
FROM author
NATURAL JOIN bookauthor
NATURAL JOIN orderitems
ORDER BY 1;

-- 2. Assume that the gift is based on the total value of each line 
-- item (orderitem) in an order, show the promotion gifts for each order.
-- Solve using traditional join and Join...on.

-----Solution using Traditional Join
SELECT order#, item#, title, quantity, paideach, 
quantity * paideach "Item Total", gift
FROM orderitems i, books b, promotion p
WHERE b.isbn = i.isbn
AND (quantity * paideach) BETWEEN p.minretail AND p.maxretail
ORDER BY 1,2;

-----Solution using Join...on
SELECT order#, item#, title, quantity, paideach, 
quantity * paideach "Item Total", gift
FROM orderitems i
JOIN books b ON (i.isbn = b.isbn)
JOIN promotion p ON (p.minretail <= (quantity * paideach) AND
                     p.maxretail >= (quantity * paideach))
ORDER BY 1,2;

-- 3. Show all customers and the books they have ordered. Include 
-- books that have NOT been ordered. Sort by last name, first name 
-- and book title. Solve using Traditional Join and Join...Using.

-----Solution using Traditional Join
SELECT c.customer#, firstname, lastname, title
FROM books b, orderitems i, orders o, customers c
WHERE b.isbn = i.isbn (+)
AND i.order# = o.order# (+)
AND o.customer# = c.customer# (+)
ORDER BY 3, 2, 4;


-----Solution using Join...Using
SELECT customer#, firstname, lastname, title
FROM books
LEFT OUTER JOIN orderitems USING (isbn)
LEFT OUTER JOIN orders USING (order#)
LEFT OUTER JOIN customers USING (customer#)
ORDER BY 3, 2, 4;


-- 4. Bonus Question: Find all customers who have ordered the same 
-- book as the person that referred them.
SELECT rb.firstname "FIRSTNAME", rb.lastname "LASTNAME",
c.firstname "FIRSTNAME ",  c.lastname "LASTNAME ",
b.title
FROM customers rb
JOIN customers c ON (c.referred = rb.customer#)
JOIN orders o ON (o.customer# = c.customer#)
JOIN orderitems i ON (i.order# = o.order#)
JOIN books b ON (b.isbn = i.isbn)
INTERSECT
SELECT rb.firstname "FIRSTNAME", rb.lastname "LASTNAME",
c.firstname "FIRSTNAME ",  c.lastname "LASTNAME ",
b.title
FROM customers rb
JOIN customers c ON (c.referred = rb.customer#)
JOIN orders o ON (o.customer# = rb.customer#)
JOIN orderitems i ON (i.order# = o.order#)
JOIN books b ON (b.isbn = i.isbn);

