##################################################################
# sakila DB WORKSHOP２
# https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html
##################################################################
use sakila;


# 1. 영화배우의 아이디별, 영화등급별로 그룹바이 하여 각 개수 를 출력하세요. 
# 각배우별 총합도 출력하세요.(중간합계) 
# 결과 :  영화배우 아이디, 영화등급, 개수  
  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     GROUP BY fa.actor_id, f.rating WITH ROLLUP
     ORDER BY 1,2;


     
# 2. 고객이름(first_name, last_name)과 고객의 주소(address) 를 조회하세요. 
# 주소는 address 테이블에 있습니다. 
  SELECT c.first_name, c.last_name, a.address
     FROM customer c JOIN address a
       ON c.address_id = a.address_id;

# 3. 고객의 이름과 고객의 주소가 속해있는 도시를 조회하세요. 
# 고객테이블(customer),address테이블, city 테이블을 이용하세요.  

  SELECT c.first_name, c.last_name, ct.city
     FROM customer c
       INNER JOIN address a
       ON c.address_id = a.address_id
       INNER JOIN city ct
       ON a.city_id = ct.city_id;

# 4. address의 구역(district)이 California인  주소, 도시명,  고객이름(first_name, last_name) 
# 을 조회하세요. 참고테이블: customer, address, city 
  SELECT c.first_name, c.last_name, addr.address, addr.city
     FROM customer c
       INNER JOIN
        (SELECT a.address_id, a.address, ct.city
         FROM address a
           INNER JOIN city ct
           ON a.city_id = ct.city_id
         WHERE a.district = 'California'
        ) addr
       ON c.address_id = addr.address_id;
       
  SELECT a.address_id, a.address, ct.city
     FROM address a
       INNER JOIN city ct
       ON a.city_id = ct.city_id
     WHERE a.district = 'California';
     
# 5. 배우의 이름이  CATE MCQUEEN, CUBA BIRCH 인 두명의 배우에 대해서 
# 영화 제목을 조회하세요.  film, film_acter, actor 테이블 참조 
  SELECT f.title
     FROM film f
       INNER JOIN film_actor fa
       ON f.film_id = fa.film_id
       INNER JOIN actor a
       ON fa.actor_id = a.actor_id
     WHERE ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
         OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));     
         
# 6. 고객이름 중 first_name이 J로 시작하고, last_name이 D로 시작하는 고객명과 
# 배우이름 first_name이 J로 시작하고, last_name이 D로 시작하는 배우이름을  
# 모두 출력하세요. first_name, last_name 
# 중복된 행이 보여도 됩니다. 
  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     UNION ALL
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

# 7. payment 테이블에서 고객아이디 별로 최대 지불금액(amount), 최소 지불금액, 
# 평균 지불금액, 지불금앱의 합산, count 값을 출력하세요.  
  SELECT customer_id,
       MAX(amount) max_amt,
       MIN(amount) min_amt,
       AVG(amount) avg_amt,
       SUM(amount) tot_amt,
       COUNT(*) num_payments
     FROM payment
     GROUP BY customer_id;

# 8. acter_id 별로 몇건씩의 영화에 출연했는지 출력하세요. film_actor 테이블 참조 
      SELECT actor_id, count(*)
     FROM film_actor
     GROUP BY actor_id;
     
# 9. 배우별(acter), 등급별(rating), 개수(count)를 출력하세요. 
# film_acter, film 테이블 참조 
  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     GROUP BY fa.actor_id, f.rating
     ORDER BY 1,2;

# 10. 영화 등급이 G 또는 PG인 영화를 골라 배우별(actor), 등급별(rating), 개수(count)를 출력하세요.
# 개수는 9개 이상인 영화만 해당됩니다.  
  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     WHERE f.rating IN ('G','PG')
     GROUP BY fa.actor_id, f.rating
     having count(*) > 9;

# 11. 무료 영화를 대여 기록이 없는 고객명을 출력하세요. 
# payment 지불테이블, 지불금액은 amount, 무료영화는 payment 테이블의 컬럼 amount가 0인 영화        
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
 (SELECT customer_id
  FROM payment
  WHERE amount = 0);
  
# 12. 'United States','Mexico','Canada'에 속한 국가들의 도시(city)를 구하여 
# address 가 속한 도시의 고객들에 대해서 고객별 대여건수를 출력하세요. 
# 최종 출력: 고객별 대여건수 
# 참고 테이블 : rental, customer, address, city, country 
SELECT count(*)
       FROM rental r
         INNER JOIN customer c
         ON r.customer_id = c.customer_id
         INNER JOIN address a
         ON c.address_id = a.address_id
         INNER JOIN city ct
         ON a.city_id = ct.city_id
         INNER JOIN country co
         ON ct.country_id = co.country_id
       WHERE co.country IN ('United States','Mexico','Canada')
       GROUP BY r.customer_id;
       
# 13. 'United States','Mexico','Canada'에 속한 국가들의 도시(city)의 고객들의 
# 가장많은 대여수 보다 많이 대여한 고객의 아이디와 대여수를 출력하세요. 
# 참고: 28번 쿼리를 이용하여 쿼리를 확장해보세요.  
# 결과 
# |customer_id | count(*) |
# |     148    |     46   |

 SELECT customer_id, count(*)
     FROM rental
     GROUP BY customer_id
     HAVING count(*) > ALL
      (SELECT count(*)
       FROM rental r
         INNER JOIN customer c
         ON r.customer_id = c.customer_id
         INNER JOIN address a
         ON c.address_id = a.address_id
         INNER JOIN city ct
         ON a.city_id = ct.city_id
         INNER JOIN country co
         ON ct.country_id = co.country_id
       WHERE co.country IN ('United States','Mexico','Canada')
       GROUP BY r.customer_id
       );

# 14. 'Bolivia','Paraguay','Chile' 의 고객의 대여금(amount)의 합계의 최소값보다 큰 고객의 
# 고객아이디(customer_id)와 합계금액(amount)을 출력하세요. 

  SELECT customer_id, sum(amount)
     FROM payment
     GROUP BY customer_id
     HAVING sum(amount) > ANY
      (SELECT sum(p.amount)
       FROM payment p
         INNER JOIN customer c
         ON p.customer_id = c.customer_id
         INNER JOIN address a
         ON c.address_id = a.address_id
         INNER JOIN city ct
         ON a.city_id = ct.city_id
         INNER JOIN country co
         ON ct.country_id = co.country_id
       WHERE co.country IN ('Bolivia','Paraguay','Chile')
       GROUP BY co.country
      );

# 15. 2005-05-25 이전에 대여 기록이 있는 고객의 이름(first_name, last_name) 을 출력하세요. 

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.customer_id in
      (SELECT r.customer_id FROM rental r
       WHERE r.customer_id = c.customer_id
         AND date(r.rental_date) < '2005-05-25');
         
  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE EXISTS
      (SELECT 1 FROM rental r
       WHERE r.customer_id = c.customer_id
         AND date(r.rental_date) < '2005-05-25');

# 16. 고객당 총대여건수, 총대여금액을 출력하세요.  
  SELECT c.first_name, c.last_name, 
       pymnt.num_rentals, pymnt.tot_payments
     FROM customer c
       INNER JOIN
        (SELECT customer_id, 
           count(*) num_rentals, sum(amount) tot_payments
         FROM payment
         GROUP BY customer_id
        ) pymnt
       ON c.customer_id = pymnt.customer_id;



# 17. 고객의 first_name별, last_name별, 고객의 도시(city) 별 
# 총 지불급액(amount), 총 대여수 를 출력하세요. 
# 테이블 : payment, customer, address, city 
# 결과 (일부) 
# |first_name | last_name | 도시  | 총지불급액 |  총 대여수| 
# |MARY       |	SMITH     |Sasebo|	118.68  |32       |  등등 
  SELECT c.first_name, c.last_name, ct.city,
       sum(p.amount) tot_payments, count(*) tot_rentals
     FROM payment p
       INNER JOIN customer c
       ON p.customer_id = c.customer_id
       INNER JOIN address a
       ON c.address_id = a.address_id
       INNER JOIN city ct
       ON a.city_id = ct.city_id
     GROUP BY c.first_name, c.last_name, ct.city;

# 또는 
  SELECT c.first_name, c.last_name,
       ct.city,
       pymnt.tot_payments, pymnt.tot_rentals
     FROM
      (SELECT customer_id,
         count(*) tot_rentals, sum(amount) tot_payments
       FROM payment
       GROUP BY customer_id
      ) pymnt
       INNER JOIN customer c
       ON pymnt.customer_id = c.customer_id
       INNER JOIN address a
       ON c.address_id = a.address_id
       INNER JOIN city ct
       ON a.city_id = ct.city_id;

# 또는 
  SELECT
      (SELECT c.first_name FROM customer c
       WHERE c.customer_id = p.customer_id
      ) first_name,
      (SELECT c.last_name FROM customer c
       WHERE c.customer_id = p.customer_id
      ) last_name,
      (SELECT ct.city
       FROM customer c
       INNER JOIN address a
         ON c.address_id = a.address_id
       INNER JOIN city ct
         ON a.city_id = ct.city_id
       WHERE c.customer_id = p.customer_id
      ) city,
       sum(p.amount) tot_payments,
       count(*) tot_rentals
     FROM payment p
     GROUP BY p.customer_id;
     
       
# 18.  영화배우 아이디(actor_id), 영화배우의 first_name, 영화배우의 last_name을 출력하세요.
# 영화 출연건수로 내림차순 정렬하여 출력하세요.    
# 참조 테이블: actor, film_actor 
  SELECT a.actor_id, a.first_name, a.last_name
     FROM actor a
     ORDER BY
      (SELECT count(*) FROM film_actor fa
       WHERE fa.actor_id = a.actor_id) DESC;


# 19.  영화아이디(film_id), 영화제목(title), 영화카피의 개수(재고수)를 출력하세요. 
# 참조 테이블: inventory, film
 SELECT f.film_id, f.title, count(*) num_copies
 FROM film f
   INNER JOIN inventory i
   ON f.film_id = i.film_id
 GROUP BY f.film_id, f.title;

# 또는 
SELECT f.film_id, f.title, count(i.inventory_id) num_copies
 FROM film f
   LEFT OUTER JOIN inventory i
   ON f.film_id = i.film_id
 GROUP BY f.film_id, f.title;


# 20. 영화아이디(film_id)가 13이상, 15이하의 영화에 대해서 
# 영화아이디(film_id), 영화제목(title), 제고아이디(inventory_id), 대여일자(rental_date)를 출력하세요. 
# 참조테이블: film, invertory, rental 
SELECT f.film_id, f.title, i.inventory_id, r.rental_date
 FROM film f
   LEFT OUTER JOIN inventory i
   ON f.film_id = i.film_id
   LEFT OUTER JOIN rental r
   ON i.inventory_id = r.inventory_id
 WHERE f.film_id BETWEEN 13 AND 15;
 
 
 # 21. 고객테이블에서 고객명(first_name, last_name)과  active가 1이면, "active" 라고 찍고, 
 # 아니면 "inactive"라고 출력하세요. 
 # 힌트: CASE 조건식을 이용하세요. 
 # 결과 (일부) 
 # | first_name | last_name | 활동여부 | 
 # | MARY       |  SMITH    | ACTIVE|
 SELECT first_name, last_name,
   CASE
     WHEN active = 1 THEN 'ACTIVE'
     ELSE 'INACTIVE'
   END activity_type
 FROM customer;
 