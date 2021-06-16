CREATE DATABASE SportingShop
GO
USE SportingShop

CREATE TABLE [Type]
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL CHECK([Name] !=' '),

	CONSTRAINT UQ_Type_Name UNIQUE([Name])
)
  
CREATE TABLE Fabricator
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL CHECK([Name] !=' ') ,

	CONSTRAINT UQ_Fabricator_Name UNIQUE([Name])
)


CREATE TABLE Products
(
	Id INT PRIMARY KEY IDENTITY,
	PrimeCost MONEY NOT NULL ,
	[Name] NVARCHAR(50) NOT NULL ,
	TypeId INT NOT NULL,
	FabricatorId INT NOT NULL,
	[Cost] MONEY NOT NULL ,
	
	CONSTRAINT CK_Sales_Cost CHECK([Cost]>0),
	CONSTRAINT FK_Product_TypeId FOREIGN KEY (TypeId) REFERENCES [Type](Id),
	CONSTRAINT UQ_Product_Name UNIQUE([Name]),
	CONSTRAINT CK_Product_Name CHECK([Name] !=' '),
	CONSTRAINT CK_Product_PrimeCost CHECK(PrimeCost>0),
	CONSTRAINT FK_Product_FabricatorId FOREIGN KEY (FabricatorId) REFERENCES Fabricator(Id)
)
  

CREATE TABLE Storage
(
    Id INT PRIMARY KEY IDENTITY,
	ProductId INT NOT NULL,
	Quantity INT NOT NULL, 

	CONSTRAINT CK_Storage_Quantity  CHECK(Quantity >= 0),
	CONSTRAINT FK_Storage_ProductId FOREIGN KEY (ProductId) REFERENCES Products(Id) 
)


CREATE TABLE Positions
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL CHECK([Name] !=' ') ,

	CONSTRAINT UQ_Positions_Name UNIQUE([Name])
)


CREATE TABLE Employees
(
     Id INT PRIMARY KEY IDENTITY,
	 Gender NVARCHAR(5) NOT NULL ,
	 FullName NVARCHAR(50) NOT NULL ,
	 PositionId INT NOT NULL,
 	 EmploymentDate DATE NOT NULL ,
	 Salary MONEY NOT NULL ,

	 CONSTRAINT UQ_Employees_FullName UNIQUE(FullName),
	 CONSTRAINT CK_Employees_FullName CHECK(FullName!=' '),
	 CONSTRAINT CK_Employees_Gender CHECK(Gender IN('Man','Woman')),
	 CONSTRAINT CK_Employees_EmploymentDate CHECK(EmploymentDate <= GETDATE()),
	 CONSTRAINT FK_Employees_PositionId FOREIGN KEY (PositionId) REFERENCES Positions(Id),
)
  

CREATE TABLE Clients
(
		Id INT PRIMARY KEY IDENTITY,
		Gender NVARCHAR(10) NOT NULL ,
		FullName NVARCHAR(50) NOT NULL  ,
		Email NVARCHAR(50) NOT NULL ,
		Phone NVARCHAR(50) NOT NULL   ,
		Discount FLOAT NOT NULL,
		IsSubcribe BIT NOT NULL ,
		DateSubcribe DATE ,

		 CONSTRAINT UQ_Clients_FullName UNIQUE(FullName),
		 CONSTRAINT CK_Clients_FullName CHECK(FullName!=' '),
		 CONSTRAINT CK_Clients_Email CHECK(Email != ' '), 
		 CONSTRAINT CK_Clients_Phone CHECK(Phone != ' '),
		 CONSTRAINT CK_Clients_Discount CHECK(Discount BETWEEN 0 AND 90), -- vozmojnaya skidka 0-90% 
		 CONSTRAINT CK_Clients_Gender CHECK(Gender IN('Man','Woman'))
)

CREATE TABLE History
(
	Id INT PRIMARY KEY IDENTITY,
	ClientId INT NOT NULL, 
	ProductId INT NOT NULL,
	[Date] DATE NOT NULL,

	CONSTRAINT CK_History_Date CHECK([Date] <= GETDATE()),
	CONSTRAINT FK_History_ClientId FOREIGN KEY (ClientId) REFERENCES Clients(Id),
	CONSTRAINT FK_History_ProductId FOREIGN KEY (ProductId) REFERENCES Products(Id)
)

CREATE TABLE Sales
(
	Id INT PRIMARY KEY IDENTITY,  
	Quantity INT NOT NULL,
	EmployeeId INT NOT NULL, 
	[Date] DATE NOT NULL , 
	ClientId INT NOT NULL,  
	StorageId  INT NOT NULL,  
	
	CONSTRAINT CK_Sales_Date CHECK([Date] <= GETDATE()),
	CONSTRAINT CK_Sales_Quantity  CHECK(Quantity > 0), 
	CONSTRAINT FK_Sales_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employees(Id),
	CONSTRAINT FK_Sales_ClientId FOREIGN KEY (ClientId) REFERENCES Clients(Id),
	CONSTRAINT FK_Sales_StorageId FOREIGN KEY (StorageId) REFERENCES Storage(Id) 
)
 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
 
BULK INSERT Type
FROM 'C:\Task\Type.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)



BULK INSERT Fabricator
FROM 'C:\Task\Fabricator.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)  



BULK INSERT Positions
FROM 'C:\Task\Positions.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)



BULK INSERT Products
FROM 'C:\Task\Products.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)



BULK INSERT Employees
FROM 'C:\Task\Employees.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)


BULK INSERT Clients
FROM 'C:\Task\Clients.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
 

BULK INSERT History
FROM 'C:\Task\History.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)


BULK INSERT Sales
FROM 'C:\Task\Sales.csv'
WITH ( 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
) 


 --------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------
  

-- Задание 1. Для базы данных «Спортивный магазин» из практического задания модуля «Триггеры, хранимые процедуры и пользовательские функции» выполните набор действий: 
--1. Запретите пользователю с логином Марк получать информацию о продавцах 

 CREATE LOGIN Mark WITH PASSWORD = '11111111' 
 CREATE USER [User1] FOR LOGIN Mark
    
 GRANT SELECT TO [User1]
 DENY SELECT ON Employees TO [User1] 


--2. Разрешите пользователю с логином Дэвид получать информацию только о продавцах 

 CREATE LOGIN David WITH PASSWORD = '22222222'
 CREATE USER User2 FOR LOGIN David 
   
 GRANT SELECT ON Employees TO User2  

--3. Предоставьте полный доступ к базе данных пользователю с логином Ольга 

CREATE LOGIN Olga WITH PASSWORD = '33333333'
CREATE USER User3 FOR LOGIN Olga

--полный доступ (CRUD) 
GRANT SELECT TO User3 
GRANT INSERT  TO User3  
GRANT UPDATE TO User3 
GRANT DELETE TO User3
 
-- стандартной роли db_datareader
--ALTER ROLE db_datawriter ADD MEMBER User3
-- стандартной роли db_datawriter
--ALTER ROLE db_datareader ADD MEMBER User3


--4. Предоставьте доступ только на чтение таблиц с информацией о продавцах, товарах в наличии пользователю с логином Константин.
   
 CREATE LOGIN Konstantin WITH PASSWORD = '44444444'
 CREATE USER User4 FOR LOGIN Konstantin

 GRANT SELECT ON Employees TO User4
 GRANT SELECT ON Storage TO User4


