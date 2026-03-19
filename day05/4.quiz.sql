-- 1.
SELECT o.custid, sum(saleprice) AS "TotalPrice"
  FROM  Orders o
 GROUP BY o.custid
 ORDER BY TotalPrice DESC;
  
-- 2.
SELECT c.name,o.bookid AS "책번호" ,saleprice,orderdate
  FROM Orders o
 INNER JOIN Customer c
    ON o.custid = c.custid
ORDER BY orderdate DESC, c.name ASC;


-- 3.
SELECT o.orderid, o.custid, o.bookid, o.saleprice
  FROM Orders o
 INNER JOIN Customer c
    ON o.custid = c.custid
 WHERE o.saleprice > (
 SELECT avg(saleprice)
   FROM Orders
 )
 ORDER BY o.saleprice DESC;



 
-- 4
 
SELECT c.name, sum(o.saleprice) 
  FROM Orders o
 INNER JOIN Customer c
    ON o.custid = c.custid
 GROUP BY c.custid
 HAVING sum(o.saleprice) >= 50000
  ORDER BY sum(o.saleprice)  DESC;


  






 