# 실행  : ctrl + enter    
# 주석 : ctrl + / 
# 저장 : ctrl + s 

create database dbtest; 

# 데이터베이스 생성 
create database dbtest2 
default character set utf8mb3 collate utf8mb3_general_ci;    

# 삭제 
drop database dbtest2; 
drop database dbtest;

# 사용 
use jb_db;
use companydb;

######################
use companydb; 
select * from employees;
desc employees;
show tables;

select employee_id, first_name from employees;
select department_id from employees;  #107

select all department_id from employees; #107
select distinct department_id from employees;  #12

############################################
select employee_id as "사번", first_name "이 름", 
salary as "급여", salary * 12 "연봉"  
from employees;

select employee_id 사번, first_name "이름", salary "급여", 
salary * 12 "연봉", commission_pct, 
(salary + salary * commission_pct) * 12 "커미션 포함연봉1", 
(salary + salary * IFNULL(commission_pct, 0)) * 12 "커미션 포함연봉2" 
from employees; 

select employee_id, first_name, salary, 
	case when salary > 15000 then "고액연봉" 
		 when salary > 8000 then "평균연봉" 
         else "저액연봉" 
	end  "연봉등급" 
from employees;

### AND, OR, NOT 
# 근무부서가 50이고, 급여가 7000이상인 사원의 사번, 이름, 부서번호 검색 
select employee_id, first_name, salary, department_id 
from employees 
where department_id = 50  and salary >= 7000; 

# 근무부서가 50, 60, 70 에 근무하는 사원의 사번, 이름, 부서번호 검색 
select employee_id, first_name, department_id 
from employees 
where department_id = 50 
or department_id = 60 
or department_id = 70; 

### IN 
#### 근무 부서번호가 50, 60, 70에 근무하는 사원의 사번, 이름, 부서번호 검색 
select employee_id, first_name, department_id 
from employees 
where department_id in (50, 60, 70);

#### 근무 부서번호가 50, 60, 70 이 아닌 사원의 사번, 이름, 부서 번호 검색 
select employee_id, first_name, department_id 
from employees 
where department_id not in (50, 60, 70);

### BETWEEN 
#### 급여가 6000이상 10000이하인 사원의 사번, 이름, 급여 검색 
select employee_id, first_name, salary 
from employees 
where salary >= 6000 
and salary <= 10000; 

select employee_id, first_name, salary 
from employees 
where salary between 6000 and 10000; 

### NULL 
select employee_id, first_name, salary 
from employees 
where department_id is NULL;

select * from employees 
where employee_id = 178;   #primary key  PK 

select employee_id, first_name, salary 
from employees 
where commission_pct is NOT NULL;

# like 검색 
select employee_id, first_name 
from employees
where first_name like '%x%';

select employee_id, first_name 
from employees
where first_name like '%x';   #x로 끝나는 이름 

-- 'x%'  x로 시작하는 사람 
-- '%x__'   x포함 3글자 
-- `_x%`  두번째 글자가  x인 
-- `x_%_%` x로 시작하고 글자수가 3개 이상 
-- `x%a`  x로 시작하고 a로 끝나는  

select employee_id, first_name 
from employees
where first_name like 'x%'; 

select employee_id, first_name 
from employees
where first_name like '%x__'; 

# 두번쨰 글자가 x인 사람 ?
select employee_id, first_name 
from employees
where first_name like '_x%'; 

# a로 시작하고 a로 끝나는 사람 ?   
select employee_id, first_name 
from employees
where first_name like 'a%a'; 


select employee_id, first_name, salary
from employees
order by salary desc
limit 20;

select employee_id, first_name, department_id, salary
from employees
order by department_id, salary desc;

###### 
select employee_id, first_name, salary 
from employees
where department_id in (10, 90, 110)
union
select employee_id, first_name, salary 
from employees
where salary > (
				select sum(salary) 
                from employees 
                where department_id = 70
				);

select employee_id, first_name, salary 
from employees
where department_id in (10, 90, 110)
union all
select employee_id, first_name, salary 
from employees
where salary > (
				select sum(salary) 
                from employees 
                where department_id = 70
				);


################################################
# Function - 날짜 
################################################
use companydb;
select date_format(hire_date, '%y/%m/%d') 날짜,
 dayofmonth(hire_date),
 dayofweek(hire_date),
 weekday(hire_date),
 dayofyear(hire_date),
 week(hire_date),
 to_days(hire_date)
 from employees;
 
 
#######################################
# Funtion 내장함수
#######################################
select abs(-5) , abs(0), abs(+5)
from dual; 

select ceil(12.2), ceiling(12.2), ceil(-12.2), ceiling(-12.2)
from dual;

select floor(12.6), floor(-12.2) 
from dual;

select round(1526.159), round(1526.159, 2), round(1526.159, -1)
from dual;

select truncate(1526.159, 0), truncate(1526.159, 1),truncate(1526.159, -1)
from dual;
 
 select pow(2,3), power(2,3) 
 from dual;
 
 select mod(8,3), 8%3
 from dual;
 
select greatest(4,3,7,5,9), least(4,3,7,5,9)
from dual;

select ASCII('0') , ASCII('A')
from dual;

use companydb;
select concat(employee_id,'번 사원의 이름:', first_name,' ', last_name) 
from employees;

####################################
# 날짜 함수 
select now(), sleep(5), now();
select current_timestamp(), sleep(5), current_timestamp();
select sysdate(), sleep(5), sysdate();

select now(), sysdate(), current_timestamp();

select curdate(), current_date(), curtime(), current_time();

select now() 현재시간, 
	   date_add(now(), interval 5 second) 5초후, 
       date_add(now(), interval 5 hour) 5시간후, 
       date_add(now(), interval 5 day) 5일후 ; 
       
select year(now()), month(now()), monthname(now()), 
 dayname(now()), dayofmonth(now()), dayofweek(now())
from dual;

select now(), 
	   date_format(now(), '%Y %M %e %p %l %i %S'),
       date_format(now(), '%y %m %e %H:%i:%S')     
from dual;
select date_format(hire_date, '%Y %M %e %p %l %i %S'), 
	   year(hire_date), month(hire_date), day(hire_date), dayname(hire_date)
from employees;

select if(3 > 2, '크다', '작다'), if(3 > 5, '크다', '작다'),
	   nullif(3,3), nullif(3, 5), ifnull(null, 'b'), ifnull('a', 'b')
from dual;

select count(employee_id) , format(sum(salary)*1300, 0), 
avg(salary), min(salary), max(salary)
from employees;
	

select department_id, sum(salary), avg(salary) 평균금액
from employees
group by department_id
order by 평균금액 desc;

select  * from departments where department_id = 90;




 
 
 
 
 
 
 
 


