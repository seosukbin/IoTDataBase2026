-- 가장 비싼 도서를 조회 하세요
SELECT max(b.price),b.bookname
  FROM Book b
 GROUP BY b.bookname;


SELECT *
  FROM Book b1
 WHERE b1.price >=(SELECT max(b.price) -- 쿼리는 db에게 보내는 문자/요청을 의미한다.
 					FROM Book b);

