SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 90
SET PAGESIZE 90
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES
SET UNDERLINE OFF

SPOOL D:\DB\lab12.txt

TTITLE CENTER 'Author Comission Report' RIGHT 'Page: ' SQL.PNO SKIP 2
BTITLE OFF

BREAK ON authorname ON booktitle ON report;
COMPUTE SUM LABEL 'Author Total' OF ovalue ON authorname;
COMPUTE SUM LABEL 'Author Total' OF cvalue ON authorname;
COMPUTE SUM LABEL 'Total' OF ovalue ON report;
COMPUTE SUM LABEL 'Total' OF cvalue ON report;

COLUMN authorname FORMAT A20 HEADING 'Author Name|--------------------'
COLUMN booktitle FORMAT A39 HEADING 'Book Title  |---------------------------------------'
COLUMN ovalue FORMAT $9,990.00 HEADING 'Value of|Sales|-------------'
COLUMN cvalue FORMAT $990.00 HEADING 'Commission|-------------'

SELECT INITCAP(fname || ' ' || lname) authorname,
INITCAP(title) booktitle,
SUM(quantity * paideach) ovalue,
ROUND(SUM((quantity * paideach) * 0.01),2) cvalue
FROM author a
INNER JOIN bookauthor ba ON(ba.authorid = a.authorid)
INNER JOIN books b ON(b.isbn = ba.isbn)
INNER JOIN orderitems o ON(o.isbn = b.isbn)
GROUP BY INITCAP(fname || ' ' || lname), title
ORDER BY authorname, booktitle;


CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

SPOOL OFF




