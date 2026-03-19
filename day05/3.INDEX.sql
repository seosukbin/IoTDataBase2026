-- index 생성용 테이블
CREATE TABLE Noidex_Book(
	bookid integer,
	bokname varchar(40),
	publisher varchar(40),
	isbn varchar(13),
	releaseyear integer,
	price decimal(8,0)
);
-- pk 없는 테이블

-- pk 있는 테이블
CREATE TABLE idex_Book(
	bookid integer,
	bokname varchar(40),
	publisher varchar(40),
	isbn varchar(13),
	releaseyear integer,
	price decimal(8,0),
	PRIMARY KEY(bookid)
);

-- Noidx_Book 인덱스 걸기

CREATE UNIQUE INDEX idex_book ON idex_Book(bookid);

INSERT INTO idex_Book VALUES (1,'프로젝트 헤일메리','미디어','97891111',2022,18000);

INSERT INTO Noidex_Book VALUES (NULL,'프로젝트 헤일메리','미디어','97891111',2022,18000);

CREATE INDEX idex_book_bookname ON idex_Book(releaseyear,isbn);
 
DROP INDEX idex_book_isbn_releaseyear ON idex_Book;

CREATE INDEX idx_book_bookname ON idex_Book(bokname);

-- 현재 테이블 상태 분석
ANALYZE TABLE Book;

-- 테이블 인덱스 최적화 
OPTIMIZE TABLE Book;


