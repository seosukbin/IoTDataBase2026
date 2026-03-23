-- 프로시저 원본
CREATE PROCEDURE madangdb.prc_insertbook(
	IN vbookID int,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int
)
BEGIN
	INSERT INTO Book(bookid,bookname,publisher,price)
	VALUES(vbookID,bookName,vpublisher,vprice);
END;

-- 수정 추가 동시 진행 프로시저
CREATE PROCEDURE madangdb.prc_insertorupdatebook(

		IN vbookID int,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int
)
BEGIN
	DECLARE vcount int;
	-- 같은 책이 있는지 확인
	
	SELECT count(*) INTO vcount
	  FROM Book 
	 WHERE booknmae LIKE vbookName;
	 
	 IF vcount != 0 THEN
	 	SET SQL_SAFE_UPDATES = 0;
	 	-- 같은 데이터가 있으니 업데이트
	 	UPDATE Book 
	 	   SET price = vprice
	 	     , publisher = vpublisher
	   	 WHERE bookname LIKE vbookname; -- 원래 pk로 조건 필요  
	 
	ELSE
	 	-- 새로 추가
	 	INSERT INTO Book VALUES 
	 	(vbookID,vbookName,vpublisher,vprice);
	 END IF; 
END;

-- out 파라미터
CREATE PROCEDURE madangdb.prc_getaverageprice(
	OUT AverageVal int
)
BEGIN
	SELECT avg(price) INTO AvergeVal
	  FROM Book
	 WHERE price IS NOT NULL;
END;

-- 커서
CREATE PROCEDURE madangdb.prc_getinterest()
BEGIN

	DECLARE vinterest int DEFAULT 0;-- 총 이윤 담을 변수
	DECLARE vprice int; -- 커서당 Order 테이블 saleprice 각각 담을 변수
	DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 커서 마지막 확인 변수
	DECLARE interestcursor CURSOR FOR -- 커서 변수
		SELECT saleprice FROM Orders; -- Orders 테이블 saleprice 하나씩
	-- Orders의 saleprice를 가져오기 위한 커서를 정의한다 
	-- 더이상 fetch 할게 없으면 endofrow를 true로 변경한다.
	DECLARE CONTINUE handler
		FOR NOT FOUND SET endOfRow = TRUE;
	
	OPEN interestcursor; -- 커서 오픈
	cursor_loop: LOOP -- 커서 반복
		-- Orders의 saleprice값이 반복적으로 vprice에 할당
		FETCH interestcursor INTO vprice; 
		 -- 마지막에서 커서 반복문 탈출(break)
		IF endOfRow THEN LEAVE cursor_loop;
		END IF;
	
		-- vprice에 들어간 값이 30000원 이상이면 이윤 10% 계산 아니면 5% 이윤 계산
		IF vprice >= 30000 THEN
			SET vinterest = vinterest + vprice * 0.1;
		ELSE 
			SET vinterest = vinterest + vprice * 0.05;
		END IF;
	END LOOP cursor_loop;
	CLOSE interestcursor; -- 커서 종료
	
	SELECT  concat('전체 이익금 = ', vinterest);
END