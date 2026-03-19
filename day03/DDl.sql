/* CREATE  */

-- TABLE
-- NewBook 테이블 생성

CREATE TABLE NewBook(
	bookid INTEGER,
	bookname varchar(20),
	publisher varchar(20),
	price decimal(10,2) -- 총 10자리이다. 소숫점 2자리 포함해서
);

-- 테이블 삭제
DROP TABLE NewBook;


SELECT bookid ,bookname,publisher,price
 FROM NewBook;

CREATE TABLE NewBook(
	bookid INTEGER PRIMARY KEY,
	bookname varchar(20)NOT NULL,
	publisher varchar(20)NOT NULL,
	price decimal(10,2) NOT NULL-- 총 10자리이다. 소숫점 2자리 포함해서
);

-- PRIMARY KEY는 UNIQUE에 NOT NULL
INSERT INTO NewBook(bookid,bookname,publisher,price)
VALUES (1,'야구의 추억','대한미디어', 9000);

INSERT INTO NewBook(bookid,bookname,publisher)
VALUES (2,'야구의 추억','대한미디어'); -- not null로 설정 했기 때문에 무조건 값을 넣어 줘야 한다 

-- 기본키가 하나 이상이면 반드시 아래의 방법으로 작성 해야 한다.
CREATE TABLE NewBook(
	bookid INTEGER,
	bookname varchar(20)NOT NULL,
	publisher varchar(20)UNIQUE, -- 한번 넣으면 더이상 안넣어진다
	price decimal(10,2) DEFAULT 10000 CHECK (price > 1000),-- 총 10자리이다. 소숫점 2자리 포함한다. 아무것도 없으면 10000으로 설정된다. 1000초과가 아니면 넣질 않는다.
	PRIMARY KEY (bookid, bookname)
);

CREATE TABLE NewBook(
	bookid INTEGER,
	bookname varchar(20)NOT NULL,
	publisher varchar(20)NOT NULL,
	price decimal(10,2) NOT NULL,-- 총 10자리이다. 소숫점 2자리 포함해서
	PRIMARY KEY (bookid) -- 기본키를 복합키로 설정할때는 반드시 이방법으로 해야한다.
);

INSERT INTO NewBook(bookid,bookname,publisher)
VALUES (2,'야구의 추억','대한미디어'); -- not null로 설정 했기 때문에 무조건 값을 넣어 줘야 한다 

INSERT INTO NewBook(bookid,bookname,publisher)
VALUES (2,'야구의 추억','대한미디어',200); -- not null로 설정 했기 때문에 무조건 값을 넣어 줘야 한다 


