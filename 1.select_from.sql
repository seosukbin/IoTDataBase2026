 -- 서점에 어떤 도서가 있는지 알고 싶다
 -- 모든 도서의 이름과 가격을 조회 하세요
 
 select bookname
      , price 
   from Book;
 
 -- 모든 도서의 가격과 이름을 조회 하시오
 
 select price
 	  , bookname	
   FROM Book;
 
 -- 모든 도서의 도선 번호, 도서명, 도서출판사, 가격을 조회 하시오
 
 select *
   FROM Book;
 
 select bookid
 	  , bookname
 	  , publisher
 	  , price
   from Book;
 
 -- 도서 테이블에 있는 모든 출판사를 조회 하시오
 
 select publisher
   FROM Book;
  
 select DISTINCT  publisher
   FROM Book;
  select ALL publisher
   FROM Book;
 
 -- WHERE 절
 
  -- 가격이 10000이상 20000이하인 도서를 조회 하시오
 
 SELECT *
   FROM Book
  WHERE price BETWEEN 10000 and 20000;
 
  SELECT *
   FROM Book
  WHERE price >= 10000 
    AND price <=20000;
 
  
  -- 출판사가 굿 스포츠, 대한 미디어인도서를 조회 하시오 in은 목록 안에서도 그 안에 있는것을 찾을때 사용한다. 
select *
  FROM Book
 WHERE publisher IN ('굿스포츠','대한미디어');
 
SELECT  *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠','대한미디어');
  

-- 축구의 역사 출간한 출판사를 조회 하시오

SELECT *
  FROM Book
 WHERE bookname = '축구의 역사';


SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '축구의 역사';
  
-- 책 제목이 축구로 시작하는 책을 출판한 출판사를 조회 하시오
SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '축구%';

-- 책 제목이 축구가 포함된 책을 출판한 출판사를 조회 하시오
SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '%축구%';

-- 책 제목이 축구로 끝나는 책을 출판한 출판사를 조회 하시오
SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '%축구';

-- 책 제목이 축구로 시작하고 총제목 길이수가 8자리인 
-- 책을 출판한 출판사를 조회 하시오
SELECT bookname,publisher
  FROM Book
 WHERE bookname LIKE '축구______';


-- 도서 이름의 왼쪽 두번째 글자가 '구'인 도서를 조회 하시오

SELECT *
  FROM Book
 WHERE bookname LIKE '_구%';

-- 축구에 관한 도서중 가격이 2만원 이상인 도서를 조회 하시오

SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%'
   AND price >= 20000;


-- ORDER BY 오름차순, 내림차순 정렬
-- 도서를 이름순으로 조회 하시오

SELECT *
  FROM Book
 ORDER BY bookname; 


-- 도서를 가격순으로 조회 하고, 가격이 같으면 이름순으로 조회 하시오
SELECT *
  FROM Book
 ORDER BY price DESC ,bookname ASC; 


-- 집계 함수 SUM
-- 2번 김연아 고객이 주문한 도서의 총 판매액을 조회 하시오

SELECT custid
  FROM Customer
 WHERE name = '김연아';

SELECT *
  FROM Orders;

SELECT sum(saleprice) AS "총 매출"
  FROM Orders 
 WHERE custid = 2;
 
--Alias

SELECT b.bookid AS "책순번"
     , b.bookname AS "책제목"
     , b.price   AS  "정가"
  FROM Book AS b;

-- 고객이 주문한 도서의 총 판매액, 평균,최저,최고가를 조회 하시오

SELECT sum(saleprice) "Total"
	 , avg(saleprice) "Average"
	 , min(saleprice) " Minimum"
	 , max(saleprice) "Maximum"
  FROM Orders; 


-- 마당서점의 총 도서 판매수를 조회 하시오
SELECT count(*) " 총 판매 수익"
    , count(o.orderid) "총 판매수"
  FROM Orders o; -- 포잍터와 같이 별명 정할떄 사용한다 as는 생략이 가능하다.

 
  -- GROUP BY 어느 고객이 얼마나 주문 했는지 알고 싶을때
  -- 고객 별로 주문한 도서의 총 수량과 총 판매액을 조회 하시오.
  
  SELECT o.custid
       , count(*) "총 도서 판매 수량"
       , sum(o.saleprice) "총 판매액"
    FROM Orders o
   GROUP BY o.custid; -- group by에 들어간것 만 가능하다.

   
   -- 가격이 8천원 이상인 도서를 구매한 고객에게 고객별 주문 도서, 총 수량
   -- 조회 하시오. 단 두권 이상 구맨한 고객만 조회합니다. 
   
   SELECT count(*) "도서수량"
     FROM Orders o
    WHERE o.saleprice >= 8000
    GROUP BY o.custid
   HAVING count(*) >= 2;

   
   SELECT *
  FROM Orders;

  
   SELECT *
    FROM Customer;
   
   SELECT *
  FROM Book;
   
   SELECT *
     FROM Book
    WHERE price >=20000;
   
SELECT sum(o.saleprice) as "박지성의 총 구매액"
  FROM Orders o
 WHERE o.custid = 1;   

SELECT  sum(o.custid = 1)
  FROM Orders o 
 WHERE  o.custid = 1;


SELECT *
  FROM Book;
  
  


  
  
  
 
 
 