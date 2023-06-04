##################################################################
# sakila DB WORKSHOP２
# https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html
##################################################################
use sakila;


# 1. 영화배우의 아이디별, 영화등급별로 그룹바이 하여 각 개수 를 출력하세요. 
# 각배우별 총합도 출력하세요.(중간합계) 
# 결과 :  영화배우 아이디, 영화등급, 개수  
  
  
  


     
# 2. 고객이름(first_name, last_name)과 고객의 주소(address) 를 조회하세요. 
# 참조 테이블 : customer, address





# 3. 고객의 이름(first_name, last_name)과, 고객의 주소가 속해있는 도시를 조회하세요. 
# 참조테이블: 고객테이블(customer),address테이블, city 테이블을 이용하세요.  








# 4. address의 구역(district)이 "California"인  주소, 도시명,  고객이름(first_name, last_name) 을 조회하세요. 
# 참고테이블: customer, address, city 
# 결과 : first_name, last_name, 주소, 도시 
  
  
  
  
  
  
  
# 5. 배우의 이름이  CATE MCQUEEN, CUBA BIRCH 인 두명의 배우가 출연한 영화 제목을 조회하세요.  
# 참조 테이블: film, film_acter, actor  
# 힌트: 배우 이름은 first_name과 last_name이 따로 저장되어 있음.  




  
         
         
# 6. 고객이름 중 first_name이 J로 시작하고, last_name이 D로 시작하는 고객명과 
# 배우이름 first_name이 J로 시작하고, last_name이 D로 시작하는 배우이름을  모두 출력하세요.  
# 중복된 행이 보여도 됩니다. (UNIONALL) 
# 참조테이블: customer, actor 
# 결과 : first_name, last_name

  SELECT c.first_name, c.last_name
     FROM customer c
     WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
     UNION ALL
     SELECT a.first_name, a.last_name
     FROM actor a
     WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

# 7. payment 테이블에서 고객아이디 별로 최대 지불금액(amount), 최소 지불금액, 
# 평균 지불금액, 지불금앱의 합산, count 값을 출력하세요.  







# 8. acter_id 별로 몇건씩의 영화에 출연했는지 출력하세요. 
# 참조테이블 : film_actor  



     
# 9. 배우별(acter), 등급별(rating), 개수(count)를 출력하세요. 
# 배우별, 등급별로 오름차순 정렬하세요. 
# 참조테이블 : film_acter, film 
 





# 10. 영화 등급이 'G' 또는 'PG'인 영화를 골라 배우별(actor), 등급별(rating), 개수(count)를 출력하세요.
# 개수는 9개 이상인 영화만 해당됩니다.
# 참조테이블  film_actor, film 
  





# 11. 무료영화 대여 기록이 없는 고객명(first_name, last_name)을 출력하세요. 
# payment 지불테이블, 지불금액은 amount, 무료영화는 payment 테이블의 컬럼 amount가 0인 영화        






  
# 12. 'United States','Mexico','Canada'에 속한 국가들의 도시(city)를 구하여 
# address 가 속한 도시의 고객들에 대해서 고객별 대여건수를 출력하세요. 
# 최종 출력: 고객별 대여건수 
# 참고 테이블 : rental, customer, address, city, country 







       
# 13. 'United States','Mexico','Canada'에 속한 국가들의 도시(city)의 고객들의 
# 가장많은 대여수 보다 많이 대여한 고객의 아이디와 대여수를 출력하세요. 
# 참고: 28번 쿼리를 이용하여 쿼리를 확장해보세요.  
# 참고테이블: rental, customer, address, city, country 
# 결과 
# |customer_id | count(*) |
# |     148    |     46   |










# 14. 'Bolivia','Paraguay','Chile' 의 고객의 대여금(amount)의 합계의 최소값보다 큰 고객의 
# 고객아이디(customer_id)와 합계금액(amount)을 출력하세요. 
# 참고테이블 : payment, customer, address, city, country 












# 15. 2005-05-25 이전에 대여 기록이 있는 고객의 이름(first_name, last_name) 을 출력하세요. 
# 참조 테이블: customer, rental 

         






# 16. 고객명(first_name, last_name), 고객당 총대여건수, 총대여금액을 출력하세요.  
# 참조테이블 : customer, payment 








# 17. 고객의 first_name별, last_name별, 고객의 도시(city) 별 
# 총 지불급액(amount), 총 대여수 를 출력하세요. 
# 테이블 : payment, customer, address, city 
# 결과 (일부) 
# |first_name | last_name | 도시  | 총지불급액 |  총 대여수| 
# |MARY       |	SMITH     |Sasebo|	118.68  |32       |  등등 





     
       
# 18.  영화배우 아이디(actor_id), 영화배우의 first_name, 영화배우의 last_name을 출력하세요.
# 영화 출연건수로 내림차순 정렬하여 출력하세요.    
# 참조 테이블: actor, film_actor 







# 19.  영화아이디(film_id), 영화제목(title), 영화카피의 개수(재고수)를 출력하세요. 
# 참조 테이블: inventory, film








# 20. 영화아이디(film_id)가 13이상, 15이하의 영화에 대해서 
# 영화아이디(film_id), 영화제목(title), 제고아이디(inventory_id), 대여일자(rental_date)를 출력하세요. 
# 참조테이블: film, invertory, rental 





 
 
 # 21. 고객테이블에서 고객명(first_name, last_name)과  active가 1이면, "active" 라고 찍고, 
 # 아니면 "inactive"라고 출력하세요. 
 # 힌트: CASE 조건식을 이용하세요. 
 # 결과 (일부) 
 # | first_name | last_name | 활동여부 | 
 # | MARY       |  SMITH    | ACTIVE|




 