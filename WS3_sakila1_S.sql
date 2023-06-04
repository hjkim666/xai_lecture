##################################################################
# sakila DB WORKSHOP
# https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html
##################################################################
use sakila;

# 1. 고객테이블 customer 테이블을 조회하세요. 
SELECT first_name, last_name
     FROM customer;

# 2. category 테이블을 조회하세요. 
SELECT * FROM category;

# 3. language 테이블을 조회하세요. 
SELECT * FROM language; 

# 4. language 테이블에서  language_id와  name(대문자로 출력)을 조회하세요. 
SELECT language_id,
       upper(name) language_name
     FROM language;

# 5. film_acter 테이블에서 acter_id로 오름차순 정렬하여 모든 정보를 조회하세요. 
SELECT * FROM film_actor ORDER BY actor_id;

# 6. film_actor 테이블에서 중복 제거된 acter_id를 조회하세요. 
SELECT DISTINCT actor_id FROM film_actor ORDER BY actor_id;

# 7. 고객테이블(customer) 에서 first_name이 JESSIE 인 고객의 last_name과 first_name을 
# concat 함수를 이용하여 전체이름을 출력하세요.  
SELECT concat(cust.last_name, ', ', cust.first_name) full_name
     FROM
      (SELECT first_name, last_name, email
       FROM customer
       WHERE first_name = 'JESSIE'
      ) cust;

-- 출력 결과> 
-- BANKS, JESSIE
-- MILAM, JESSIE 

# 8. cust_vw 라는 이름으로 view를 생성하세요. 
# customer 테이블에서 customer_id, first_name, last_name, active 
# 정보를 조회하는 view입니다.
CREATE VIEW cust_vw AS
     SELECT customer_id, first_name, last_name, active
     FROM customer;

# 9. 위에서 생성한 view를 조회하여, active=0인 현재 활동 하지 않는 배우의 
# 이름을 출력하세요. (first_name과 lastname)      
SELECT first_name, last_name
     FROM cust_vw
     WHERE active = 0;

# 10. rental 테이블의 rental_date 가 '2005-06-14' 일인 고객의 first_name, last_name, 
# rental_date (시간포함)를 조회하세요. 고객정보는 customer 테이블에 있습니다 
SELECT customer.first_name, customer.last_name,
       time(rental.rental_date) rental_time
     FROM customer
       INNER JOIN rental
       ON customer.customer_id = rental.customer_id
     WHERE date(rental.rental_date) = '2005-06-14';
     

# 11. film 테이블에서 rating 이 G 등급이고, 대여기간(rental_duration)이 7일 이상인 
# 영화의 타이틀을 조회하세요 
  SELECT title
     FROM film
     WHERE rating = 'G' AND rental_duration >= 7;

# 12. rental 건수가 40건 이상인 고객의 이름(first_name, last_name)과 대여건수를 출력하세요.  
# rental 테이블의 대여정보와, customer 테이블의 고객정보를 이용하세요. 
  SELECT c.first_name, c.last_name, count(*)
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     GROUP BY c.first_name, c.last_name
     HAVING count(*) >= 40;

# 13. 대여일이 '2005-06-14'인 고객의 이메일과 반납일(return_date)을 조회하세요. 
# 고객의 email은 customer 테이블에 return_date는 rental 테이블에 있습니다.   
  SELECT c.email, r.return_date
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY 1,2;

# 14. 대여일자(rental_date)가 '2005-06-14'이상 '2005-06-16'이하인 
# 고객아이디(customer_id)와, 대여일자(rental_date)를 조회하세요.      
  SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';
	
# 15. payment 테이블에서 지불금액(amount)이 10.0이상 11.99이하인 지불건수에 대해서 
# 고객아이디(customer_id), 지불일자(payment_date), 지불금액(amount) 
 SELECT customer_id, payment_date, amount
     FROM payment
     WHERE amount BETWEEN 10.0 AND 11.99;

# 16. 문자열검색을 통해 영화제목에 "PET"가 들어가는 영화의 등급(rating)에 속한 영화를 
# 찾아 타이틀(title)과 등급(rating)을 조회하세요. 
 SELECT title, rating
     FROM film
     WHERE rating IN (SELECT rating FROM film WHERE title LIKE '%PET%');

# 17. 반납일자(return_date)가 없는(null) 고객아이디(customer)와 rantal_id를 조회하세요. 
  SELECT rental_id, customer_id
     FROM rental
     WHERE return_date IS NULL;

# 18. rental 테이블의 rental_date 의 연도, 월, 일, 시간, 요일을 출력하세요. 
# 날짜함수 사용  
# <결과>   
# | renatal_date         | 연도 | 월  | 일  | 시간 | 요일    |
# | 2005-05-24 22:53:30  |2005 |  5  | 24 |  22 | Tuesday|
select rental_date, year(rental_date), month(rental_date), dayofmonth(rental_date),
	hour(rental_date), dayname(rental_date)
from rental;

# 19.rental 테이블의 대여일(rental_date)의 요일별로 개수를 출력하세요. 
# 개수(대여건수)로 내림차순 정렬하세요. 
select dayname(rental_date), count(*) 개수
from rental
group by dayname(rental_date) 
order by 개수 desc;

# 20. rental 테이블의 대여월 중 가장 많은 대여가 일어난 월을 출력하세요. 
select month(rental_date) , count(*) 개수
from rental
group by month(rental_date) 
order by 개수 desc;
# 7월 

