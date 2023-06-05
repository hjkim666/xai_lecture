#############################################
# subquery & join 
#############################################
use world; 

#1.city테이블에서 국가코드가 프랑스인 도시의 모든 정보를 출력하세요. 
# 프랑스 국가코드를 모를때 Paris를 이용하여 서브쿼리로 국가코드를 찾으세요.   
SELECT * FROM city 
WHERE CountryCode = (SELECT CountryCode 
					FROM city WHERE Name = 'Paris');

# 2. city테이블에서 Paris 도시의 인구수를 구하여, 
# 파리의 인구수보다 많은 도시의 모든 정보를 조회하세요. 서브쿼리사용
SELECT * FROM city 
WHERE Population > ANY (SELECT Population 
					FROM city WHERE Name = 'Paris');
            

# 3.city와 country 테이블을 JOIN하여 모든 정보를 출력하세요.  
SELECT * FROM city 
JOIN country ON city.CountryCode = country.Code ;

# 4. city, country,countrylanguage 3개 테이블을 조인하여 모든 정보를 조회하세요.  
SELECT * FROM city 
JOIN country ON city.CountryCode = country.Code 
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode;


                        