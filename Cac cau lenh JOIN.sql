--Su dung INNER JOIN
--Tu bang Products va Categories, hay in ra cac thong tin sau day:
--Ma the loai
--Ten the loai
--Ma san pham
--Ten san pham
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;


--Su dung INNER JOIN
--Tu bang Products va Categories, hay dua ra cac thong tin sau day:
--Ma the loai
--Ten the loai
--So luong san pham
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

--Su dung INNER JOIN, hay in ra cac thong tin sau day:
--Ma don hang
--Ten cong ty khach hang
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

--Su dung INNER JOIN, LEFT JOIN
--Tu bang Products va Categories, hay dua ra cac thong tin sau day:
--Ma the loai
--Ten the loai
--Ten san pham
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;


--Su dung RIGHT JOIN, hay in ra cac thong tin sau day:
--Ma don hang
--Ten cong ty khach hang
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

--Su dung FULL OUTER JOIN
--Tu bang Products va Categories, hay in ra cac thong tin sau day:
--Ma the loai
--Ten the loai
--Ma san pham
--Ten san pham
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
FULL JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

