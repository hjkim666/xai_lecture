##################################################################
# sakila DB WORKSHOP
# https://dev.mysql.com/doc/sakila/en/sakila-structure-tables.html
##################################################################


# 1. 고객테이블 customer 테이블을 조회하세요. 


# 2. category 테이블을 조회하세요. 


# 3. language 테이블을 조회하세요. 
 

# 4. language 테이블에서  language_id와  name(대문자로 출력)을 조회하세요. 



# 5. film_acter 테이블에서 acter_id로 오름차순 정렬하여 모든 정보를 조회하세요. 



# 6. film_actor 테이블에서 중복 제거된 acter_id를 조회하세요. 


# 7. 고객테이블(customer) 에서 first_name이 JESSIE 인 고객의 last_name과 first_name을 
# concat 함수를 이용하여 전체이름을 출력하세요.  
-- 출력 결과> 
-- BANKS, JESSIE
-- MILAM, JESSIE 

# 8. cust_vw 라는 이름으로 view를 생성하세요. 
# customer 테이블에서 customer_id, first_name, last_name, active 
# 정보를 조회하는 view입니다.



# 9. 위에서 생성한 view를 조회하여, active=0인 현재 활동 하지 않는 배우의 
# 이름을 출력하세요. (first_name과 lastname)      



# 10. rental 테이블의 rental_date 가 '2005-06-14' 일인 고객의 first_name, last_name, 
# rental_date (시간포함)를 조회하세요. 고객정보는 customer 테이블에 있습니다 







# 11. film 테이블에서 rating 이 G 등급이고, 대여기간(rental_duration)이 7일 이상인 
# 영화의 타이틀을 조회하세요 





# 12. rental 건수가 40건 이상인 고객의 이름(first_name, last_name)과 대여건수를 출력하세요.  
# rental 테이블의 대여정보와, customer 테이블의 고객정보를 이용하세요. 







# 13. 대여일이 '2005-06-14'인 고객의 이메일과 반납일(return_date)을 조회하세요. 
# 고객의 email은 customer 테이블에 return_date는 rental 테이블에 있습니다.   







# 14. 대여일자(rental_date)가 '2005-06-14'이상 '2005-06-16'이하인 
# 고객아이디(customer_id)와, 대여일자(rental_date)를 조회하세요.      





	
# 15. payment 테이블에서 지불금액(amount)이 10.0이상 11.99이하인 지불건수에 대해서 
# 고객아이디(customer_id), 지불일자(payment_date), 지불금액(amount) 




# 16. 문자열검색을 통해 영화제목에 "PET"가 들어가는 영화의 등급(rating)에 속한 영화를 
# 찾아 타이틀(title)과 등급(rating)을 조회하세요. 





# 17. 반납일자(return_date)가 없는(null) 고객아이디(customer)와 rantal_id를 조회하세요. 




# 18. rental 테이블의 rental_date 의 연도, 월, 일, 시간, 요일을 출력하세요. 
# 날짜함수 사용  
# <결과>   
# | renatal_date         | 연도 | 월  | 일  | 시간 | 요일    |
# | 2005-05-24 22:53:30  |2005 |  5  | 24 |  22 | Tuesday|




# 19.rental 테이블의 대여일(rental_date)의 요일별로 개수를 출력하세요. 
# 개수(대여건수)로 내림차순 정렬하세요. 





# 20. rental 테이블의 대여월 중 가장 많은 대여가 일어난 월을 출력하세요. 
