/*  INSERT  */

--Book 테이블에 새 책을 추가, '스포츠 의학', 출판사 한솔의학서적, 가격 9000원

INSERT INTO Book(bookid,bookname,publisher,price)
VALUES (11,'스포츠의학' ,'한솔의학서적' ,90000 );

SELECT *
  FROM Book;

INSERT INTO Book(bookid,bookname,publisher,price)
VALUES (11,'스포츠의학' ,'한솔의학서적' ,90000 );

INSERT INTO Book(bookid,bookname,publisher)  -- 가격을 안넣었지만 값은 null로 되어 있다. 
VALUES (12,'스포츠의학2' ,'한솔의학서적');

-- 대량 입력(bulk insert)

CREATE TABLE Imported_Book (
  bookid		INTEGER,
  bookname	VARCHAR(40),
  publisher	VARCHAR(40),
  price		INTEGER
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
COMMIT;

SELECT *
  FROM Imported_Book;

INSERT INTO Book(bookid,bookname,publisher,price)
SELECT bookid,bookname,publisher,price
  FROM Imported_Book;

/*  UPDATE  */
-- Customer 테이블에서 고객 번호 5번의 고객 주소를 '대한민국 부산'으로 수정 하시오

SELECT * FROM Customer WHERE custid = 5;

SET SQL_SAFE_UPDATES = 0; -- sql 안전 모드 켜기
UPDATE Customer 
SET address = '대한민국부부' 
  , phone = '010-0000-0000'
 WHERE custid = 5;  

-- 14번 데이터 추가
INSERT INTO Book(bookid,bookname,publisher)  -- 가격을 안넣었지만 값은 null로 되어 있다. 
VALUES (14,'스포츠의학3' ,'Pearson');

SELECT *FROM Book;

SELECT publisher
  FROM Imported_Book
 WHERE bookid = 22;

-- book테이블의 14번 책 출판사를 imported book21번
-- 챌 출판사와 동일하게 변경 하시오
UPDATE Book 
   SET publisher = (SELECT publisher
  					  FROM Imported_Book
                     WHERE bookid = 22)
 WHERE bookid = 14;

SELECT publisher
  FROM Book 
 WHERE bookid = 14;


/*  DELETE  */

SELECT *
  FROM Imported_Book;


DELETE FROM Book
  WHERE bookid = 15;

-- Customer 복사
CREATE TABLE Customer_copy
SELECT *FROM Customer;

SELECT *
  FROM Customer_copy;

ALTER TABLE Customer_copy 
  ADD COLUMN ISDEL CHAR(1);


-- 삭제를 하지 안호 삭제 플래그를 활용

UPDATE Customer_copy
   SET ISDEL = 'Y'
 WHERE custid = 4;

SELECT * FROM Customer_copy 
 WHERE ISDEL IS NULL;

