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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


SELECT * FROM malldb.member;

-- insert ------------------------------------
INSERT INTO malldb.member (userid, username, userpwd, emailid, emaildomain, joindate)
VALUES ('hong', 'hong gil-dong', '1234', 'gdhong', 'abc.com', now());

INSERT INTO malldb.member (username, userid , userpwd, joindate)
VALUES ('kim gil-dong ', 'kim', '1234', now());

INSERT INTO  malldb.member (username, userid , userpwd, joindate)
VALUES
('lee gil-dong', 'lee', '1234', now()),
('park gil-dong', 'park', '9876', now());

-- update --------------------------------------
UPDATE malldb.member
SET userpwd = 9876, emaildomain = 'abc.io'
WHERE userid = 'hong';

-- delete --------------------------------------
DELETE from malldb.member
WHERE userid = 'kim';


