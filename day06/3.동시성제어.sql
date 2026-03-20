/*  동시성 제어(Concurrency Control)   */

-- 테이블 수정
select @@autocommit;
ALTER TABLE accounts
MODIFY owner varchar(40) NOT NULL,
MODIFY balance int NOT NULL;

truncate TABLE accounts;

SELECT *
  FROM accounts;
-- 새로 데이터 입력
INSERT INTO accounts(id,owner,balance)
VALUES (1,'Kim',10000),
	   (2,'Lee',20000),
	   (3,'Sung',100000);

-- 기본 락 실행

START TRANSACTION;

UPDATE accounts  
   SET balance = balance - 1000
 WHERE id = 2;  -- 17500원

SELECT *
  FROM accounts;

COMMIT;
ROLLBACK;

-- Non-Repeatable Read 
-- 격리 수준 하강

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT balance FROM accounts WHERE id = 1;


-- 격리 수준 원상태 복구
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

COMMIT;

UPDATE accounts 
  SET balance = 25000
WHERE id = 1;

COMMIT;

-- Phantom ReadALTER 
CREATE TABLE employees
(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(50),
	salary int
);

INSERT INTO employees(name,salary)
VALUES ('Ashley',3000),('Bread',4000),('Canton',6000);

SELECT *
  FROM employees;

ROLLBACK;
COMMIT;

-- 패텀 리드 세션  -- 격리 수준을 낮춰 커밋 하지 않아도 데이터가 들어 갈수 있는것
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM employees WHERE salary >= 5000;
DELETE FROM employees WHERE id = 4;

-- 2번 id 계좌 금액 1000원 차감
SELECT @@autocommit;
SET autocommit = 0;

update employees
   SET salary =7000
 where id = 5;


update accounts
   set balance = 9000
 where id = 2;

ROLLBACK;
-- 테이블 락
LOCK TABLES accounts WRITE;
LOCK tables accounts READ; -- 읽기 가능 테이블 락
SELECT * FROM accounts;

UPDATE accounts 
  SET balance = 9000
 WHERE id = 3;

UNLOCK TABLES;

COMMIT;
