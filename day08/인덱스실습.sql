-- 특정 고객의 최근 주문을 조회 하시오


-- 1. 특정 고객의 최근 여행을 조회 하시오
SELECT *
  FROM orders_big
 WHERE customer_id = 123456
 ORDER BY order_date DESC;


-- 특정 기간에 특정 고객의 주문을 조회 하시오

SELECT *
  FROM orders_big
 WHERE customer_id = 123456
   AND order_date BETWEEN '2024-01-01' AND '2025-12-31';

-- seoul, 특정 금액 조건에 정렬을 해서 조회 하시오

SELECT *
  FROM orders_big ob
 WHERE ob.city = 'Seoul'
   AND ob.amount >= 900000
 ORDER BY order_date DESC;


-- 1. 특정 고객의 최근 여행을 조회 하시오

EXPLAIN ANALYZE 
SELECT *
  FROM orders_big
 WHERE customer_id = 123456
 ORDER BY order_date DESC;

/* 실행 계획 결과
 * -> Sort: orders_big.order_date DESC  (cost=1.04e+6 rows=9.96e+6) (actual time=2672..2672 rows=26 loops=1)
    -> Filter: (orders_big.customer_id = 123456)  (cost=1.04e+6 rows=9.96e+6) (actual time=1183..2672 rows=26 loops=1)
        -> Table scan on orders_big  (cost=1.04e+6 rows=9.96e+6) (actual time=0.0808..2380 rows=10e+6 loops=1)

 */
  -- customer_id와 roder

CREATE INDEX idx_ordes_customers_id ON orders_big(customer_id);

SELECT * FROM orders_big
 ORDER BY customer_id ASC;


CREATE INDEX idx_orders_order_date ON orders_big(order_date DESC);