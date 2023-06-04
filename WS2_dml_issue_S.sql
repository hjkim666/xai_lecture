
########################################
# DML example 
########################################
#1. issue 데이터베이스를 생성하세요.  
CREATE DATABASE issue;

#2. issue 데이터베이스를 사용하세요. 
USE ISSUE;

#3. mytable 테이블을 생성하세요. 
# 4개의 열을 가지고 있고, ID가 primary key 입니다. 
# ID INT not null
# ACOL INT not null
# BCOL FLOAT
# CCOL VARCHAR(45) 
create table mytable (
ID INT not null,
ACOL INT not null,
BCOL FLOAT,
CCOL VARCHAR(45), 
PRIMARY KEY  (ID));

# 3.mytable을 테이블을 조회하세요. 
SELECT * FROM mytable;

# 4.테이블 수정을 통해  dcol을 추가하세요. dcol은 INT 형이며 NULL 허용하는 컬럼입니다. 
ALTER TABLE mytable 
ADD dcol INT NULL; 


SELECT * FROM mytable;
DESC mytable;

# 4.테이블 수정을 통해  dcol을 변경하세요. dcol은 VARCHAR(20)이며 NULL 허용하는 컬럼입니다. 
ALTER TABLE mytable 
MODIFY dcol VARCHAR(20) NULL;
DESC mytable;

# 5. 테이블 수정을 통해 dcol 컬럼을 삭제 하세요. 
ALTER TABLE mytable 
DROP dcol; 
SELECT * FROM mytable;

#6.mytable에 값을 INSERT하세요. 
# 값은 순서대로, 5,2,3.0,'zzz'입니다. 
INSERT INTO mytable 
VALUE(5,2,3.0,'zzz');

SELECT * FROM mytable;

#7. mytable에 값을 UPDATE 하세요. 
# id = 1인 데이터행에 대해서  acol = 1, bcol=1.0, ccol='xyz'으로 변경하세요. 
UPDATE mytable 
SET acol = 1, bcol=1.0, ccol='xyz' 
WHERE id=1;

SELECT * FROM mytable;

#8. mytable에 id=1인 행을 삭제하세요. DELETE 이용 
DELETE FROM mytable 
WHERE id=1;

#9. mytable에 모든 데이터를 삭제하세요.
TRUNCATE TABLE mytable; 
SELECT * FROM mytable;


#10. mytable을 테이블삭제하세요.  
DROP TABLE mytable;

#11.issue 데이터베이스를 삭제하세요.  
DROP DATABASE ISSUE;

