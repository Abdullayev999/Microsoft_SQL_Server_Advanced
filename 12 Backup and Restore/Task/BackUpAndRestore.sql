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
	[Name] NVARCHAR(50) NOT NULL ,
	PrimeCost MONEY NOT NULL ,
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
 



 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
insert into [Type] (Name) values ('Protection');
insert into Fabricator (Name) values ('Adidas');
insert into Products ( [Cost],[Name], PrimeCost, TypeId, FabricatorId) values (179,'Capo two side', 21, 1, 1);    
 --------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------
  

--«адание 1. ƒл€ базы данных Ђ—портивный магазинї выполните набор действий. 
--1. —оздайте полную (full backup) резервную копию.
BACKUP DATABASE SportingShop
TO DISK =  'C:\Task\SportingShop.bak'
WITH NAME = 'Full_BackUp'

--2. ¬ыполните операции по вставке, обновлению, удалению данных в разных таблицах базы данных.

insert into [Type] (Name) values ('Training apparatus'); 
insert into [Type] (Name) values ('Clothing');


insert into Fabricator (Name) values ('Puma');
insert into Fabricator (Name) values ('Nike');

insert into Products ( [Cost],[Name], PrimeCost, TypeId, FabricatorId) values (182,'MMA Glove', 45, 3, 3);
insert into Products ( [Cost],[Name], PrimeCost, TypeId, FabricatorId) values (170,'Capo', 36, 1, 2);


DELETE Products
WHERE Id = 1

UPDATE Fabricator
SET Name = 'Zara'
WHERE Name LIKE 'Nike'



--3. —оздайте разностную (differential backup) резервную копию.

BACKUP DATABASE SportingShop
TO DISK = 'C:\Task\SportingShop.bak'
WITH DIFFERENTIAL , NAME = 'DifferentialBackUp' 

--4. ¬ыполните операции по вставке, обновлению, удалению данных в разных таблицах базы данных. 
DELETE Products 
DELETE Fabricator
DELETE Type 

insert into Fabricator (Name) values ('Reebok'); 
insert into [Type] (Name) values ('Ball');   

insert into Products ( [Cost],[Name], PrimeCost, TypeId, FabricatorId) values (232,'Football', 89, 4, 4);
insert into Products ( [Cost],[Name], PrimeCost, TypeId, FabricatorId) values (182,'Tennis', 45, 4, 4); 
 

UPDATE Fabricator
SET Name = 'LW'
WHERE Name LIKE 'Reebok'


 
--5. ѕроведите восстановление из полной резервной копии.

--FOR CHECK
 select * from Products
 select * from Fabricator
 select * from Type

RESTORE DATABASE SportingShop
FROM DISK =  'C:\Task\SportingShop.bak'
 

--6. ѕроведите восстановление из разностной резервной копии.

RESTORE DATABASE SportingShop
FROM DISK =    'C:\Task\SportingShop.bak'
WITH File = 1, NORECOVERY

RESTORE DATABASE SportingShop
FROM DISK =   'C:\Task\SportingShop.bak'
WITH File = 2, RECOVERY
 
 --FOR CHECK
 select * from Products
 select * from Fabricator
 select * from Type