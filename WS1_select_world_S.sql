#1.데이터베이스 목록확인해보세요. 
SHOW DATABASES;

#2. world 데이터베이스 사용 쿼리를 작성하세요. 
USE world; 

#3.모든 테이블명을 조회해보세요. 
SHOW TABLES; 
SHOW TABLE STATUS;
 
#4.city 테이블의 스키마를 조회해보세요. 
DESCRIBE CITY;
DESC CITY;

# 5.city 테이블에서 도시이름(Name), 국가코드(CountryCode)를 조회하세요. 
SELECT Name, CountryCode FROM city; 

# 6.city 테이블에서 인구(populatin)가 10000000 이상인 도시를 조회하세요. 
SELECT * FROM city WHERE Population >= 10000000;

# 7.city 테이블에서 인구(population)가 1000000 초과 2000000 미만인 도시를 조회하세요. 
SELECT * FROM city 
WHERE Population > 1000000
AND Population < 2000000;

#8.city 테이블에서 한국의 도시를 조회하세요. 한국의 국가코드는 'KOR'입니다. 
SELECT * FROM city 
WHERE CountryCode = 'KOR';

#9. city 테이블에서 미국의 도시를 조회하세요. 미국의 국가 코드는 'USA'입니다.  
SELECT * FROM city 
WHERE CountryCode = 'USA';

#10. city테이블에서 한국의 도시 중 인구 100만 이상인 도시의 모든정보를 조회하세요.  
SELECT * FROM city 
WHERE CountryCode = 'KOR' 
AND Population >= 1000000;

-- FORMAT(컬럼명,소수점이하 자리수) 
SELECT ID, Name, CountryCode, District, format(Population, 0) FROM city 
WHERE CountryCode = 'KOR' 
AND Population >= 1000000;

#11. city 테이블에서 한국의 도시 중 인구 100만과 200만 사이의 도시의 모든 정보를 조회하세요. 
# 힌트: between 사용
SELECT * FROM city 
WHERE CountryCode = 'KOR' 
AND Population BETWEEN 1000000 and 2000000;

#12. city테이블에서 이름이 'Seoul' 또는 'New York' 또는 'Paris' 인 도시의 모든 정보를 조회하세요.
# 힌트: IN 사용   
SELECT * FROM city 
WHERE Name IN ('Seoul', 'New York', 'Paris');

# 13. city 테이블에서 국가코드가 한국, 미국, 프랑스인 도시의 모든 정보를 조회하세요.  
SELECT * FROM city 
WHERE CountryCode IN ('KOR', 'USA', 'FRA');

#14. city 테이블에서 국가코드가 'KO'로 시작하는 도시를 문자열검색을 통해 도시의 모든 정보를 조회하세요. 
# KO로 시작하며, 국가코드는 총 3자리 
SELECT * FROM city 
WHERE CountryCode LIKE 'KO_';

# 15. city 테이블에서 국가코드가 'K'로 시작하는 도시를 문자열 검색을 통해 도시의 모든 정보를 조회하세요. 
SELECT * FROM city 
WHERE CountryCode LIKE 'K%';

# 16. city 테이블을 Population순으로 오름차순 정렬하세요. 
SELECT * FROM city 
ORDER BY Population; 

# 17. city 테이블을 Population순으로 내림차순 정렬하세요. 
SELECT * FROM city 
ORDER BY Population DESC; 

#18. city테이블을 CountryCode은 오름차순, Population은 내림차순으로 정렬하세요. 
SELECT * FROM city 
ORDER BY CountryCode ASC, Population DESC;

# 19. city 테이블에서 ContryCode가 한국(KOR)인 도시를 인구수(Population)로 내림차순해서 조회하세요. 
SELECT * FROM city 
WHERE CountryCode = 'KOR'
ORDER BY Population DESC;

DESC COUNTRY;

#20. country 테이블에서 면적(SurfaceArea)을 내림차순으로 정렬하여 조회하세요. 
SELECT * FROM country 
ORDER BY SurfaceArea DESC; 

