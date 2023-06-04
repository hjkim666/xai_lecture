######################################
#      Groupby WORKSHOP
######################################
use world; 

#1.city 테이블에서 중복을 제거한 유일한 CountryCode 의 목록을 조회하세요. 
# 힌트: distinct
SELECT DISTINCT CountryCode FROM city;

#2.city 테이블에서 인구수(Population)를 내림차순으로 정렬하여 상위 10개를 출력하세요. 
SELECT * FROM city 
ORDER BY Population DESC
LIMIT 10;

#3. city 테이블에서 CountryCode별 인구의 최대값을 조회하세요. 
SELECT CountryCode, Max(Population) 
FROM city 
ORDER BY Population DESC;  # ERROR 

SELECT CountryCode, format(Max(Population),0)  인구수
FROM city 
GROUP BY CountryCode
ORDER BY 인구수 DESC;

#4. city 테이블에서  국가코드(CountryCode)별 평균 인구수를 조회하세요. 
SELECT CountryCode, format(AVG(Population),0) AS 'Average' 
FROM city 
GROUP BY CountryCode;

#5. city 테이블에서 도시의 개수를 출력하세요. 
SELECT COUNT(*) FROM city; 

#6.city 테이블에서 국가코드별로 최대 인구수가 1000000 명이상인 
# 인구를 가진 국가코드(CountryCode)와 최대 인구수를 조회하세요.  
# Having 
SELECT CountryCode, Max(Population) 
FROM city 
GROUP BY CountryCode
HAVING Max(Population) >= 1000000;

# 국가별 전체인구수? 
SELECT CountryCode, sum(Population) 합산인구 
FROM city 
GROUP BY CountryCode
order by 합산인구 desc 
limit 10;

-- CHN
-- IND
-- BRA
-- USA
-- JPN
-- RUS
-- MEX
-- KOR
-- IDN
-- PAK



# city 테이블에서 국가코드별, 도시명(Name)별 그룹바이 하여,  
# 국가코드, 도시명, 합산 인구수를 출력하세요. 
# ROLLUP을 이용하여 중간 집계 결과를 출력하세요.  
SELECT CountryCode, Name, SUM(Population) 
FROM city 
GROUP BY CountryCode, Name WITH ROLLUP;

SELECT CountryCode, Name, SUM(Population) 
FROM city 
GROUP BY CountryCode, Name ;
