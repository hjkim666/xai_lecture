#### DDL 데이터베이스 생성 #################################
create database dbtest 
default character set utf8mb3 collate utf8mb3_general_ci;

create database dbtest 
default character set utf8mb4 collate utf8mb4_general_ci;

#### 데이터베이스 변경 
alter database dbtest 
default character set utf8mb4 collate utf8mb4_general_ci;

#### 데이터베이스 삭제 
drop database dbtest;

#### 데이터베이스 사용 
use dbtest;

#### companydb 생성 
#### 00_create_companydb.sql 실행

#### DML - SELECT  ########################################
##### 기본 SELECT 
use companydb;

# 모든 사원의 정보 검색 
select * from employees; 

# 사원이 근무하는 부서의 부서번호 검색  107건 
select all department_id from employees;

# 부서번호의 유일한값의 개수  12건
select distinct department_id from employees;

# 회사에 존재하는 모든 부서 27건
select department_id from departments; 

# 모든 사원의 사번, 이름, 급여 검색  107건 
select employee_id, first_name, salary from employees;

#### alias, 사칙연산, null value 
# 모든 사원의 사번, 이름, 급여 * 12(연봉 검색) 
select employee_id as 사번, first_name "이름", 
salary as "급여", salary * 12 "연봉" 
from employees;

# 모든 사원의 사번, 이름, 급여, 급여 * 12(연봉) 커미션, 커미션 포함 연봉 검색 
select employee_id 사번, first_name "이름", salary "급여", 
salary * 12 "연봉", commission_pct, 
(salary + salary * commission_pct) * 12 "커미션 포함연봉1", 
(salary + salary * IFNULL(commission_pct, 0)) * 12 "커미션 포함연봉2" 
from employees; 

### case 
# 모든 사번, 이름, 급여, 급여에 따른 등급 표시 검색 
# 15000이상 "고액연봉" 8000이상 "평균연봉"  8000미만 "저액연봉" 
select employee_id, first_name, salary, 
	case when salary > 15000 then '고액연봉' 
		 when salary > 8000 then '평균연봉' 
         else '저액연봉' 
	end "연봉등급"  
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
# 근무 부서번호가 50, 60, 70에 근무하는 사원의 사번, 이름, 부서번호 검색 
select employee_id, first_name, department_id 
from employees 
where department_id in (50, 60, 70);

# 근무 부서번호가 50, 60, 70 이 아닌 사원의 사번, 이름, 부서 번호 검색 
select employee_id, first_name, department_id 
from employees 
where department_id not in (50, 60, 70); 

### BETWEEN 
# 급여가 6000이상 10000이하인 사원의 사번, 이름, 급여 검색 
select employee_id, first_name, salary 
from employees 
where salary >= 6000 
and salary < 10000; 

select employee_id, first_name, salary 
from employees 
where salary between 6000 and 10000; 

### NULL 비교: IS NULL, IS NOT NULL 
# 근무 부서가 저장되지 않은(알수없는) 사원의 사번, 이름, 부서번호 검색 
select employee_id, first_name, salary 
from employees 
where  department_id = null;     #검색x 

select employee_id, first_name, salary 
from employees 
where department_id is null;

# 커미션을 받는 사원의 사번, 이름, 급여, 커미션 검색 
select employee_id, first_name, salary, commission_pct 
from employees 
where commission_pct is not null; 

### LIKE(%, _) 
# 이름에 x가 들어간 이름 검색 
select employee_id, first_name 
from employees 
where first_name like '%x%';

#이름의 끝에서 3번째 자리에 x가 들어간 사원의 사번, 이름 검색 
select employee_id, first_name 
from employees 
where first_name like '%x__'; 

### ORDER BY 
### 정렬 
# 모든 사원의 사번, 이름, 급여 검색 (단 급여순 정렬 내림차순) 
select employee_id, first_name, salary 
from employees 
order by salary desc; 

# 50, 60, 70 에 근무하는 사원의 사번, 이름, 부서번호, 이름 검색 
# 단, 부서별 정렬(오름차순)후 급여순(내림차순) 검색 
select employee_id, first_name, department_id, salary 
from employees 
order by department_id, salary desc; 

### SET 집합연산자 
# 모든 집합 연산자는 동일한 우선순위를 갖는다. 
# select절에 있는 column의 개수와 type이 일치해야한다. 
select * from employees
union 
select * from departments;   #error  

### SET 
select employee_id, first_name, salary 
from employees
where department_id in (10, 90, 110); 


# department_id 가 70인 사람들의 "salary 합계" 보다 큰 
# 사람들만 employees 테이블에서 가져오기 
select employee_id, first_name, salary 
from employees 
where salary > (
				select sum(salary) 
                from employees
                where department_id = 70
                ); 
                
### UNION 
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

### UNION ALL 
select a.* 
from (
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
                        )
) a
order by a.employee_id;

### INTERSECT : MySQL에서는 지원 x 
select employee_id 
from employees 
intersect 
select distinct employee_id 
from job_history;    #ERROR 

# inner join으로 해결 
select distinct e.employee_id 
from employees e inner join job_history j 
on e.employee_id = j.employee_id; 

# MINUS : MySQL에서는 지원 X 
select employ_id from employees 
minus 
select distinct employee_id from job_history;   #ERROR 

# 1. not in 으로 해결 
select distinct employee_id from employees 
where not in (
				select distinct employee_id 
                from job_history 
			 ); 

# 2. not exist 로 해결 
select distinct e.employee_id 
from employees e 
where not exists ( 
					select j.employee_id 
                    from job_history j 
                    where e.employee_id = j.employee_id 
                    );
             
# 3. left outer join으로 해결 
select distinct e.employee_id 
from employees e 
left join job_history j 
on e.employee_id = j.employee_id 
where j.employee_id is null;
