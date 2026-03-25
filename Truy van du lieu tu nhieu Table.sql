--Tu bang Products va Categories, hay in ra cac thong tin sau day:
--Ma the loai
--Ten the loai
--Ma san pham
--Ten san pham
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Products] AS p, [dbo].[Categories] AS c
WHERE c.CategoryID = p.CategoryID;


--Tu bang Employees va Orders, hay in ra cac thong tin sau day:
--Ma nhan vien
--Ten nhan vien
--So luong don hang ma nhan vien da ban duoc
SELECT o.[EmployeeID], e.LastName, e.FirstName, COUNT(o.[OrderID]) AS [TotalOrders]
FROM [dbo].[Orders] AS o, [dbo].[Employees] AS e
WHERE o.[EmployeeID] = e.EmployeeID
GROUP BY o.[EmployeeID], e.LastName, e.FirstName;

--Tu bang Customers va Orders, hay in ra cac thong tin sau day:
--Ma so khach hang
--Ten cong ty
--Ten lien he
--So luong don hang da mua
--Voi dieu kien: quoc gia cua khach hang la UK
SELECT c.CustomerID, c.CompanyName, c.ContactName, COUNT(o.[OrderID]) AS [TotalOrders]
FROM [dbo].[Customers] AS c, [dbo].[Orders] AS o
WHERE c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName;

--Tu bang Orders va Shippers, hay in ra cac thong tin sau day:
--Ma nha van chuyen
--Ten cong ty van chuyen
--Tong so tien duoc van chuyen (Sum Freight)
--Va in ra man hinh theo thu tu sap xep tong so tien van chuyen giam dan.
SELECT s.ShipperID, s.CompanyName, SUM(o.Freight) AS [TotalFreight]
FROM [dbo].[Shippers] AS s, [dbo].[Orders] AS o
WHERE s.ShipperID = o.ShipVia
GROUP BY  s.ShipperID, s.CompanyName
ORDER BY SUM(o.Freight) DESC;

--Tu bang Products va Suppliers, hay in ra cac thong tin sau day:
--Ma nha cung cap
--Ten cong ty
--Tong so cac san pham khac nhau da cung cap
--Va chi in ra man hinh duy nhat 1 nha cung cap co so luong san pham khac nhau nhieu nhat.
SELECT TOP 1 s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS [TotalProducts]  -- Ctrl + Space
FROM [dbo].[Suppliers] AS s, [dbo].[Products] AS p
WHERE s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName
ORDER BY COUNT(p.ProductID)  DESC;


--Tu bang Orders va Order Details, hay in ra cac thong tin sau day:
--Ma don hang
--Tong so tien san pham cua don hang do
SELECT o.[OrderID], o.CustomerID, SUM(od.UnitPrice*od.Quantity) AS [Total]
FROM [dbo].[Orders] AS o, [dbo].[Order Details] as od
WHERE o.OrderID = od.OrderID
GROUP BY  o.[OrderID], o.CustomerID;


--Tu 3 bang trong hinh hay in ra cac thong tin sau day:
--Ma don hang
--Ten nhan vien
--Tong so tien san pham cua don hang
SELECT o.OrderID, e.LastName, e.FirstName, SUM(od.UnitPrice*od.Quantity) AS [Total]
FROM [dbo].[Orders] AS o, [dbo].[Employees] AS e, [dbo].[Order Details] AS od
WHERE o.EmployeeID = e.EmployeeID AND o.OrderID=od.OrderID
GROUP BY o.OrderID, e.LastName, e.FirstName;


--T? b?ng Products và Categories, 
-- hãy tìm các s?n ph?m thu?c danh m?c ‘Seafood’ 
-- (?? h?i s?n) in ra các thông tin sau ?ây:
--Mã th? lo?i
--Tên th? lo?i
--Mã s?n ph?m
--Tên s?n ph?m
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c, [dbo].[Products] p
WHERE c.CategoryID = p.CategoryID 
	AND c.CategoryName = 'Seafood';


--T? b?ng Products và Suppliers, 
-- hãy tìm các s?n ph?m thu?c ???c cung c?p t? n??c ‘Germany’ (??c) :
--Mã nhà cung c?p
--Qu?c gia
--Mã s?n ph?m
--Tên s?n ph?m
SELECT s.SupplierID, s.Country, p.ProductID, p.ProductName
FROM [dbo].[Suppliers] s, [dbo].[Products] p
WHERE s.SupplierID = p.SupplierID
	AND s.Country = 'Germany';

--T? 3 b?ng trong hình hãy in ra các thông tin sau ?ây:
--Mã ??n hàng
--Tên khách hàng
--Tên công ty v?n chuy?n
--Và ch? in ra các ??n hàng c?a các khách hàng ??n t? thành ph? ‘London’
SELECT o.OrderID, c.ContactName, s.CompanyName 
FROM [dbo].[Orders] o, [dbo].[Customers] c, [dbo].[Shippers] s
WHERE o.CustomerID = c.CustomerID
	AND o.ShipVia = s.ShipperID
	AND c.City='London';


--Tu 3 bang trong hinh hay in ra cac thong tin sau day:
--Ma don hang
--Ten khach hang
--Ten cong ty van chuyen
--Ngay yeu cau chuyen hang
--Ngay giao hang
--Va chi in ra cac don hang bi giao muon hon quy dinh.
--RequiredDate < ShippedDate
SELECT o.OrderID, c.ContactName, s.CompanyName, o.RequiredDate, o.ShippedDate
FROM [dbo].[Orders] o, [dbo].[Customers] c, [dbo].[Shippers] s
WHERE o.CustomerID = c.CustomerID
	AND o.ShipVia = s.ShipperID
	AND o.RequiredDate < o.ShippedDate;