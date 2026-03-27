--Kiểm tra xem có giá trị nào bị trùng lặp không 
select timestamp, COUNT(*) as So_Lan_Xuat_Hien
from Rawdata
group by timestamp
having count(*) > 1;

--Lấy hết thông tin những dòng bị trùng ra
select * from Rawdata 
where timestamp IN (
    select timestamp 
    from Rawdata 
    group by timestamp 
    having count(*) > 1
)
order by timestamp;

-- Tạo Primarykey
alter table Rawdata
add ID int identity(1,1) primary key;

--Nhóm tuổi nào có điểm rủi ro cao nhất 
select [age_group],
       max([risk_score]) as maxriscore
from [dbo].[Rawdata]
group by [age_group] 
order by [age_group] desc;

--Top 3 khu vực có số lượng giao dịch
--bị đánh dấu là bất thường nhiều nhất
select top 3 [location_region],
            count(ID) as sogiaodichbatthuong
from [dbo].[Rawdata]
where [anomaly] in ('high_risk', 'moderate_risk', 'low_risk')
group by [location_region]
order by count(ID) desc;

--Danh sách các khu vực và tổng số tiền giao dịch
select [location_region],
       sum([amount]) as total
from [dbo].[Rawdata]
group by [location_region];

--Đếm mỗi loại mô hình mua hàng(purchase_pattern)
--có bao nhiêu giao dịch là rủi ro cao
   select [purchase_pattern],
          count(ID) as total
   from[dbo].[Rawdata]
   where [anomaly] = 'high_risk'
   group by [purchase_pattern];

--5 địa chỉ ví gửi có tổng số tiền giao dịch lớn nhất
select top 5 [sending_address],
       sum([amount]) as totalamount
from[dbo].[Rawdata]
group by [sending_address]
order by sum([amount]) desc;

--Danh sách tổng số tiền giao dịch của từng khu vực
--nhưng chỉ tính những giao dịch có số tiền lớn hơn 1000
select [location_region],
        sum([amount]) as totalamount
from[dbo].[Rawdata]
where [amount]>1000
group by [location_region];

--Các nhóm tuổi có số lượng giao dịch nhiều hơn 2000 dòng
select[age_group],
      count(ID) as sodong
from [dbo].[Rawdata]
group by [age_group]
having count(ID)>2000;

--Danh sách giao dịch( hiện ra tất cả cột) của những ví gửi
--có tổng số tiền giao dịch trung bình lớn hơn 
--mức trung bình của toàn bộ sàn Metaverse
--CTE
with vi_trungbinh as (
select [sending_address],
       avg([amount]) as avg_vi
from [dbo].[Rawdata]
group by [sending_address]
)
select *
from [dbo].[Rawdata]
where [sending_address] in (
     select [sending_address]
     from vi_trungbinh
     where avg_vi  > (select avg(amount)
                      from [dbo].[Rawdata])
);
--Subquery
select * 
from [dbo].[Rawdata]
where [sending_address] IN (
    select [sending_address]
    from [dbo].[Rawdata]
    group by [sending_address]
    having AVG([amount]) > (
        SELECT AVG([amount]) 
        FROM [dbo].[Rawdata]
    )
);

--Danh sách các giao dịch(ID, amount, location_region)
--có số tiền lớn hơn gấp đôi mức trung bình khu vực đó
select ID, amount, [location_region]
from [dbo].[Rawdata] as main
where amount > (
         select avg(amount)
         from [dbo].[Rawdata] as sub
         where sub.location_region=main.location_region
         );

--Những địa chỉ ví gửi(sending_address)
--có số tiền giao dịch lớn nhất của họ
--cao hơn mức chi tiêu trung bình của chính họ
--Subquery
select main.sending_address
from (
      select [sending_address],
             max([amount]) as  maxmoney,
             avg([amount]) as avgmoney
      from [dbo].[Rawdata]
      group by [sending_address]
) as main 
where main.maxmoney>main.avgmoney*5;

--CTE
with main as (
    select [sending_address],
           max([amount]) as maxmoney,
           avg([amount]) as avgmoney
    from [dbo].[Rawdata]
    group by [sending_address]
)
 select [sending_address]
 from main 
 where main.maxmoney>main.avgmoney*5;

--Các giao dịch có giá trị thấp nhất theo từng khu vực
with bangtam as (
    select [location_region],
           min([amount]) as minamount
    from [dbo].[Rawdata]
    group by [location_region]
)
select A.[ID], A.[location_region], A.amount
from [dbo].[Rawdata] as A
join bangtam as B 
    on A.location_region = B.location_region
    and A.amount = B.minamount; 

--Các cặp giao dịch nghi vấn có dấu hiệu vòng quay vốn(Wash trading)
select A.ID,  
       B.ID,  
       A.sending_address, 
       A.receiving_address, 
       A.amount
from [dbo].[Rawdata] as A
join [dbo].[Rawdata] as B 
   on  A.amount = B.amount               
   and A.sending_address = B.receiving_address         
    and A.receiving_address = B.sending_address           
where A.ID < B.ID;                         

--Các tài khoản có dấu hiệu xâm nhập hoặc dùng chung  
--dựa trên sự khác nhau về vị trí trong cùng một khoảng thời gian
select A.ID,
       B.ID,
       A.sending_address,
       B.sending_address,
       A.location_region,
       B.location_region,
       A.timestamp,
       B.timestamp
from [dbo].[Rawdata] as A
join [dbo].[Rawdata] as B
  on A.sending_address=B.sending_address
  and cast( A.timestamp as date)= cast(B.timestamp as date)
where A.[location_region]<>B.[location_region]
  and A.ID<> B.ID;
 
