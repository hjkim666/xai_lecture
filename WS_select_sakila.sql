use sakila;

SELECT first_name, last_name
     FROM customer
     WHERE last_name = 'ZIEGLER';

SELECT * FROM category;

SELECT * FROM language;     

SELECT language_id, name, last_update
     FROM language;

SELECT name
     FROM language;    
     
SELECT language_id,
       'COMMON' language_usage,
       language_id * 3.1415927 lang_pi_value,
       upper(name) language_name
     FROM language;
     
SELECT version(),
       user(),
       database();

SELECT language_id,
       'COMMON' language_usage,
       language_id * 3.1415927 lang_pi_value,
       upper(name) language_name
     FROM language;

SELECT language_id,
       'COMMON' AS language_usage,
       language_id * 3.1415927 AS lang_pi_value,
       upper(name) AS language_name
     FROM language;
     
SELECT actor_id FROM film_actor ORDER BY actor_id;

SELECT DISTINCT actor_id FROM film_actor ORDER BY actor_id;

SELECT concat(cust.last_name, ', ', cust.first_name) full_name
     FROM
      (SELECT first_name, last_name, email
       FROM customer
       WHERE first_name = 'JESSIE'
      ) cust;

  CREATE TEMPORARY TABLE actors_j
      (actor_id smallint(5),
       first_name varchar(45),
       last_name varchar(45)
      );

  INSERT INTO actors_j
     SELECT actor_id, first_name, last_name
     FROM actor
     WHERE last_name LIKE 'J%';

  SELECT * FROM actors_j;

  CREATE VIEW cust_vw AS
     SELECT customer_id, first_name, last_name, active
     FROM customer;

  SELECT first_name, last_name
     FROM cust_vw
     WHERE active = 0;

  SELECT customer.first_name, customer.last_name,
       time(rental.rental_date) rental_time
     FROM customer
       INNER JOIN rental
       ON customer.customer_id = rental.customer_id
     WHERE date(rental.rental_date) = '2005-06-14';

  SELECT title
     FROM film
     WHERE rating = 'G' AND rental_duration >= 7;

  SELECT title
     FROM film
     WHERE rating = 'G' OR rental_duration >= 7;

  SELECT title, rating, rental_duration
     FROM film
     WHERE (rating = 'G' AND rental_duration >= 7)
       OR (rating = 'PG-13' AND rental_duration < 4);

  SELECT c.first_name, c.last_name, count(*)
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     GROUP BY c.first_name, c.last_name
     HAVING count(*) >= 40;

  SELECT c.first_name, c.last_name,
       time(r.rental_date) rental_time
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14';

  SELECT c.first_name, c.last_name,
       time(r.rental_date) rental_time
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY c.last_name;

  SELECT c.first_name, c.last_name,
       time(r.rental_date) rental_time
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY c.last_name, c.first_name;

  SELECT c.first_name, c.last_name,
       time(r.rental_date) rental_time
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY time(r.rental_date) desc;

  SELECT c.first_name, c.last_name,
       time(r.rental_date) rental_time
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY 3 desc;

  SELECT c.email, r.return_date
     FROM customer c
       INNER JOIN rental <1>
       ON c.customer_id = <2>
     WHERE date(r.rental_date) = '2005-06-14'
     ORDER BY <3> <4>;

#========================================== 
#필터링
  SELECT c.email
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) = '2005-06-14';

  SELECT c.email
     FROM customer c
       INNER JOIN rental r
       ON c.customer_id = r.customer_id
     WHERE date(r.rental_date) <> '2005-06-14';

  SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date < '2005-05-25';

  SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date <= '2005-06-16'
       AND rental_date >= '2005-06-14';

  SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';

  SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date BETWEEN '2005-06-16' AND '2005-06-14';

SELECT customer_id, rental_date
     FROM rental
     WHERE rental_date >= '2005-06-16' 
       AND rental_date <= '2005-06-14';

 SELECT customer_id, payment_date, amount
     FROM payment
     WHERE amount BETWEEN 10.0 AND 11.99;

  SELECT last_name, first_name
     FROM customer
     WHERE last_name BETWEEN 'FA' AND 'FR';

  SELECT last_name, first_name
     FROM customer
     WHERE last_name BETWEEN 'FA' AND 'FRB';

  SELECT title, rating
     FROM film
     WHERE rating = 'G' OR rating = 'PG';

  SELECT title, rating
     FROM film
     WHERE rating IN (SELECT rating FROM film WHERE title LIKE '%PET%');

  SELECT last_name, first_name
     FROM customer
     WHERE left(last_name, 1) = 'Q';

  SELECT last_name, first_name
     FROM customer
     WHERE last_name LIKE '_A_T%S';

  SELECT last_name, first_name
     FROM customer
     WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';

  SELECT last_name, first_name
     FROM customer
     WHERE last_name REGEXP '^[QY]';

  SELECT rental_id, customer_id
     FROM rental
     WHERE return_date IS NULL;

  SELECT rental_id, customer_id
     FROM rental
     WHERE return_date = NULL;

  SELECT rental_id, customer_id, return_date
     FROM rental
     WHERE return_date IS NOT NULL;

  SELECT rental_id, customer_id, return_date
     FROM rental
     WHERE return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

  SELECT rental_id, customer_id, return_date
     FROM rental
     WHERE return_date IS NULL
       OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

#========================================== 
# 다중 테이블 쿼리 
  desc customer;

  desc address;

  SELECT c.first_name, c.last_name, a.address
     FROM customer c JOIN address a;

  SELECT c.first_name, c.last_name, a.address
     FROM customer c JOIN address a
       ON c.address_id = a.address_id;

SELECT c.first_name, c.last_name, a.address
FROM customer c INNER JOIN address a
  USING (address_id);

  SELECT c.first_name, c.last_name, a.address
     FROM customer c, address a
     WHERE c.address_id = a.address_id;

  SELECT c.first_name, c.last_name, a.address
     FROM customer c, address a
     WHERE c.address_id = a.address_id
       AND a.postal_code = 52137;

  SELECT c.first_name, c.last_name, a.address
     FROM customer c INNER JOIN address a
       ON c.address_id = a.address_id
     WHERE a.postal_code = 52137;

  desc address;

  desc city;

  SELECT c.first_name, c.last_name, ct.city
     FROM customer c
       INNER JOIN address a
       ON c.address_id = a.address_id
       INNER JOIN city ct
       ON a.city_id = ct.city_id;

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

  SELECT f.title
     FROM film f
       INNER JOIN film_actor fa
       ON f.film_id = fa.film_id
       INNER JOIN actor a
       ON fa.actor_id = a.actor_id
     WHERE ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
         OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));

  SELECT f.title
      FROM film f
        INNER JOIN film_actor fa1
        ON f.film_id = fa1.film_id
        INNER JOIN actor a1
        ON fa1.actor_id = a1.actor_id
        INNER JOIN film_actor fa2
        ON f.film_id = fa2.film_id
        INNER JOIN actor a2
        ON fa2.actor_id = a2.actor_id
     WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
       AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

  desc film;

  SELECT f.title, f_prnt.title prequel
     FROM film f
       INNER JOIN film f_prnt
       ON f_prnt.film_id = f.prequel_film_id
     WHERE f.prequel_film_id IS NOT NULL;

  SELECT c.first_name, c.last_name, a.address, ct.city
     FROM customer c
       INNER JOIN address <1>
       ON c.address_id = a.address_id
       INNER JOIN city ct
       ON a.city_id = <2>
     WHERE a.district = 'California';

#========================================== 
#집합 연산자
  desc customer;

  desc city;

  SELECT 1 num, 'abc' str
     UNION
     SELECT 9 num, 'xyz' str;

  SELECT 'CUST' typ, c.first_name, c.last_name
     FROM customer c
     UNION ALL
     SELECT 'ACTR' typ, a.first_name, a.last_name
     FROM actor a;

  SELECT 'ACTR' typ, a.first_name, a.last_name
     FROM actor a
     UNION ALL
     SELECT 'ACTR' typ, a.first_name, a.last_name
     FROM actor a;

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     UNION ALL
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     UNION
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'D%' AND c.last_name LIKE 'T%'
-- INTERSECT
-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'D%' AND a.last_name LIKE 'T%';

-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
-- INTERSECT
-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

-- SELECT a.first_name, a.last_name
-- FROM actor a
-- WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
-- EXCEPT
-- SELECT c.first_name, c.last_name
-- FROM customer c
-- WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

  SELECT a.first_name fname, a.last_name lname
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
     UNION ALL
     SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     ORDER BY lname, fname;

  SELECT a.first_name fname, a.last_name lname
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
     UNION ALL
     SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     ORDER BY last_name, first_name;

  SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
     UNION ALL
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
     UNION
     SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

  SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
     UNION
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
     UNION ALL
     SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
UNION
(SELECT a.first_name, a.last_name
 FROM actor a
 WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
 UNION ALL
 SELECT c.first_name, c.last_name
 FROM customer c
 WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
)

#########################################################
# 그룹화와 집계 
SELECT customer_id FROM rental;

SELECT customer_id
 FROM rental
 GROUP BY customer_id;

SELECT customer_id, count(*)
 FROM rental
 GROUP BY customer_id;

  SELECT customer_id, count(*)
     FROM rental
     GROUP BY customer_id
     ORDER BY 2 DESC;

   SELECT customer_id, count(*)
     FROM rental
     WHERE count(*) >= 40
     GROUP BY customer_id;

  SELECT customer_id, count(*)
     FROM rental
     GROUP BY customer_id
     HAVING count(*) >= 40;

  SELECT MAX(amount) max_amt,
       MIN(amount) min_amt,
       AVG(amount) avg_amt,
       SUM(amount) tot_amt,
       COUNT(*) num_payments
     FROM payment;

  SELECT customer_id,
       MAX(amount) max_amt,
       MIN(amount) min_amt,
       AVG(amount) avg_amt,
       SUM(amount) tot_amt,
       COUNT(*) num_payments
     FROM payment
     GROUP BY customer_id;

  SELECT COUNT(customer_id) num_rows,
       COUNT(DISTINCT customer_id) num_customers
     FROM payment;

  SELECT MAX(datediff(return_date,rental_date))
     FROM rental;

  CREATE TABLE number_tbl
      (val SMALLINT);

  INSERT INTO number_tbl VALUES (1);

  INSERT INTO number_tbl VALUES (3);

  INSERT INTO number_tbl VALUES (5);

  SELECT COUNT(*) num_rows,
       COUNT(val) num_vals,
       SUM(val) total,
       MAX(val) max_val,
       AVG(val) avg_val
     FROM number_tbl;

  INSERT INTO number_tbl VALUES (NULL);

  SELECT COUNT(*) num_rows,
       COUNT(val) num_vals,
       SUM(val) total,
       MAX(val) max_val,
       AVG(val) avg_val
     FROM number_tbl;

  SELECT actor_id, count(*)
     FROM film_actor
     GROUP BY actor_id;

  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     GROUP BY fa.actor_id, f.rating
     ORDER BY 1,2;

  SELECT extract(YEAR FROM rental_date) year,
       COUNT(*) how_many
     FROM rental
     GROUP BY extract(YEAR FROM rental_date);

  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     GROUP BY fa.actor_id, f.rating WITH ROLLUP
     ORDER BY 1,2;

  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     WHERE f.rating IN ('G','PG')
     GROUP BY fa.actor_id, f.rating
     HAVING count(*) > 9;

  SELECT fa.actor_id, f.rating, count(*)
     FROM film_actor fa
       INNER JOIN film f
       ON fa.film_id = f.film_id
     WHERE f.rating IN ('G','PG')
       AND count(*) > 9
     GROUP BY fa.actor_id, f.rating;

#==========================================
# 서브쿼리
SELECT customer_id, first_name, last_name
 FROM customer
 WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

SELECT MAX(customer_id) FROM customer;

SELECT customer_id, first_name, last_name
 FROM customer
 WHERE customer_id = 599;

SELECT city_id, city
 FROM city
 WHERE country_id <> 
  (SELECT country_id FROM country WHERE country = 'India');

SELECT city_id, city
 FROM city
 WHERE country_id <> 
  (SELECT country_id FROM country WHERE country <> 'India');

SELECT country_id FROM country WHERE country <> 'India';

SELECT country_id
 FROM country
 WHERE country IN ('Canada','Mexico');

SELECT country_id
 FROM country
 WHERE country = 'Canada' OR country = 'Mexico';

SELECT city_id, city
 FROM city
 WHERE country_id IN
  (SELECT country_id
   FROM country
   WHERE country IN ('Canada','Mexico'));

SELECT city_id, city
 FROM city
 WHERE country_id NOT IN
  (SELECT country_id
   FROM country
   WHERE country IN ('Canada','Mexico'));

  SELECT first_name, last_name
     FROM customer
     WHERE customer_id <> ALL
      (SELECT customer_id
       FROM payment
       WHERE amount = 0);

SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
 (SELECT customer_id
  FROM payment
  WHERE amount = 0);
  
  SELECT first_name, last_name
     FROM customer
     WHERE customer_id NOT IN (122, 452, NULL);

use sakila;
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
############# here!!!
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

  SELECT fa.actor_id, fa.film_id
     FROM film_actor fa
     WHERE fa.actor_id IN
      (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
       AND fa.film_id IN
      (SELECT film_id FROM film WHERE rating = 'PG');

  SELECT actor_id, film_id
     FROM film_actor
     WHERE (actor_id, film_id) IN
      (SELECT a.actor_id, f.film_id
       FROM actor a
          CROSS JOIN film f
       WHERE a.last_name = 'MONROE'
       AND f.rating = 'PG');

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE 20 =
      (SELECT count(*) FROM rental r
       WHERE r.customer_id = c.customer_id);
#
  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE
      (SELECT sum(p.amount) FROM payment p
       WHERE p.customer_id = c.customer_id)
       BETWEEN 180 AND 240;

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE EXISTS
      (SELECT 1 FROM rental r
       WHERE r.customer_id = c.customer_id
         AND date(r.rental_date) < '2005-05-25');

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE EXISTS
      (SELECT r.rental_date, r.customer_id, 'ABCD' str, 2 * 3 / 7 nmbr
       FROM rental r
       WHERE r.customer_id = c.customer_id
         AND date(r.rental_date) < '2005-05-25');

  SELECT a.first_name, a.last_name
     FROM actor a
     WHERE NOT EXISTS
      (SELECT 1
       FROM film_actor fa
         INNER JOIN film f ON f.film_id = fa.film_id
       WHERE fa.actor_id = a.actor_id
         AND f.rating = 'R');

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

use sakila;
  SELECT customer_id, count(*) num_rentals, sum(amount) tot_payments
     FROM payment
     GROUP BY customer_id;

  SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
     UNION ALL
     SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
     UNION ALL
     SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

  SELECT pymnt_grps.name, count(*) num_customers
     FROM
      (SELECT customer_id,
         count(*) num_rentals, sum(amount) tot_payments
       FROM payment
       GROUP BY customer_id
      ) pymnt
       INNER JOIN
      (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
       UNION ALL
       SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
       UNION ALL
       SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit
      ) pymnt_grps
       ON pymnt.tot_payments
         BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
     GROUP BY pymnt_grps.name;

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

  SELECT customer_id,
       count(*) tot_rentals, sum(amount) tot_payments
     FROM payment
     GROUP BY customer_id;

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

  WITH actors_s AS
      (SELECT actor_id, first_name, last_name
       FROM actor
       WHERE last_name LIKE 'S%'
      ),
      actors_s_pg AS
      (SELECT s.actor_id, s.first_name, s.last_name,
         f.film_id, f.title
       FROM actors_s s
         INNER JOIN film_actor fa
         ON s.actor_id = fa.actor_id
         INNER JOIN film f
         ON f.film_id = fa.film_id
       WHERE f.rating = 'PG'
      ),
      actors_s_pg_revenue AS
      (SELECT spg.first_name, spg.last_name, p.amount
       FROM actors_s_pg spg
         INNER JOIN inventory i
         ON i.film_id = spg.film_id
         INNER JOIN rental r
         ON i.inventory_id = r.inventory_id
         INNER JOIN payment p
         ON r.rental_id = p.rental_id
      ) -- end of With clause
     SELECT spg_rev.first_name, spg_rev.last_name,
       sum(spg_rev.amount) tot_revenue
     FROM actors_s_pg_revenue spg_rev
     GROUP BY spg_rev.first_name, spg_rev.last_name
     ORDER BY 3 desc;

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

  SELECT a.actor_id, a.first_name, a.last_name
     FROM actor a
     ORDER BY
      (SELECT count(*) FROM film_actor fa
       WHERE fa.actor_id = a.actor_id) DESC;

#==========================================
# 조인 심화
  SELECT f.film_id, f.title, count(*) num_copies
 FROM film f
   INNER JOIN inventory i
   ON f.film_id = i.film_id
 GROUP BY f.film_id, f.title;

SELECT f.film_id, f.title, count(i.inventory_id) num_copies
 FROM film f
   LEFT OUTER JOIN inventory i
   ON f.film_id = i.film_id
 GROUP BY f.film_id, f.title;

SELECT f.film_id, f.title, i.inventory_id
 FROM film f
   INNER JOIN inventory i
   ON f.film_id = i.film_id
 WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
 FROM film f
   LEFT OUTER JOIN inventory i
   ON f.film_id = i.film_id
 WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
 FROM inventory i
   RIGHT OUTER JOIN film f
   ON f.film_id = i.film_id
 WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id, r.rental_date
 FROM film f
   LEFT OUTER JOIN inventory i
   ON f.film_id = i.film_id
   LEFT OUTER JOIN rental r
   ON i.inventory_id = r.inventory_id
 WHERE f.film_id BETWEEN 13 AND 15;

  SELECT c.name category_name, l.name language_name
 FROM category c
   CROSS JOIN language l;

SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
 UNION ALL
 SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
 UNION ALL
 SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

  SELECT ones.num + tens.num + hundreds.num
 FROM
 (SELECT 0 num UNION ALL
 SELECT 1 num UNION ALL
 SELECT 2 num UNION ALL
 SELECT 3 num UNION ALL
 SELECT 4 num UNION ALL
 SELECT 5 num UNION ALL
 SELECT 6 num UNION ALL
 SELECT 7 num UNION ALL
 SELECT 8 num UNION ALL
 SELECT 9 num) ones
 CROSS JOIN
 (SELECT 0 num UNION ALL
 SELECT 10 num UNION ALL
 SELECT 20 num UNION ALL
 SELECT 30 num UNION ALL
 SELECT 40 num UNION ALL
 SELECT 50 num UNION ALL
 SELECT 60 num UNION ALL
 SELECT 70 num UNION ALL
 SELECT 80 num UNION ALL
 SELECT 90 num) tens
 CROSS JOIN
 (SELECT 0 num UNION ALL
 SELECT 100 num UNION ALL
 SELECT 200 num UNION ALL
 SELECT 300 num) hundreds;

  SELECT DATE_ADD('2020-01-01',
   INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
 FROM
  (SELECT 0 num UNION ALL
   SELECT 1 num UNION ALL
   SELECT 2 num UNION ALL
   SELECT 3 num UNION ALL
   SELECT 4 num UNION ALL
   SELECT 5 num UNION ALL
   SELECT 6 num UNION ALL
   SELECT 7 num UNION ALL
   SELECT 8 num UNION ALL
   SELECT 9 num) ones
   CROSS JOIN
  (SELECT 0 num UNION ALL
   SELECT 10 num UNION ALL
   SELECT 20 num UNION ALL
   SELECT 30 num UNION ALL
   SELECT 40 num UNION ALL
   SELECT 50 num UNION ALL
   SELECT 60 num UNION ALL
   SELECT 70 num UNION ALL
   SELECT 80 num UNION ALL
   SELECT 90 num) tens
   CROSS JOIN
  (SELECT 0 num UNION ALL
   SELECT 100 num UNION ALL
   SELECT 200 num UNION ALL
   SELECT 300 num) hundreds
 WHERE DATE_ADD('2020-01-01',
   INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2021-01-01'
 ORDER BY 1;
   
   
  SELECT days.dt, COUNT(r.rental_id) num_rentals
 FROM rental r
   RIGHT OUTER JOIN
  (SELECT DATE_ADD('2005-01-01',
     INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
   FROM
    (SELECT 0 num UNION ALL
     SELECT 1 num UNION ALL
     SELECT 2 num UNION ALL
     SELECT 3 num UNION ALL
     SELECT 4 num UNION ALL
     SELECT 5 num UNION ALL
     SELECT 6 num UNION ALL
     SELECT 7 num UNION ALL
     SELECT 8 num UNION ALL
     SELECT 9 num) ones
     CROSS JOIN
    (SELECT 0 num UNION ALL
     SELECT 10 num UNION ALL
     SELECT 20 num UNION ALL
     SELECT 30 num UNION ALL
     SELECT 40 num UNION ALL
     SELECT 50 num UNION ALL
     SELECT 60 num UNION ALL
     SELECT 70 num UNION ALL
     SELECT 80 num UNION ALL
     SELECT 90 num) tens
     CROSS JOIN
    (SELECT 0 num UNION ALL
     SELECT 100 num UNION ALL
     SELECT 200 num UNION ALL
     SELECT 300 num) hundreds
   WHERE DATE_ADD('2005-01-01',
     INTERVAL (ones.num + tens.num + hundreds.num) DAY) 
       < '2006-01-01'
  ) days
   ON days.dt = date(r.rental_date)
 GROUP BY days.dt
 ORDER BY 1;

  SELECT c.first_name, c.last_name, date(r.rental_date)
 FROM customer c
   NATURAL JOIN rental r;

  SELECT cust.first_name, cust.last_name, date(r.rental_date)
 FROM
  (SELECT customer_id, first_name, last_name
   FROM customer
  ) cust
   NATURAL JOIN rental r;
            -- Customer: 
  SELECT cust.first_name, cust.last_name, date(r.rental_date)
 FROM
  (SELECT customer_id, first_name, last_name
   FROM customer
  ) cust
   JOIN rental r;
#==========================================
# 조건식
  SELECT first_name, last_name,
   CASE
     WHEN active = 1 THEN 'ACTIVE'
     ELSE 'INACTIVE'
   END activity_type
 FROM customer;

### 여기까지............
  SELECT c.first_name, c.last_name,
   CASE
     WHEN active = 0 THEN 0
     ELSE
      (SELECT count(*) FROM rental r
       WHERE r.customer_id = c.customer_id)
   END num_rentals
 FROM customer c;

  SELECT monthname(rental_date) rental_month,
   count(*) num_rentals
 FROM rental
 WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01'
 GROUP BY monthname(rental_date);

  SELECT
   SUM(CASE WHEN monthname(rental_date) = 'May' THEN 1
         ELSE 0 END) May_rentals,
   SUM(CASE WHEN monthname(rental_date) = 'June' THEN 1
         ELSE 0 END) June_rentals,
   SUM(CASE WHEN monthname(rental_date) = 'July' THEN 1
         ELSE 0 END) July_rentals
 FROM rental
 WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01';

  SELECT a.first_name, a.last_name,
   CASE
     WHEN EXISTS (SELECT 1 FROM film_actor fa
                    INNER JOIN film f ON fa.film_id = f.film_id
                  WHERE fa.actor_id = a.actor_id
                    AND f.rating = 'G') THEN 'Y'
     ELSE 'N'
   END g_actor,
   CASE
     WHEN EXISTS (SELECT 1 FROM film_actor fa
                    INNER JOIN film f ON fa.film_id = f.film_id
                  WHERE fa.actor_id = a.actor_id
                    AND f.rating = 'PG') THEN 'Y'
     ELSE 'N'
   END pg_actor,
   CASE
     WHEN EXISTS (SELECT 1 FROM film_actor fa
                    INNER JOIN film f ON fa.film_id = f.film_id
                  WHERE fa.actor_id = a.actor_id
                    AND f.rating = 'NC-17') THEN 'Y'
     ELSE 'N'
   END nc17_actor
 FROM actor a
 WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';

  SELECT f.title,
   CASE (SELECT count(*) FROM inventory i 
         WHERE i.film_id = f.film_id)
     WHEN 0 THEN 'Out Of Stock'
     WHEN 1 THEN 'Scarce'
     WHEN 2 THEN 'Scarce'
     WHEN 3 THEN 'Available'
     WHEN 4 THEN 'Available'
     ELSE 'Common'
   END film_availability
 FROM film f
 ;

  SELECT 100 / 0;

  SELECT c.first_name, c.last_name,
   sum(p.amount) tot_payment_amt,
   count(p.amount) num_payments,
   sum(p.amount) /
     CASE WHEN count(p.amount) = 0 THEN 1
       ELSE count(p.amount)
     END avg_payment
 FROM customer c
   LEFT OUTER JOIN payment p
   ON c.customer_id = p.customer_id
 GROUP BY c.first_name, c.last_name;

  SELECT (7 * 5) / ((3 + 14) * null);

  SELECT rating, count(*)
 FROM film
 GROUP BY rating;

