### JOIN과 SUBQUERY 
### JOIN 
# join의 필요성 
# 사번이 100번인 사원의 사번, 이름, 급여, 부서이름을 출력 
select employee_id, first_name, salary, department_name 
from employees 
where employees_id = 100;   #ERROR 

# 문제 : 사번, 이름, 급여는 employees 테이블에 있고, 
# departmment_name 은 departments 테이블에 있다. 
use companydb;
select employee_id, first_name, salary, department_id 
from employees 
where employee_id = 100;

select department_name 
from departments 
where department_id = 90;

### JOIN의 필요성
# 해결: employee와 departments 테이블을 join 
select employee_id, first_name, department_name 
from employees, departments 
where employees.department_id = departments.department_id 
and employee_id = 100;

# JOIN의 종류 
# INNER JOIN 
# 사번이 100인 사원의 사번, 이름, 급여, 부서번호, 부서이름 출력 
select employee_id, first_name, salary, department_id, department_name 
from employees, departments 
where employees.department_id = departments.department_id 
and employee_id = 100; #ERROR  

select employee_id, first_name, salary, employees.department_id, department_name 
from employees, departments 
where employees.department_id = departments.department_id 
and employee_id = 100; 

# INNER JOIN - ON을 이용한 JOIN 조건 지정 
# 사번이 100번인 사원의 사번, 이름, 급여, 부서번호, 부서이름을 출력 
# alias 사용 
select e.employee_id, e.first_name, e.salary, e.department_id, 
d.department_name 
from employees e, departments d
where e.department_id = d.department_id 
and e.employee_id = 100;  
 
# join 조건 >> on, 일반조건 >> where 
select e.employee_id, e.first_name, e.salary, d.department_name 
from employees e inner join departments d 
on e.department_id = d.department_id 
where e.employee_id = 100;

### JOIN의 종류 
# INNER JOIN - USING을 이용한 join 조건 지정 
select e.employee_id, e.first_name, e.salary, e.department_id, d.department_name 
from employees e join departments d 
using (department_id) 
where e.employee_id = 100;

### LEFT OUTER JOIN 
# 왼쪽 테이블을 기준으로 JOIN 조건에 일치하지 않는 데이터까지 출력 

# 회사에 근무하는 모든 사원의 사번, 이름, 부서이름 
select count(employee_id) from employees;

#LEFT OUTER JOIN예1 
#부서번호가 없는 (부서번호가 null) 사원 검색 
select employee_id, first_name, department_id 
from employees 
where department_id is null;

# 해결 
select e.employee_id, e.first_name, d.department_name 
from employees e left outer join departments d 
using (department_id);

# LEFT OUTER JOIN 예1 
# 회사에 근무하는 모든 사원의 사번, 이름, 부서이름 
select e.employee_id, e.first_name, d.department_name 
from employees e join departments d 
using (department_id);  #문제발생. 총사원은 107명. 결과는 106명 


### RIGHT OUTER JOIN 
# 사원이 근무하는 부서수 
select count(distinct department_id) from employees;
# 회사의 총부서수 27개, 사원이 근부하는 부서11개, 16개는 사원없는 부서 
select d.department_name, e.employee_id, e.first_name 
from employees e join departments d 
using (department_id);

# RIGHT OUTER JOIN 
# 회사에 존재하는 모든 부서의 이름과 부서에 근무하는 사원의 사번, 이름 해결 
select d.department_name, e.employee_id, e.first_name 
from employees e right outer join departments d 
using (department_id);

### SELF JOIN 
# 같은 테이블끼리 JOIN 
# 모든 사원의 사번, 이름, 메니져사번, 메니져이름 
select e.employee_id, e.first_name, m.employee_id, m.first_name 
from employees e inner join employees m 
on e.manager_id = m.employee_id; # 사원수 107명, 결과수 107명? 

# Non-Equi JOIN 
# 테이블의 PK, FK가 아닌 일반 column을 join조건으로 지정 
# 모든 사원의 사번, 이름, 급여, 급여등급 
select e.employee_id, e.first_name, e.salary, s.grade 
from employees e join salgrades s 
where e.salary > s.losal 
and e.salary <= s.hisal; 

select e.employee_id, e.first_name, e.salary, s.grade 
from employees e join salgrades s 
where e.salary between s.losal and s.hisal;

### Quiz1 
# 사번이 101인 사원의 근무이력을 검색 
# 근무당시 정보를 아래를 참고하여 출력 
# 출력 컬럼명: 사번, 이름, 부서이름, 직급이름, 시작일, 종료일 
# 날짜 형식 : 00.00.00 

select e.employee_id 사번, e.first_name 이름, d.department_name 부서이름, j.job_title 직급이름, 
		date_format(h.start_date, '%y.%m.%d') 시작일, date_format(h.end_date, '%y.%m.%d') 종료일
from employees e join job_history h
on e.employee_id = h.employee_id
join departments d
on h.department_id = d.department_id
join jobs j
on h.job_id = j.job_id
where e.employee_id = 101
union
select e.employee_id, e.first_name, d.department_name, j.job_title, 
		(select date_format(date_add(max(end_date), interval 1 day), '%y.%m.%d') from job_history where employee_id = 101), null
from employees e join departments d
using (department_id)
join jobs j
using (job_id)
where employee_id = 101;


### Quiz2 
# 위의 정보를 출력하였다면 위의 정보에 현재 정보를 추가하여 출력 
# 현재 근무 이력의 시작일은 직전 근무이력의 종료일+1 로 설정
# 종료일은 null로 설정 
select date_add(max(end_date), interval 1 day) 
from job_history where employee_id = 101;

####################################################
# SUBQUERY 
# 사번이 100인 사원의 부서이름은? 
select department_name 
from employees e inner join departments d 
on e.department_id = d.department_id 
where e.employee_id = 100; 
# 출력해야 할 결과인 department_name은 departments table에 존재 하지만 지문상 알 수 있는 data인 employee_id는 employees table에 존재한다.
# subquery를 모른다면 어쩔 수 없이 join을 이용해야 한다.
#join의 경우 쿼리가 복잡해 지거나 카테시안곱으로 인한 속도 저하가 올 수 있다. (case by case)
#권장 사항은?

# 해결 
select department_id from employees 
where employee_id =100;

select department_name from departments 
where department_id = 90; 

# => 
select department_name 
from departments 
where department_id = (
						select department_id 
                        from employees 
                        where employee_id = 100
                        ); 

### 서브쿼리 종류 
# Nested Subquery - 단일행 
# 전체 사원의 평균 급여보다 많이 받는 사원의 사번, 이름, 급여, 급여순 정렬
select employee_id, first_name, salary 
from employees 
where salary > (select avg(salary) from employees) 
order by salary desc; 

### Nested Subquery - 다중행 
# 근무도시가 'seattle' 인 사원의 사번, 이름 
select employee_id, first_name 
from employees 
where department_id in (
						select department_id 
                        from departments 
                        where location_id = (
											select location_id 
											from locations
											where binary upper(city) = upper('seattle') 
											)
                        );                    
SELECT * FROM locations WHERE city like 's%';   #대소문자 구분 안함
SELECT * FROM locations WHERE city like binary's%';   #대소문자 구분 

### 다중행 - ANY 
# 적어도 하나만 만족하면 true 
# 모든 사원중 적어도 (최소 급여자 보다) 30번 부서에서 근무하는 사원의 급여보다 많이 받는 
# 사원의 사번, 이름, 급여, 급여번호 

select employee_id, first_name, salary, department_id 
from employees 
where salary > any (
					select salary 
                    from employees 
                    where department_id = 30
                    )
order by salary;

### Nested subquery - 다중행 
# ALL - 적어도 하나만 만족하면 true 
# 30번 부서에서 근무하는 모든(최대급여자보다) 사원들 보다 많은 급여를 받는 사원의 
# 사번, 이름, 급여, 부서번호 
select employee_id, first_name, salary, department_id 
from employees 
where salary > all (
					select salary 
                    from employees 
                    where department_id = 30
                    )
order by salary;

### 서브쿼리 종류 
# Nested Subquery 다중열 
# 커미션을 받는 사원중 메니져 사번이 148인 사원의 급여와 부서번호가 일치하는 사원의 사번, 이름
select employee_id, first_name 
from employees 
where (salary, department_id) in (
									select salary, department_id 
                                    from employees 
                                    where commfission_pct is not null 
                                    and manager_id =148 
                                    ); 
                                    
### INNER VIEW 
# from 절에 사용되는 서브쿼리를 인라인뷰 
# 모든 사원의 평균 급여보다 적게 받는 사람들과 같은 부서에 근무하는 
# 사원의 사번, 이름, 급여, 부서번호
select e.employee_id, e.first_name, e.salary, e.department_id 
from (
	  select distinct department_id 
      from employees
      where salary < (select avg(salary) from employees) 
      ) d join employees e 
on d.department_id = e.department_id;

### INLINE VIEW - TopN질의 
# 모든 사원의 사번, 이름, 급여를 출력 
# 사원의 정보를 급여 순으로정렬, 한페이지당 5명이 출력, 
# 현재 페이지가 3페이지이라고 가정(급여순 11등 ~ 15등까지 출력) 
set @pageno = 3;  -- 변수설정 
select b.rn, b.employee_id, b.first_name, b.salary 
from ( 
		select @rownum := @rownum + 1 as rn, a.* 
        from (
				select employee_id, first_name, salary 
                from employees 
                order by salary desc
                ) a, (select @rownum :=0) tmp 
              ) b
where b.rn > (@pageno * 5 - 5) and b.rn <= (@pageno * 5); 

# 참조 
select @rownum := @rownum + 1 as rn, employee_id, first_name, salary 
from employees e, (select @rownum :=0) tmp 
order by salary desc;

select @rownum := @rownum + 1 as rn, employee_id, first_name, salary 
from employees e, (select @rownum :=0) tmp 
order by salary desc
limit 10, 5;   # rownum 초기화됨 

select a.* 
from (
	select @rownum := @rownum + 1 as rn, employee_id, first_name, salary 
	from employees e, (select @rownum :=0) tmp 
	order by salary desc
    ) a limit 10, 5;  
    
# 이 페이지 조절을 동적으로 하고 싶다면? 
 set @pageno = 3 #변수설정 






### INLINE VIEW - limit 활용 
# 모든 사원의 사번, 이름, 급여를 출력 
# 사원의 정보를 급여순으로 정렬, 한페이지당 5명 출력
# 현재 페이지를 3페이지라고 가정(급여순 11등 ~ 15등까지 출력) 
# <참고> limit a,b
# a: offset으로 a행부터 출력. offset의 기본숫자는 0부터 시작 
# b: limit 출력할 행의 숫자를 결정
select employee_id, first_name, salary 
from employees 
order by salary desc limit 10, 5;

select a.* 
from ( 
		select @rownum := @rownum + 1 as rn, employee_id, first_name, salary 
        from employees e, (select @rownum := 0) tmp 
        order by salary desc 
      ) a limit 10, 5;
      
### 스칼라 서브쿼리 
# select 절에 있는 서브쿼리 
# 한개의 행만 반환 
# 직급 아이디가 IT_PROG인 사원의 사번, 이름, 직급 아이디, 부서이름 
select e.employee_id, e.first_name, job_id, 
		(select department_name from departments d 
        where e.department_id = d.department_id) as department_name 
from employees e 
where job_id = 'IT_PROG';

# 60번 부서에 근무하ㅏ는 사원의 사번, 이름, 급여, 부서번호, 60번부서의 평균급여 
select e.employee_id, e.first_name, salary, department_id, 
      (select avg(salary) from employees where department_id = 60) as avg60 
from employees e 
where department_id = 60;

# 부서번호가 50인 부서의 총급여, 60인 부서의 급여 평균급여, 
# 90인 부서의 최저급여 
select 
	(select sum(salary) from employees where department_id = 50) sum50, 
    (select avg(salary) from employees where department_id = 60) avg60, 
    (select max(salary) from employees where department_id = 90) max90, 
    (select min(salary) from employees where department_id = 90) min90 
from dual;
    
### 서브쿼리를 이용한 CIUD - CREATE
# employees 테이블을 emp_copy 라는 이름으로 복사 (컬럼 이름 동일) 
create table emp_copy 
select * from employees; 

# employees table 구조만 emp_blank 라는 이름으로 생성(컬럼이름 동일) 
create table emp_blank 
select * from employees where 1 = 0; 

select * from emp_blank;

# 테스트 
use companydb;
create table emp_blank2 
select * from employees; 

select * from emp_blank2;
select * from employees where 1 = 0;   # or 의 의미. null 제외 
select * from employees where commission_pct is not null;

# 50번 부서의 사번(eid), 이름(name), 급여(sal), 부서번호(did)만 emp50이라는 이름으로 생성
create table emp50 
select employee_id eid, first_name name, salary sal, department_id did 
from employees 
where department_id = 50; 

select * from emp50;

### 서브쿼리를 이용한 CIUD - INSERT 
# Employees table에서 부서번호가 80인 사원의 모든 정보를 emp_blank에 insert 
insert into emp_blank 
select * from employees 
where department_id = 80; 

### 서브쿼리를 이용한 CIUD - UPDATE 
# employee 테이블의 모든 사원의 평균 급여보다 적게 받는 emp50 테이블의 
# 사원의 급여를 500인상 
update emp50 
set sal = sal + 500 
where sal < (select avg(salary) from employees); 

set sql_safe_updates=0; -- 일시적 safe 모드 해제 

### 서브쿼리를 이용한 CIUD - DELETE 
# employee 테이블의 모든 사원의 평균급여보다 적게받는 emp50 table의 사원은 퇴사 
delete from emp50 
where sal < (select avg(salary) from employees); 

select * from emp50;

