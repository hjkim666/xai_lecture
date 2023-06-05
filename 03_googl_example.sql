use malldb;
SELECT * FROM malldb.googl;

select count(*) from malldb.googl;
select * from malldb.googl;
select * from stock; 
select count(*) from stock;

# 순위함수 rank 예제 
# rank() 중복순위 적용, 다음 순위가 중복순위 적용후 순위 ex. 1,2,2,4
# danse_rank() 중복순위 적용. 다음순위는 중복 순위 적용 ex. 1,2,2,3  
select *, rank() over(order by Close desc)  from googl;
select *, rank() over(partition by ID ORDER BY Close desc)  from stock;


select ID, date, Close, LEAD(Close, 1) over (partition by ID order by date)  내일값 from stock;
select ID, date, Close, LAG(Close, 1) over (partition by ID order by date)  어제값 from stock;

# 연습문제  
# stock 테이블에서  종가(close)의  현재일과 하루전일의 증감률을 구해보세요. 
# 어제 - 오늘 / 어제  -> 증감률을 구해보세요.  
select ID,date,  close, LAG(Close, 1) over (partition by ID order by date) 어제값 ,
(close - LAG(Close, 1) over (partition by ID order by date)) /LAG(Close, 1) over (partition by ID order by date) 증감률 
from stock;

select ID,date,  close, LAG(Close, 1) over (partition by ID order by date) 어제값 ,
(close - LAG(Close, 1) over (partition by ID order by date)) /LAG(Close, 1) over (partition by ID order by date) 증감률 
from stock
order by 증감률 desc;

# FRAME 절
# ROWS(Frame절) AND (Frame절) 
# current row 현재로우,  n PRECEDING n번째 뒤의 로우,  n FOLLOWING n번째 앞의 로우 
# UNBOUNDING PRECEDING 가장 첫번째 로우,  UNBOUNDING FOLLOWING 가장 마지막 로우  
select ID, date, Close, AVG(CLOSE) over (order by date
										ROWS BETWEEN 4 PRECEDING AND CURRENT ROW)  이동평균5 from stock
order by ID, DATE;

select ID, date, Close, AVG(CLOSE) over (order by date
										ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)  이동평균20 from stock
order by ID, DATE;



# 위로밀기 아래로 밀기 
select date, Close, LAG(Close, 5) over (order by date)  from googl;
select ID, date, Close, LAG(Close, 5) over (partition by ID order by date)  from stock;
