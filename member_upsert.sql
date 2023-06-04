use malldb; 

SELECT * FROM malldb.member;

INSERT INTO member values('hong', 'hong gil-dong', '1234', 'gdhong', 'abc.com', now())
ON DUPLICATE kEY UPDATE 
userid='hong',
username='hong gil-dong',
userpwd='1234',
emailid='gdhong',
emaildomain='abc.com',
joindate=now();

delete from member where userid is null; 
select * from member where userid is null; 
commit;

desc member;

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `userid` varchar(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `userpwd` varchar(50) NOT NULL,
  `emailid` varchar(50) NOT NULL,
  `emaildomain` varchar(50) NOT NULL,
  `joindate` date ,
  PRIMARY KEY (`userid`)
);  
