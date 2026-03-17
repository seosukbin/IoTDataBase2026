-- 합집합

-- 책테이블의 책 이름과 가격, 고객 테이블의 고객명과 전화 번호를 합하여 조회 하시오
-- 위쪽 테이블 컬럼명을 따라감. 컬럼의 타입 불일치로 오류가 날수가 있ㅇ므(형 변환 필요)
SELECT bookname "대표명"
     , price "금액및 전번"
  FROM Book 
 UNION
SELECT name, phone  
  FROM Customer;
-- Book에 있는 data를 Book_copy 테이블로 복사하면서 생성
CREATE TABLE Book_copy AS 
SELECT bookid, bookname, publisher, price FROM Book;

SELECT * FROM Book_copy;

--책 테이블과 책 테이블 복사를 합쳐서 책 이름과 가격을 조회 하시오

SELECT bookname "대표명"
     , price "금액및 전번"
  FROM Book 
 UNION
SELECT bookname,price
  FROM Book_copy;

-- group by 
-- 주문 정보에서 각 고객별 총판매액을 조회 하시오
-- roll up을 모르면 쿼리 길이가 두배이상 늘어난다.
-- group by에 with rollup을 사용하면 
-- having 절 이전에 합산 후
-- having 절로 필터링
SELECT o.custid,sum(o.saleprice) "TotalPrice"
  FROM Orders o
 GROUP BY o.custid 
 HAVING TotalPrice > 20000;

SELECT o.custid,sum(o.saleprice) "TotalPrice"
  FROM Orders o
 GROUP BY o.custid 
 HAVING TotalPrice > 20000;

-- 필터링 ROLLUP을 하려면 서브쿼리 사용
SELECT t.custid, SUM(t.TotalPrice) "TotalPrice"
  FROM (
SELECT o.custid
     , SUM(o.saleprice) AS "TotalPrice"
  FROM Orders o
 GROUP BY o.custid
HAVING SUM(o.saleprice) > 20000
) t
GROUP BY t.custid WITH ROLLUP;


SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
  FROM Orders o
 GROUP BY o.custid
HAVING TotalPrice > 20000
 UNION 
SELECT NULL, sum(t.TotalPrice)
  FROM (SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
          FROM Orders o
         GROUP BY o.custid
        HAVING TotalPrice > 20000) t;

