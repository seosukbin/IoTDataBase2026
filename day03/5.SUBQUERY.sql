-- 서브 쿼리의 종류 

-- where 절 서브 쿼리

SELECT DISTINCT publisher 
  FROM Book
 WHERE publisher LIKE '%미디어'; 
 
-- 서브 쿼리를 사용해서 출판사 이름이 '미디어'로 끝나는 출판사에서 
-- 출판한 책을 조회 하시오

SELECT  *
  FROM Book b
 WHERE publisher IN (SELECT DISTINCT publisher 
     				  FROM Book
   					 WHERE publisher LIKE '%미디어');  -- =은 한개의 값만을 비교 하기 때문에 서브 쿼리에서 많이 반환 하면 오류가 나기에 in 절을 사용해서 여러개의 반환 문제를 해결한다. 
   					 								 --  in절은 or기능을 한다.	

   					
-- 도서를 구매한적이 있는 고객의 이름을 조회 하시오

SELECT *
  FROM Customer c
 WHERE c.custid IN ( SELECT DISTINCT custid
                       FROM Orders o);
   					

-- 대한 미디어에서 출판한 도서를 구매한 고객의 정보를 보이시오

SELECT *
  FROM Customer c
 WHERE c.custid IN (SELECT custid -- subquery안에는 *를 써서는 안된다. 
  					  FROM Orders 
 					 WHERE bookid IN (SELECT bookid
  										FROM Book
 									   WHERE publisher = '대한미디어'))
 									  
-- 조인으로 변경 모든 테이블에 컬럼 사용 가능
 									   
 									   
SELECT *
 FROM Customer c, Orders o, Book b
WHERE c.custid = o.custid
  AND b.bookid = o.bookid 
  AND b.publisher = '대한미디어';


-- 도서 전체의 평균 값 보다 저렴한 책들을 조회 하시오
SELECT *
  FROM Book b
 WHERE b.price<=(SELECT avg(price)
  				   FROM Book);


-- 출판사별 가장 비싼 도서

SELECT *
  FROM Book b
 WHERE (publisher,price) IN (SELECT publisher,MAX(price) -- 두컬럼의 값을 쌍으로 묶어서 동시에 비교 하겠다는 의미
  							   FROM Book 
                              GROUP BY publisher);		

-- 출판사별 가장 비싼 책과 동일한 책을 찾으시오

SELECT *
  FROM Book b
 WHERE price IN (SELECT MAX(price) -- 두컬럼의 값을 쌍으로 묶어서 동시에 비교 하겠다는 의미
  				   FROM Book 
                  GROUP BY publisher);		

-- ANY,SOME결과중 메인 쿼리의 조건이 하나라도 참이면 출력
-- 출판사별 가장 비싼 책과 가격이 하나라도 일치하는 책 정보를 조회 하라
SELECT *
  FROM Book b
 WHERE price = ANY (SELECT MAX(price) 
  				      FROM Book 
                     GROUP BY publisher);		

-- 출판사별 가장 비싼 책과 가격이 하나라도 더 비싼 책 정보를 조회 하라
SELECT *
  FROM Book b
 WHERE price > ANY (SELECT MAX(price) 
  				      FROM Book 
                     GROUP BY publisher);	

-- 출판사별 가장 비싼 책들과 가격이 모두 조건에 일치하는 책 정보를 조회 하라
-- ALL = AND
SELECT *  
  FROM Book b
 WHERE price >= ANY (SELECT MAX(price) 
  				       FROM Book 
                      GROUP BY publisher);	

-- 서브 쿼리 결과가 아무것도 없으면 메인 쿼리는 조회 안된다.
-- 서브 쿼리 결과가 뭐라도 있으면 메인 쿼리 조회 가능
SELECT *
  FROM Book b
 WHERE EXISTS (SELECT MAX(price) -- 두컬럼의 값을 쌍으로 묶어서 동시에 비교 하겠다는 의미
  		         FROM Book 
                GROUP BY publisher
			   HAVING max(price)>40000); -- exists는 서브 쿼리의 조건을 만족하는게 한개라도 있으면 모두 출력 하겠다라는 의미다


-- 상관 커브 쿼리(correlated subQuery). 메인 쿼리의 컬럼이 
-- 메인 쿼리의 컬럼이 서브 쿼리의 조건에 포함 될때
-- 서브 쿼리만 따로 실행 불가능
-- 출판사별 출판사 평균 도서 가격 보다 비싼 도서를 조회 하세요

  
 
 SELECT *
   FROM Book b1
  WHERE b1.price > ANY (SELECT avg(b2.price)
					      FROM Book b2
					     GROUP BY b2.publisher);

 
 
SELECT *
   FROM Book b1
  WHERE b1.price > ANY (SELECT avg(b2.price)
					      FROM Book b2
					     WHERE  b2.publisher = b1.publisher);



-- 구매 고객별 합계 총에서 총 금액이 5만 이상인 구맹 정보를 조회 하세요
-- 서브 쿼리로 만들어진 가상 테이블을 진짜 테이블 처럼 from 절에 사용하는것
SELECT t.custid,t.TotalPrice
  FROM (SELECT custid,SUM(saleprice) "TotalPrice"
		 FROM Orders 
		GROUP BY custid) t
 WHERE t.TotalPrice >= 32000 -- 이렇게 함수를 where절에는 쓰면 안된다.  
 ORDER BY t.TotalPrice DESC;

SELECT t.custid,t.TotalPrice
  FROM (SELECT custid,SUM(saleprice) "TotalPrice"
		 FROM Orders 
		GROUP BY custid) t
 INNER JOIN Customer c
 	ON t.custid = c.custid;
 WHERE t.TotalPrice >= 32000
 ORDER BY t.TotalPrice DESC;


SELECT *
 FROM(  
SELECT custid,count(*) AS "Order_cnt"
  FROM Orders  
 GROUP BY custid ) t
 WHERE t.ORDER_cnt >= 3;


/* select 절 서브 쿼리*/
 -- 조인을 사용하지 않고 고객명과 책이름을 같이 조회 하시오

SELECT o.orderid 
	 , o.custid 
	 , o.bookid
	 , saleprice
	 , o.orderdate 
	 , c.name 
	 , b.bookname
  FROM Orders o, Customer c, Book b
 WHERE o.custid = c.custid 
   AND o.bookid = b.bookid
   AND o.orderid<= 5;
   

SELECT o.orderid 
	 , o.custid 
	 , (SELECT name
	 	  FROM Customer
	 	 WHERE custid = o.custid) "고객명"
	 , o.bookid 
	 , (SELECT bookname FROM Book WHERE bookid = o.bookid) "도서명"
	 , saleprice
	 , o.orderdate 
  FROM Orders o
 WHERE o.orderid<= 5
 
