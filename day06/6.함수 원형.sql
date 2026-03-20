-- 함수 원형 integer

CREATE FUNCTION madangdb.fnc_interest(
price  int 
)
RETURNS INT
BEGIN 
	DECLARE myInterest int;
	-- 가격이 3만원 이상이면 10% 그 미만은 5%의 이윤을 남긴다.

	IF (price >=30000)THEN
		SET myInterest = price *0.1;
	ELSE
		SET myInterest = price*0.05;
		
	END IF;
	RETURN myInterest;
	
END


-- balance 함수 원형

CREATE FUNCTION madangdb.fun_balancegrade(
balance integer

)
RETURNS varchar(20)
DETERMINISTIC

BEGIN
	DECLARE grade varchar(20);
	IF balance >= 50000 THEN
	   SET grade = 'vip';

	ELSEIF balance >= 20000 THEN
		   SET grade = 'GOLD';
	ELSE
		SET grade = 'silver';
	END if;
	RETURN grade;
END;