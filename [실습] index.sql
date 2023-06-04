create table test_tbl2 
(
   a int primary key, 
   b int unique, 
   c int unique
);

show index from test_tbl2; 
   
   
use malldb;

show index from malldb.member;

select * from malldb.member;


drop index jhist_emp_id_st_date_pk on job_history; 

alter table job_history drop primary key;