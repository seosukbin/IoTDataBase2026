/*  트랜잭션 기본    */

-- 계좌 테이블 생성

CREATE TABLE accounts(
	id int PRIMARY KEY,
	owner varchar(40),
	balance int
);

INSERT INTO accounts(id,owner,balance)
VALUES (1,'Kim',10000),
	   (2,'Lee',20000),
	   (3,'Sung',100000);

-- 트랜잭션 사용 가능 여부 확인
-- 1은 자동 커밋 상태(트랜잭션 확인 불가)
-- 0 트랜잭션 사용 모드
SELECT @@autocommit;
-- 자동 커밋 끄기
SET autocommit = 0;

-- 트랜잭션 사용 순서

START TRANSACTION;

COMMIT;
ROLLBACK;
-- 1. kim 계좌에서 1000원 송금

START TRANSACTION;

UPDATE accounts 
   SET balance = balance - 1000
 WHERE id = 1;
SELECT *
  FROM accounts;

COMMIT;
ROLLBACK;


-- 2. Lee 계좌에서 30000원 출금
START TRANSACTION;
UPDATE accounts 
   SET balance = balance - 30000
 WHERE id = 2;
SELECT *
  FROM accounts;

COMMIT;
ROLLBACK;

-- 3. kim -> sung에게 5000원 송금

-- kim에서 출금

UPDATE accounts 
  SET balance = balance - 5000
 WHERE id = 1;

-- sung에게 입금

UPDATE accounts 
  SET balance = balance + 5000
 WHERE id = 3;

SELECT *
  FROM accounts;

COMMIT;
ROLLBACK;


-- 현재 MYSQL DB엔전 종류 확인
-- InnoDB(최신 버전엔진), MYISAM(구버전 5.5이하)
-- MYISAM 트랜잭션 처리가 불필요

SHOW TABLE STATUS LIKE 'accounts';
-- 현재 실행중 트랜잭션 조회 쿼리(root만 가는ㅇ)
SELECT * FROM information_schema.INNODB_TRX it;