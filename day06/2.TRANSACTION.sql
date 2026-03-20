-- 4.kim ->lee에게 송금중 문제 발생
-- savepoint는 다시!
START TRANSACTION;

-- kim 출금
UPDATE accounts 
  SET balance = balance - 1000
 WHERE id = 1;

SAVEPOINT sp_transfer;

-- lee에게 입금

UPDATE accounts 
  SET balance = balance + 1000
 WHERE id = 2;

SELECT *
  FROM accounts;

ROLLBACK TO sp_transfer;

COMMIT;
ROLLBACK;