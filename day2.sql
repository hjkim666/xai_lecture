use companydb;

select department_id, max(salary), min(salary) ,
		max(salary) - min(salary)  차이,
		max(salary)/min(salary) 비율
from employees 
group by department_id;



select a.department_id, e.employee_id, e.first_name, a.smax 
from employees e  join (
						select department_id, max(salary) as smax 
						from employees
						group by department_id
						) a 
on e.department_id = a.department_id 
and e.salary = a.smax;

select department_id, employee_id, first_name, salary 
from employees
where (department_id, salary)  in (select department_id, max(salary) as smax 
									from employees
									group by department_id);
                                    
select  department_id, avg(salary) 
from employees
group by department_id     # 12건
having avg(salary) > 7000;     # 6건 

select * from jobs;
select * from employees;

select job_id, avg(salary) 평균급여, sum(salary)
from employees 
where department_id in (40, 50, 80) 
group by job_id
having sum(salary) > 50000 
order by 평균급여 desc;



select * from departments 
where department_id in (40, 50, 80);










# 연습문제 
# 40, 50, 80 번 부서에 근무하는 사원들중 '전체급여평균'보다 높은 job_id별 평균급여 
# 내림차순으로 정렬 
select job_id, avg(salary) 
from employees 
where department_id in (40, 50, 80) 
group by job_id 
having avg(salary) > (select avg(salary) from employees) 
order by avg(salary) desc;

select avg(salary) from employees;  #6461 




select * from departments;

select department_id, avg(salary) 
from employees 
group by department_id 
having avg(salary) > (
						select avg(salary) 
                        from employees 
                        where department_id = 20 
                       )
order by avg(salary) desc; 

select * from departments 
where department_id = 20;

select * from departments 
where department_id in (90, 110, 70);

####################################
# DML 

use malldb;
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `userid` varchar(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `userpwd` varchar(50) NOT NULL,
  `emailid` varchar(50),
  `emaildomain` varchar(50),
  `joindate` date ,
  PRIMARY KEY (`userid`)
);
INSERT INTO malldb.member (userid, username, userpwd, emailid, emaildomain, joindate)
VALUES ('hong', 'hong gil-dong', '1234', 'gdhong', 'abc.com', now());

INSERT INTO malldb.member (username, userid , userpwd, joindate)
VALUES ('kim gil-dong ', 'kim', '1234', now());

INSERT INTO  malldb.member (username, userid , userpwd, joindate)
VALUES
('lee gil-dong', 'lee', '1234', now()),
('park gil-dong', 'park', '9876', now());


UPDATE member
SET userpwd = '9876', emaildomain = 'abc.io'
WHERE userid = 'hong';

select * from member where userid = 'hong';

# 연습문제 
# lee  ->  userpwd  '0000', emailid  'lee', emaildomin 'abc.com'
UPDATE member
SET userpwd = '0000', emailid = 'lee' , emaildomain = 'abc.com'
WHERE userid = 'lee';
select * from member where userid = 'lee';

# 삭제 
delete from member where userid = 'kim';
select * from member where userid = 'kim';

select@@autocommit;  # 1 : autocommit 

create database test;
alter database test 
default character set utf8mb4;

drop database test;

### 테이블 생성 
use malldb; 

create table member2(
   idx int not null auto_increment, 
   userid varchar(16) not null, 
   username varchar(20), 
   userpwd varchar(16), 
   emailid varchar(20), 
   emaildomain varchar(50),
   joindate timestamp not null default current_timestamp,
   primary key(idx)
);

desc member2;
#############################################
# Alter table 
#############################################
use malldb; 

#컬럼추가 
ALTER TABLE member ADD COLUMN testcol varchar(10); 
desc member;

#컬럼변경 
ALTER TABLE member MODIFY COLUMN testcol int; 
desc member; 

#컬럼이름변경 
ALTER TABLE member CHANGE COLUMN testcol testcol2 int; 
desc member; 

# 컬럼 삭제 
ALTER TABLE member DROP COLUMN testcol2; 
desc member;

# 테이블명 변경 
ALTER TABLE member RENAME member3; 
show tables;

# 원상복귀 
ALTER TABLE member3 RENAME member;
show tables;

use companydb;
show index from employees;

###### INDEX 
use malldb;
drop table test_tbl2;
create table test_tbl2(
	a int primary key, 
    b int unique, 
    c int unique, 
    d int
);
show tables;
show index from test_tbl2;

create unique index test_tbl2_d_idx on test_tbl2(d);
drop index test_tbl2_d_idx on test_tbl2;
show index from test_tbl2;

### View 
use companydb; 
select * from employees where department_id = 20; 

create view employees_marketing 
as 
select * from employees where department_id = 20; 

select * from employees_marketing;

# view변경 
create or replace view employees_marketing
as 
select first_name, last_name 
from employees where department_id = 20;

select * from employees_marketing;

### 삭제 
drop view employees_marketing;

###########################################
# INNER JOIN 
select employee_id , first_name, last_name, department_name 
from employees e, departments d 
where e.department_id = d.department_id 
and e.employee_id = 100; 

select employee_id , first_name, last_name, department_name 
from employees e inner join departments d
on e.department_id = d.department_id 
where e.employee_id = 100; 
 

select employee_id , first_name, last_name, department_name 
from employees e left outer join departments d
on e.department_id = d.department_id;

select employee_id , first_name, last_name, department_name 
from employees e left outer join departments d
using (department_id);

select d.department_name, e.employee_id, e.first_name 
from employees e right outer join departments d 
using (department_id);


select e.employee_id, e.first_name, m.employee_id, m.first_name 
from employees e inner join employees m 
on e.manager_id = m.employee_id;

select * from employees where employee_id in (101, 100, 102);


