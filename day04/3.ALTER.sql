-- ALTER 객체 수정	
-- NEWBook 테이블에 ISBN 컬럼을 추가 하시오

ALTER TABLE NewBook
  ADD ISBN char(13);

SELECT *
  FROM NewBook;

-- data 추가
 INSERT INTO NewBook VALUES 
 (1,'프로젝트 헤일메리','알에이치',22000,'9788925588735');

-- NewBook 테이블에 장르 컬럼을 추가 하시오
-- 이전에 데이터에 empty가 추가
ALTER TABLE NewBook
  ADD genre varchar(10) NOT NULL;

SELECT genre
  FROM NewBook
 WHERE bookid = 1;

-- NewBook에 isbn을 삭제 하시오

ALTER TABLE NewBook 
  DROP COLUMN isbn;

-- NewBook publisher에 NOT NULL 제약 조건을 추가 하시오

ALTER TABLE NewBook 
MODIFY publisher varchar(40 )NOT NULL;


-- 기본 추가는 alter로 거의 하지 않음
ALTER TABLE NewBook
  ADD PRIMARY key(bookid);

DROP TABLE OldBook;
-- 관계형 DB에서는 관계를 맺고 있는 부모 테이블 부터 삭제 할수 없다.
-- 항상 자식 테이블 부터 삭제 후 부모 테이블을 삭제 할수 있다.
DROP TABLE NewBook;


