-- 관리자로 실행
SET GLOBAL log_binary_trust_function_creators = 1;

-- 함수 사용 
-- 함수는 스칼라 함수
SELECT o.custid
	 , o.orderid 
	 , o.bookid 
	 , o.saleprice 
	 , fnc_interest(o.saleprice)
	 ,o.orderdate
  FROM Orders o ;


INSERT INTO accounts (id,owner,balance)
VALUES (4,'Park', 60000);

SELECT id,owner,balance
	 , fun_balancegrade(balance) AS 'GRADE'
  FROM accounts; 



