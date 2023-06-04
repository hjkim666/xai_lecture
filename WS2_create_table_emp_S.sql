#데이터베이스 생성 
CREATE DATABASE empdb;

USE empdb; 

drop table IF EXISTS EMP CASCADE;
CREATE TABLE EMP(
   empid CHAR(4) NOT NULL,
   ename VARCHAR(20), 
   deptid CHAR(3), 
   hire_date DATE, 
   job VARCHAR(20), 
   salary INT, 
   PRIMARY KEY(empid) 
); 
desc emp;

-- CREATE TABLE EMP(
--    empid CHAR(4) NOT NULL PRIMARY KEY,
--    ename VARCHAR(20), 
--    deptid CHAR(3), 
--    hire_date DATE, 
--    job VARCHAR(20), 
--    salary INT
-- ); 

INSERT INTO emp (empid, ename, deptid, hire_date, job, salary) VALUES 
('1001', 'hong gil-dong', '100', '2001-01-01','development', 500);
select * from emp;

drop table IF EXISTS dept CASCADE;
CREATE TABLE dept(
 deptid CHAR(3), 
 dname VARCHAR(20), 
 budget INT, 
 PRIMARY KEY(deptid)
); 

INSERT INTO dept (deptid, dname, budget) values 
('100', 'sales',100000),
('200', 'manage', 300000),
('300', 'lab', 500000),
('400','consulting',600000); 

select * from dept;

ALTER TABLE emp ADD foreign key (deptid) references dept(deptid);  

desc emp;

#### 참고 
# id를 auto_increment로 할 경우 

CREATE TABLE EMP2(
   empid int NOT NULL auto_increment,
   ename VARCHAR(20), 
   deptid CHAR(3), 
   hire_date DATE, 
   job VARCHAR(20), 
   salary INT, 
   PRIMARY KEY(empid) 
); 

INSERT INTO emp2 (ename, deptid, hire_date, job, salary) VALUES 
('hong gil-dong', '100', '2001-01-01','development', 500);
SELECT * FROM emp2;


truncate emp2;  # 데이터 영구삭제 -> 원복 안됨 
delete from emp2;  #데이터 트랜젝션 -> 원상복귀 
drop table emp2;  # 테이블 삭제 

CREATE TABLE emp3
(
   empid CHAR(4) NOT NULL PRIMARY KEY,
   ename VARCHAR(20), 
   deptid CHAR(3), 
   hire_date DATE, 
   job VARCHAR(20), 
   salary INT, 
   FOREIGN KEY (deptid)
   REFERENCES dept(deptid) ON UPDATE CASCADE
);

desc emp3;

#### update 예제 
select * from emp;
update emp set salary = 600 where empid = '1001';

#### update 
select * from dept;
update dept set budget = 200000 where deptid = '100';

