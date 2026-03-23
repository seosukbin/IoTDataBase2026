-- 프로 시저 실행

CALL prc_insertbook(43,'무명책','무명도서',3000000);

SELECT *
  FROM Book;

-- 프로시저 실행
CALL prc_insertorupdatebook(44,'스포츠의 즐거움','마당체육',25000);


SELECT avg(price)
  FROM Book
 WHERE price IS NOT NULL;

CALL prc_getaverageprice(@myVal);
SELECT @myVal;

-- 커서 프로시저 실행, 입출력 파라미터가 없으면 () 생략 가능
CALL prc_getinterest;