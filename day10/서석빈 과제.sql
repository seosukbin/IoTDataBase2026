
-- 1번 문제
SELECT m.member_name,b.book_name, r.rentalDate
  FROM members m
 INNER JOIN rentals r
	ON m.member_idx = r.member_idx
INNER JOIN books b
   ON b.book_idx = r.book_idx
 WHERE r.returnDate IS NULL;

-- 2번
SELECT m.member_idx AS "회원 번호", m.member_name AS "회원명", count(m.member_idx) AS "대여 횟수" 
  FROM members m
 INNER JOIN rentals r
    ON m.member_idx = r.member_idx
 GROUP BY m.member_idx
  ORDER BY count(m.member_idx) DESC, m.member_name ASC;

-- 3번 

SELECT d.div_code AS "장르코드", d.div_name AS 장르명, count(b.price) AS "도서수"
  FROM books b
 RIGHT OUTER JOIN division d
    ON b.div_code = d.div_code
 GROUP BY d.div_code;
 

-- 4번 
SELECT b.book_name 
  FROM books b
 WHERE b.book_idx NOT IN  -- 여러 값을 비교할때는 not in or in을 붙인다. 
 ( SELECT r.book_idx
 	FROM rentals r
 	 );

-- 5번 

SELECT  m.member_idx AS "회원번호", m.member_name AS "회원명",count(*) AS "대여 횟수"
  FROM members m
 INNER JOIN rentals r
    ON m.member_idx = r.member_idx
 GROUP BY m.member_idx
 HAVING (SELECT avg(cnt)
from
(SELECT  r.member_idx, count(*) cnt
   FROM rentals r
  GROUP BY r.member_idx)t) < count(*);





/*
 * SELECT avg(cnt)
from
(SELECT  r.member_idx, count(*) cnt
   FROM rentals r
  GROUP BY r.member_idx)t; -- 테이블명이 있어야 하기 때문에 t를 붙인다.
 */