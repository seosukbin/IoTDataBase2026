-- 뷰

SELECT c.custid,c.name, b.bookid, b.price, o.orderid, o.saleprice
  FROM Customer c
  JOIN Orders o
    ON c.custid = o.custid
  JOIN Book b
    ON o.bookid = b.bookid;

-- view 생성전
SELECT *
  FROM (SELECT c.custid,c.name, b.bookid, b.price, o.orderid, o.saleprice
  FROM Customer c
  JOIN Orders o
    ON c.custid = o.custid
  JOIN Book b
    ON o.bookid = b.bookid)v
 WHERE v.custid = 4;  
 -- view 생성 후
CREATE VIEW v_orders AS 
SELECT c.custid,c.name, b.bookid, b.price, o.orderid, o.saleprice
  FROM Customer c
  JOIN Orders o
    ON c.custid = o.custid
  JOIN Book b
    ON o.bookid = b.bookid;

SELECT *
  FROM v_orders v
 WHERE v.custid = 4;

SELECT v.name, v.price, v.saleprice, v.orderid, v.saleprice
  FROM v_orders v;

CREATE VIEW v_book AS  
SELECT *
  FROM Book;

INSERT INTO v_book
VALUES (40,'에일리언 어스','파라마운트미디어',20000);

UPDATE v_book
   SET publisher = '20세기미디어'
 WHERE bookid = 40;

CREATE OR REPLACE VIEW v_orders AS
SELECT c.custid,c.name, b.bookid, b.price, o.orderid, o.saleprice
  FROM Customer c
  JOIN Orders o
    ON c.custid = o.custid
  JOIN Book b
    ON o.bookid = b.bookid;

