-- 일반 조회 쿼리
SELECT*FROM Book;

-- 1. 김연아 고객의 전화를 찾으시오
select phone from Customer
where name = '김연아';

-- 한줄 주석
-- 모든 쿼리의 마지막은 ;로 끝낸다. 하지만 없다고 오류가 나고 그렇진 않다 . ;은 옵션이지만 그냥 붙인다고 생각하자
select *FROM Book;

-- 테이블에서 가져오는 데이터가 아니면 from절 생략  
select  now();

-- 열 명시a
SELECT bookname,price
FROM  Book;

SELECT *FROM Customer
WHERE custid >1 AND custid <5;