-- Su dung CTE de tinh tong doanh so ban hang cho tung san pham
-- tu hai bang Order Details va Products
with Productotals as (
select [ProductID], sum(od.unitprice*od.quantity) as totalprice
from  [dbo].[Order Details] as  od
group by [ProductID]
)
select  p.[ProductID],
        p.[ProductName],
        pd.totalprice
from [dbo].[Products] as p
join productotals pd on  p.[ProductID]=pd.productid;


 -- Su dung CTE de tinh toan tong doanh so ban hang 
-- theo tung khach hang 
-- va sap xep khach hang theo thu tu giam dan
 with CustomerSales as (
 select o.[CustomerID], Sum(od.[Quantity]*od.[UnitPrice]) as Totalprice
 from [dbo].[Orders] as o
 join [dbo].[Order Details] od on o.OrderID=od.OrderID
 group by customerid
 )
 select c.customerid,
         c.CompanyName,
        cs.totalprice
 from customers as c
 join CustomerSales as cs on cs.CustomerID=c.CustomerID
 order by
  cs.Totalprice DESC;

-- Tinh tong doanh so ban hang theo nam tu bang
-- Orders va Order Details
 with YearSales as(
 select od.OrderID, 
 sum(od.quantity*od.unitprice) as totalprice
 from [dbo].[Order Details] as od
 group by OrderID
 )
 select o.OrderID,
        year(o.orderdate) as year,
      y.totalprice
 from orders as o
 join YearSales as y on o.OrderID=y.OrderID
 