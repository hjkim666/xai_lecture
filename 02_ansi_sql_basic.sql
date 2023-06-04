# Ansi SQL Basic 
### 내장함수 
# 숫자 관련 함수 

# 5 0 5 
select abs(-5), abs(0), abs(+5) from dual; 

# 13 13 -12 -12 
select ceil(12.2), ceiling(12.2), ceil(-12.2), ceiling(-12.2) 
from dual; 

# 12 -13 
select floor(12.6), floor(-12.2) from dual; 

# 숫자관련 함수 
# 1526, 1526, 1526.2, 1526.16, 1530, 2000 
select round(1526.159), round(1526.159, 0), round(1526.159, 1), 
round(1526.159, 2), round(1526.159, -1), round(1526.159, -3) 
from dual;

#1526, 1526.1, 1526.15, 1520, 1000 
select truncate(1526.159, 0), truncate(1526.159, 1), truncate(1526.159, 2), 
truncate(1526.159, -1), truncate(1526.159, -3) from dual;

# 숫자관련함수 
# 8, 8 
select pow(2,3), power(2,3) from dual; 

# 2, 2 
select mod(8,3), 8%3 from dual;

# 9, 3 
select greatest(4,3,7,5,9), least(4,3,7,5,9) from dual;

# 48, 65, 97 
select ASCII('0'), ASCII('A'), ASCII('a') from dual;

# 100번 사원의 이름 Steven king 
select concat(employee_id, '번 사원의 이름', first_name, ' ', last_name) 
from employees 
where employee_id = 100;

# 문자관련함수 
select replace('helloabc!!!', 'abc', ' test ') from dual; 
select instr('helloabc!!!', 'abc') from dual; 
select mid('hello world !!!', 7, 5), substring('hello world !!!' , 7, 5)
from dual;

# 문자관련함수2 
select reverse('!!!dlrow wolleh') from dual; 

select lower('hELlo WorlD !!!'), lcase('hELlo WorlD !!!') 
from dual; 

select upper('hELlo WorlD !!!'), ucase('hELlo WorlD !!!')
from dual;

select left('hello world !!!', 5), right('hello world !!!', 6)
from dual;   

### 날짜 관련함수 
# 실행시점 
select now(), sleep(5), now();
select current_timestamp(), sleep(5), current_timestamp(); #동일 
select sysdate(), sleep(5), sysdate() from dual;
select curdate(), current_date(), curtime(), current_time();
select now() 현재시간, 
       date_add(now(), interval 5 second) 5초후,
       date_add(now(), interval 5 hour) 5시간후, 
       date_add(now(), interval 5 day) 5일후
from dual;

# 날짜관련 함수 
#2023 5 May Month 29 2 0 149 22  
select year(now()), month(now()), monthname(now()), 
		dayname(now()), dayofmonth(now()), dayofweek(now()), 
        weekday(now()), dayofyear(now()), week(now()) 
from dual; 

#2023-05-29 00:00:00 May 
select now(), 
	   date_format(now(), '%Y %M %e %p %l %i %S'), 
       date_format(now(), '%y-%m-%d %H:%i:%s'), 
       date_format(now(), '%y.%m.%d %W'), 
       date_format(now(), '%H시%i분%s초') 
from dual; 

# 논리 관련함수 
# 크다 작다 null 3 b a 
select if(3 > 2, '크다', '작다'), if(3 > 5, '크다', '작다'), 
	   nullif(3,3), nullif(3,5), 
       ifnull(null, 'b'), ifnull('a', 'b') 
from dual;

# 집계 함수 
# 사원의 총수, 급여의 합, 급여의 평균, 최고급여, 최저급여 
select count(employee_id), sum(salary), avg(salary), 
	   max(salary), min(salary) 
from employees;

### Group by 절 
# 부서번호, 부서별 급여의 총합, 평균급여 
select department_id, sum(salary), avg(salary) 
from dual;    #ERROR 

select department_id, sum(salary), avg(salary) 
from employees 
group by department_id 
order by department_id;

# 각 부서별 최고 급여와 최저 급여 
select department_id, max(salary), min(salary) 
from employees 
group by department_id; 

### GROUP BY 절 
# 각 부서별 최고 급여를 받는 사원의 부서와 사번, 이름, 급여 : join 이용 
select a.department_id, e.employee_id, e.first_name, a.smax 
from employees e join( 
						select department_id, max(salary) as smax 
                        from employees 
                        group by department_id 
					) a 
on e.department_id = a.department_id
and e.salary = a.smax; 

### Group by 절 
# 각 부서별 최고급여를 받는 사원의 부서번호, 사번, 이름, 급여 : 다중컬럼 subquery 이용 
select department_id, employee_id, first_name, salary 
from employees 
where (department_id, salary) in (select department_id, max(salary) 
								  from employees
								  group by department_id) 
order by department_id; 

### Having Clause 
# having 절 
# 부서별 평균 급여가 7000이상인 부서 번호, 평균급여 

select department_id, avg(salary) 
from employees 
where avg(salary) > 7000 
group by department_id;     # ERROR  

select department_id, avg(salary) 
from employees 
group by department_id 
having avg(salary) > 7000;

### Having 절 
# 40, 50, 80 번 부서에 근무하는 사원들중 job_id별 급여합이 50000보다 큰 job_id별 평균급여 
# 평균 급여를 내림차순으로 정렬 

select job_id, avg(salary) 
from employees 
where department_id in (40, 50, 80) 
group by job_id 
having sum(salary) > 50000 
order by avg(salary) desc;

# 연습문제 
#40, 50, 80 번 부서에 근무하는 사원들중 전체급여평균보다 높은 job_id별 평균급여 
#내림차순으로 정렬 
use companydb;
select job_id, avg(salary) 
from employees 
where department_id in (40, 50, 80) 
group by job_id 
having avg(salary) > (select avg(salary) from employees) 
order by avg(salary) desc;

# 전체평균 
select avg(salary) from employees;

### Having 절 
# Having 절에서의 subquery 
# 부서별 평균 급여가 20번 부서의 평균급여보다 큰 부서의 부서번호, 평균급여 
select department_id, avg(salary) 
from employees 
group by department_id 
having avg(salary) > (
						select avg(salary) 
                        from employees 
                        where department_id = 20 
                       )
order by avg(salary) desc; 

### DML ##########################################
### create malldb   (01_createl_malldb.sql 실행) 
-- create database malldb;
# malldb table 에 정보 넣기 
# insert data 
#   사용자아이디: hong,  이름:  hong gil-dong, 비밀번호 : 1234, 
#   이메일아이디: gdhong, 이메일도메인 : abc.com, 가입일: 오늘 날짜 

use malldb2;
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `userid` varchar(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `userpwd` varchar(50) NOT NULL,
  `emailid` varchar(50),
  `emaildomain` varchar(50),
  `joindate` date ,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# 테이블 입력전 확인 
SELECT * FROM malldb.member;

# 입력 
INSERT INTO malldb.member (userid, username, userpwd, emailid, emaildomain, joindate)
VALUES ('hong', 'hong gil-dong', '1234', 'gdhong', 'abc.com', now());

INSERT INTO malldb.member (username, userid , userpwd, joindate)
VALUES ('kim gil-dong ', 'kim', '1234', now());

INSERT INTO  malldb.member (username, userid , userpwd, joindate)
VALUES
('lee gil-dong', 'lee', '1234', now()),
('park gil-dong', 'park', '9876', now());

### DML: UPDATE
# member table에 정보 변경 
# 변경 데이터 : 
  # 사용자아이디 : hong인 회원의 정보를 다음으로 변경 
  # 비밀번호 : 9876,  이메일도메인 :  abc.io 

UPDATE malldb.member
SET userpwd = 9876, emaildomain = 'abc.io'
WHERE userid = 'hong';

### DELETE 
# 삭제 데이터 : 사용자아이디가 kim 인 회원의 정보를 삭제 

DELETE from malldb.member
WHERE userid = 'kim';

### Transaction 
# 트랜잭션 도구 
select@@AUTOCOMMIT;

###############################################
### DDL 
### TABLE 생성 
# 회원정보를 저장할수 있는 member2라는 이름의 테이블 생성 
DROP TABLE IF EXISTS `member2`;

CREATE TABLE member2(
	idx INT NOT NULL AUTO_INCREMENT, 
    user_id VARCHAR(16) NOT NULL, 
    username VARCHAR(20), 
    userpwd VARCHAR(16), 
    emailid VARCHAR(20), 
    emaildomain VARCHAR(50), 
    joindate TIMESTAMP NOT NULL default current_timestamp, 
    PRIMARY KEY (idx)
    ) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

### ALTER TABLE ########################################
use malldb; 
# 컬럼 추가 
ALTER TABLE member ADD COLUMN testcol varchar(10); 
desc member;

# 컬럼 변경 
ALTER table member MODIFY COLUMN testcol integer;
desc member;

# 컬럼 이름 변경 
ALTER TABLE member CHANGE COLUMN testcol testcol2 integer;
desc member;

# 컬럼 삭제 
ALTER TABLE member DROP COLUMN testcol2; 
desc member;

# 테이블 이름 변경 
ALTER TABLE member RENAME member2;
show tables;

#원상복귀
ALTER TABLE member2 RENAME member;

# Foreign key 설정 
use empdb;
ALTER TABLE emp ADD foreign key (deptid) references dept(deptid);  

### INDEX ###############################################
use companydb;
show index from companydb.employees;

use malldb2; 
create table test_tbl2 ( 
 a int primary key, 
 b int unique, 
 c int unique 
 ); 
 show index from test_tbl2; 
 
### INDEX 생성 
use companydb; 
-- create unique INDEX jhist_emp_id_st_date_pk 
-- on job_history (employee_id, start_date);   #이미 생성됨 
show index from job_history;

# INDEX 삭제 
# 삭제시 보조인덱스 부터 삭제, alter 이용하여 자동 생성된 인덱스 삭제 
drop index  jhist_emp_id_st_date_pk on job_history; 
alter table job_history drop primary key; 

### 연습문제. member 테이블에 emailid에 인덱스 생성 
use malldb; 
desc member;
create unique INDEX member_emailid on member (emailid);
show index from member;
# 삭제까지 
drop index  member_emailid on member; 
show index from member;


### VIEW ###############################################
use companydb; 
select * from employees where officeCode = 1;

create view employee_officecode_view 
as 
select * from employees where officeCode = 1;

# view의 사용 
select * from employee_officecode_view;

# view 대체 
# 설정한 필드를 대체하기 위해서는 새로운 View로 대체해야함 
create or replace view employee_officecode_view
as 
select employeeNumber, lastname, firstname 
from employees where officeCode = 1; 

# 확인 
select * from employee_officecode_view;

# View 수정 
alter view employee_officecode_view
as 
select employeeNumber, lastname, email 
from employees where officeCode = 1; 

select * from employee_officecode_view;

# View 삭제 
drop view employee_officecode_view;

select * from employee_officecode_view;
