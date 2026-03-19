/* 내장 함수  */

-- 수학 함수
-- 절댓값
SELECT abs(-78), abs(+78)
  FROM DUAL; -- daul은 테이블을 사용하지 않을때 사용하는 키워드 
  
  -- 반올림
  
  SELECT round(3.141592,3); -- 3번쨰 자리에서 4번쨰 자리에 반올림 하겠다는 의미
  
  -- 고객별 평균 주문 금액을 백원 단위로 반올림 하시오
  -- 두번쨰 인자 양수소수점,음수는 정수 부분
  SELECT custid AS "고객번호",round(sum(saleprice)/count(*),-2) AS "평균금액"
    FROM Orders o
   GROUP BY o.custid;  
  
  SELECT ceil(3.14), floor(3.67),power(2,10),log(10); -- 3이상이면 무조건 올리고, 3.이면 내린다
  
  -- 문자 함수
  SELECT concat('서',' ','석빈');
  
  SELECT lower('hello'),upper('hello!');
  
  SELECT rpad('hello',10,'*'); -- 주민번호 생년 월일 - 성별 이후 여섯 자리*
  -- 문자열 대체
  SELECT replace('hello world', 'hello','bye');
  -- 문자열 자르기
  SELECT substr('hello world',7,5);
  
  
 -- 문자열 앞뒤 공백 없애기(중간 공백 제외)
  
  SELECT conact('|', trim('     hello world      '),'|')  "TRIM";
  
  --- 3. 날짜 시간 함수
  -- 날짜로 작성된 문자열을 날짜 형식으로 변환
  
  SELECT str_to_date('2026-03-18','%Y-%m-%d');
  
  SELECT date_format('2026-03-18','%m-%d-%Y');
  SELECT date_format(NOW(),'%m.%d.%Y');
  
  -- 날짜 더하기/뺴기
  SELECT ADDDATE(NOW(),INTERVAL -10 DAY );
  
  SELECT date(NOW()),time(NOW());
  
  -- 날짜 간 날짜 차이수
  SELECT datediff('2026-03-19','2026-03-08');
  
  -- ㅎ현재 일시
  SELECT sysdate(),now();
  
  -- 날짜 함수 포맷
  /*  
   * *Y: 네자리 년도 2026
   * %y: 두자리 년도 26 
   * %m: 월
   * %M: 월 이름(JANUARY ~ DECEMBER)
   * %b: 월 이름(Jan ~ Dec)
   * %d: 일
   * %W: 요일
   * %w: 요일 숫자(0 일요일 ~ 6토요일)
   * %i: 분
   * */
  
  SELECT date_format(now(),'%Y-%m-%d %W');
  SELECT date_format(now(),'%H:%i:%s');
  