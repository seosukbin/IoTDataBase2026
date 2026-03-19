-- 두개 이상의 테이블에서 select

SELECT *
  FROM Customer c, Orders o;

-- 테이블이 관련 있는 데이터로 합쳐서 SELECT JOIN

-- NATURAL,join,inner join, join

-- 고객과 고객 주문에 대한 데이터르 모두 조회 하시오
SELECT *
  FROM Customer c, Orders o
 WHERE c.custid = o.custid;

SELECT c.*
	 , o.orderid
	 , o bookid
	 , o.orderd
	 , o.salceprice
	   FROM Customer c, Orders o
 WHERE c.custid = o.custid;
 
select c*
    , o.orderid
 	, o.bookid
 	, o.orderdate
 	, o.saleprice
 	FROM Customer , Orders o
 	Where Customer c, Orders o

select c.*
    , o.orderid
 	, o.bookid
 	, o.orderdate
 	, o.saleprice
 	FROM Customer c
 	inner join Orders o
 	on c.custid = o.custid;
-- Sql 표준 join
select c.*
    , o.orderid
 	, o.bookid
 	, o.orderdate
 	, o.saleprice
 FROM Customer c
 inner join Orders o
on c.custid = o.custid
where c.custid = 3;

SELECT  c.name, o.saleprice
  FROM  Customer c
 INNER  JOIN Orders o
    on  c.custid = o.custid
 GROUP  BY c.name
 ORDER  BY c.name;

-- 세 테이블을 조인해서 각 고객과 도서명을 모두 조회하시오
-- inner join은 두 테이블을 연결해서 같은 값이 있는 것만 조회한다.
-- customer table과 book 테이블간의 조인은 불가능

SELECT  c.name, c.address, c.phone 
	,   b.bookname, b.publisher, b.price 
	,	o.orderdate,o.saleprice
  FROM Book b
 inner JOIN Orders o
    on b.bookid = o.bookid
 inner join Customer c
    on o.custid = c.custid;

-- 외부 조인
-- LEFT OUTER JOIN
 -- 도서를 구매 하지 않은 고객을 포함, 고객의 이름과 주문 도서의 판매 가격을 조회 하시오
SELECT *
  FROM Customer c
  LEFT OUTER JOIN Orders o
    ON c.custid = o.custid;

-- 고객으로 회원가입은 해놓고 한번도 구매 하지 않은 사람을 조회
SELECT *
  FROM Customer c
  LEFT OUTER JOIN Orders o
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;

--책 중에서 한번도 팔리지 않은 책 정보도 같이 조회 하시오
SELECT * 
  FROM Orders o 
 RIGHT OUTER JOIN Book b
  	ON o.Bookid = b.bookid;

-- 최종적으로 book이 기준이 돼서 일치 하지 않는 주문과 고객이 null이 기준이 된다.
SELECT *
  FROM Customer c 
  RIGHT OUTER JOIN Orders o
    ON c.custid = o.custid
 RIGHT OUTER JOIN Book b
    ON o.bookid = b.bookid;

SELECT *
  FROM Customer c
  LEFT OUTER JOIN Orders o
    ON c.custid =o.custid
  LEFT OUTER JOIN Book b
    ON o.bookid = b.bookid;

SELECT * 
  FROM Customer c 
  LEFT OUTER JOIN Orders o
    ON c.custid = o.custid
  RIGHT OUTER JOIN Book b
    ON o.bookid = b.bookid;