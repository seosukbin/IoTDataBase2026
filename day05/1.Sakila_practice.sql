-- 1. 한번도 대여 되지 않은 영화를 조회 하시오

SELECT  f.title, r.rental_id, i.inventory_id
  FROM film f
  LEFT OUTER JOIN inventory i
    ON f.film_id = i.film_id
  LEFT OUTER JOIN rental r
    ON i.inventory_id = r.inventory_id
  WHERE r.rental_id IS NULL;




SELECT count(*)
  FROM rental rental;


-- 가게에 영화 자체가 없다
SELECT *
  FROM inventory
 WHERE film_id IN
 (14, 
 33, 
 36,
 38,
 41, 
 87,
 108,
 128,
 144,
 148, 
 171,
 192,
 195,
 198,
 217,
 221,
 318,
 325,
 332,
 359,
 386,
 404,
 419,
 495,
 497,
 607,
 642,
 669,
 671,
 701,
 712,
 713,
 742,
 801,
 802,
 860,
 874,
 909,
 943,
 950,
 954,
 955

 
 );

-- 영화는 존재 한
SELECT *
  FROM film 
 WHERE title = 'ALICE FANTASIA';


-- 가장 많이 대여된 영화를 조회 하시오
SELECT  f.title, count(r.rental_id)
  FROM film f
  JOIN inventory i
    ON f.film_id = i.film_id
  JOIN rental r
    ON i.inventory_id = r.inventory_id
  GROUP BY f.title;  
    
-- mysql join은 내부 조인을 외부 조인으로 변경 하는데 많은 시간이 걸린다.
SELECT  f.title, r.rental_id, i.inventory_id
  FROM film f, inventory i,rental r 
 WHERE  f.film_id = i.film_id
   AND  i.inventory_id = r.inventory_id;


--3.직둰별 총 매출을 조회 하시오
SELECT s.staff_id, s.first_name,round(sum(p.amount),1) "rental_amt"
  FROM staff s
  JOIN payment p
    ON s.staff_id = p.staff_id
  GROUP BY s.staff_id, s.first_name,s.last_name;
  ORDER BY rental_amt DESC;


-- 4. TOM MIRANDA라는 배우가 출연한 영화 목록을 조회 하시오

SELECT f.film_id, f.title , f.release_year
	   ,f.language_id
	   , (SELECT name
	        FROM language 
	       WHERE  language_id= f.language_id) AS "영화언어"
  FROM film f
  JOIN film_actor fa
    ON f.film_id = fa.film_id 
  JOIN actor a
    ON fa.actor_id = a.actor_id 
 WHERE a.first_name = 'TOM'
   AND a.last_name = 'MIRANDA';


-- 5. 새 고객 Gildong Hongd을 추가 하세요

SELECT *
  FROM customer;

INSERT INTO customer(store_id,first_name, last_name,email,address_id, active,create_date )
VALUES (2,'Gildong','Hong','gildong@naver.com',5,1,now()); 	
-- custoemr id는 audo increment이기 때문에 직접 추가할 필요가 없다


-- Gildong Hong의 이메일 주소를 수정하세요

UPDATE customer 
   SET email = 'gildong.hong@gmail.com'
 WHERE customer_id = 601;

-- Gildong Hong 비활성단계로 수정하세요

UPDATE customer 
   SET active = 0
 WHERE customer_id = 601;

-- 삭제

DELETE FROM customer 
 WHERE customer_id = 601;


