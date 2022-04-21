SET ECHO ON
SET LINESIZE 220
SET PAGESIZE 66
SPOOL D:\DB\Lab_11.5\Lab_11.5_output.txt



-- 1. List all authors and the value of the orders associated with the books 
-- that they wrote. Author’s get a 1% commission based on the value of the sales. 
-- Sum the value of their commissions and totals in each column. You can use 
-- grouping sets to solve this problem. Carefully note the formatting of the 
-- resultant table.

COLUMN "Value" FORMAT $99,990.00
COLUMN "Comission" FORMAT $99,990.00
SELECT INITCAP(fname || ' ' || lname) "Author Name",
SUM(quantity * paideach) "Value",
SUM(quantity * paideach) * 0.01 "Comission"
FROM author a
INNER JOIN bookauthor ba ON(ba.authorid = a.authorid)
INNER JOIN books b ON(b.isbn = ba.isbn)
INNER JOIN orderitems o ON(o.isbn = b.isbn)
GROUP BY GROUPING SETS(INITCAP(fname || ' ' || lname), ())
ORDER BY INITCAP(fname || ' ' || lname);
CLEAR COLUMNS;

-- 2. Show a total of the number of authors read by each customer. Only 
-- include customers who have read more than one author. Sort by 
-- lastname and then firstname.

SELECT INITCAP(firstname) "First",
INITCAP(lastname) "Last",
COUNT(authorid) "Number Authors"
FROM customers 
INNER JOIN orders USING(customer#)
INNER JOIN orderitems USING(order#)
INNER JOIN books USING(isbn)
INNER JOIN bookauthor USING(isbn)
GROUP BY firstname, lastname
HAVING COUNT(authorid) > 1
ORDER BY lastname, firstname;

-- 3. What is the average profit per book for each publisher? 
-- Carefully note the formatting of the resultant table.

COLUMN "Avg Profit" FORMAT $99,990.00
SELECT INITCAP(name) "Publisher",
AVG(retail - cost) "Avg Profit"
FROM publisher 
INNER JOIN books USING(pubid)
GROUP BY name
ORDER BY name;
CLEAR COLUMNS;

-- 4. Modify the previous query using grouping sets to include 
-- an average profit for all publishers.

COLUMN "Avg Profit" FORMAT $99,990.00
SELECT INITCAP(name) "Publisher",
AVG(retail - cost) "Avg Profit"
FROM publisher 
INNER JOIN books USING(pubid)
GROUP BY GROUPING SETS (name, ())
ORDER BY name;
CLEAR COLUMNS;

-- 5. Modify the previous query so that a title of ‘Total” 
-- appears for the final total. 
-- Hint: Use a Case to return ‘Total’ when pubname is null.

COLUMN "Avg Profit" FORMAT $99,990.00
SELECT CASE GROUPING(name)
            WHEN 0 THEN INITCAP(name)
            ELSE 'Total'
       END "Publisher",
AVG(retail - cost) "Avg Profit"
FROM publisher 
INNER JOIN books USING(pubid)
GROUP BY ROLLUP (name)
ORDER BY name;
CLEAR COLUMNS;






