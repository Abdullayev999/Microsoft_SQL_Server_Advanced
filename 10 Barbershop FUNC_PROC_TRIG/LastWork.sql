CREATE DATABASE BarberShop

GO
USE BarberShop

CREATE TABLE Positions
(
    Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,

	CONSTRAINT CK_Positions_Name CHECK([Name] != ' '),
	CONSTRAINT UQ_Positions_Name UNIQUE([Name])
)
 

CREATE TABLE Barbers
(
	 Id INT PRIMARY KEY IDENTITY,
	 FullName NVARCHAR(30) NOT NULL,
	 Gender NVARCHAR(5) NOT NULL,
	 Email NVARCHAR(30) ,--почта может и не быть
	 Phone NVARCHAR(30) NOT NULL,
	 YearOfBirth DATE NOT NULL,
	 EmploymentDate DATE NOT NULL,
	 PositionId INT NOT NULL,

	 CONSTRAINT CK_Barbers_EmploymentDate CHECK(EmploymentDate <= GETDATE()),
	 CONSTRAINT CK_Barbers_Date CHECK(YEAR(YearOfBirth)>=18),
	 CONSTRAINT CK_Barbers_Phone CHECK(Phone != ' '),
	 CONSTRAINT CK_Barbers_Gender CHECK(Gender in('Man','Woman')),
	 CONSTRAINT CK_Barbers_FullName CHECK(FullName != ' '),
	 CONSTRAINT UQ_Barbers_FullName UNIQUE(FullName),
	 CONSTRAINT FK_Barbers_PositionId FOREIGN KEY (PositionId)  REFERENCES Positions(Id)
) 
 

CREATE TABLE [Types]
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	 
	CONSTRAINT CK_Types_Name CHECK([Name] != ' '),
	CONSTRAINT UQ_Types_Name UNIQUE([Name])
)




CREATE TABLE [Services]
(
    Id INT PRIMARY KEY IDENTITY,
	TypeId INT NOT NULL,
	Duration INT NOT NULL,
	Cost INT NOT NULL,

	CONSTRAINT FK_Services_TypeId FOREIGN KEY (TypeId)  REFERENCES Types(Id),
	CONSTRAINT CK_Services_Cost CHECK(Cost > 0)
)

 
CREATE TABLE Clients
(
	 Id INT PRIMARY KEY IDENTITY,
	 FullName NVARCHAR(30) NOT NULL, 
	 Email NVARCHAR(30) ,--почта может и не быть
	 Phone NVARCHAR(30) NOT NULL, 
	  
	 CONSTRAINT CK_Clients_Phone CHECK(Phone != ' '), 
	 CONSTRAINT CK_Clients_FullName CHECK(FullName != ' '),
	 CONSTRAINT UQ_Clients_FullName UNIQUE(FullName)
) 



CREATE TABLE FeedBacks
(
    Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT CK_FeedBacks_Name CHECK([Name] != ' '),
	CONSTRAINT UQ_FeedBacks_Name UNIQUE([Name])
)




CREATE TABLE Ratings
(
    Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,

	CONSTRAINT CK_Ratings_Name CHECK([Name] != ' '),
	CONSTRAINT UQ_Ratings_Name UNIQUE([Name])
)



CREATE TABLE Schedules
(
    Id INT PRIMARY KEY IDENTITY,
	ClientId INT NOT NULL,
	BarberId INT NOT NULL,
	[DateTime] DATETIME NOT NULL, 
	ServiceId  INT NOT NULL,

	CONSTRAINT FK_Schedules_ClientId FOREIGN KEY (ClientId) REFERENCES Clients(Id),
	CONSTRAINT FK_Schedules_BarberId FOREIGN KEY (BarberId) REFERENCES Barbers(Id),
	CONSTRAINT FK_Schedules_ServiceId FOREIGN KEY (ServiceId) REFERENCES Services(Id)
 )




CREATE TABLE ArchiveOfVisits
(
	Id INT PRIMARY KEY IDENTITY,
	ClientId INT NOT NULL,
	BarberId INT NOT NULL,
	ServiceId  INT NOT NULL,
	FeedBackId INT  DEFAULT(1),
	RatingId INT DEFAULT(1),
	[DateTime] DATETIME NOT NULL,  
	
	CONSTRAINT FK_ArchiveOfVisits_FeedBackId FOREIGN KEY (FeedBackId) REFERENCES FeedBacks(Id),  
	CONSTRAINT FK_ArchiveOfVisits_ClientId FOREIGN KEY (ClientId) REFERENCES Clients(Id),  
	CONSTRAINT FK_ArchiveOfVisits_RatingId FOREIGN KEY (RatingId) REFERENCES Ratings(Id),
	CONSTRAINT FK_ArchiveOfVisits_BarberId FOREIGN KEY (BarberId) REFERENCES Barbers(Id),
	CONSTRAINT FK_ArchiveOfVisits_ServiceId FOREIGN KEY (ServiceId) REFERENCES Services(Id)

) 
 
insert into Positions ([Name]) values ('Chief');
insert into Positions ([Name]) values ('Signor');
insert into Positions ([Name]) values ('Junior');
insert into Positions ([Name]) values ('Trainee');


insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Wheeler McMyler', 'Man', 'wmcmyler0@weebly.com', '489-833-3094', '1998-03-08', '2011-03-30', 1);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Samantha Hellwich', 'Woman', 'shellwich1@microsoft.com', '287-611-3092', '1990-11-16', '2013-09-05', 3);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Der Kobisch', 'Man', 'dkobisch2@themeforest.net', '309-495-9181', '1992-12-30', '2014-12-28', 2);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Melisent Fransinelli', 'Woman', 'mfransinelli3@yellowbook.com', '873-638-6171', '1994-04-15', '2013-10-11', 3);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Randie Hedney', 'Man', 'rhedney4@smh.com.au', '747-452-8381', '1991-08-15', '2016-12-14', 2);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Cobb Bootman', 'Woman', 'cbootman5@cyberchimps.com', '804-161-2513', '1999-01-22', '2020-05-18', 4);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Birdie Skirven', 'Woman', 'bskirven6@time.com', '505-193-8801', '1992-10-11', '2018-01-18', 2);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Enrico Blinckhorne', 'Man', 'eblinckhorne7@netvibes.com', '320-871-7388', '1992-01-27', '2015-06-18', 3);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Red Jeremiah', 'Man', 'rjeremiah8@zdnet.com', '890-904-4370', '1992-10-19', '2019-02-09', 4);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Papagena Messenger', 'Man', 'pmessenger9@samsung.com', '274-676-0709', '1990-05-01', '2018-12-14', 2);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Oleq Qazmanov', 'Man', 'wmcmyler0@weebly.com', '489-833-3094', '1992-03-18', '2014-03-30', 3);
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Sawka Ivanov', 'Man', 'wmcmyler0@weebly.com', '489-833-3094', '1991-01-28', '2010-03-30', 3);


  -- все возможный пакет услуг 
  -- не разделил потомучту когда идем мы выбираем 1 а не по отдельности выбираем что делать
insert into [Types] ([Name]) values ('Hair');
insert into [Types] ([Name]) values ('Hair , Wash');
insert into [Types] ([Name]) values ('Hair , Beard');
insert into [Types] ([Name]) values ('Hair , Beard , Wash');
insert into [Types] ([Name]) values ('Beard');  

insert into [Services] (TypeId, Duration, Cost) values (1, 30, 29);
insert into [Services] (TypeId, Duration, Cost) values (2, 35, 38);
insert into [Services] (TypeId, Duration, Cost) values (3, 37, 41);
insert into [Services] (TypeId, Duration, Cost) values (4, 50, 47);
insert into [Services] (TypeId, Duration, Cost) values (5, 10, 15);


insert into Clients (FullName, Email, Phone) values ('Kala Muddicliffe', 'kmuddicliffe0@t.co', '445-850-0668');
insert into Clients (FullName, Email, Phone) values ('Vivianna Seignior', 'vseignior1@ow.ly', '649-904-4419');
insert into Clients (FullName, Email, Phone) values ('Ansley Filochov', 'afilochov2@unicef.org', '799-757-6955');
insert into Clients (FullName, Email, Phone) values ('Nikolaus Boc', 'nboc3@odnoklassniki.ru', '178-996-0969');
insert into Clients (FullName, Email, Phone) values ('Ilene Presslie', 'ipresslie4@soup.io', '141-304-8350');
insert into Clients (FullName, Email, Phone) values ('Rex Witherop', 'rwitherop5@youtu.be', '598-111-5262');
insert into Clients (FullName, Email, Phone) values ('Tina Haversum', 'thaversum6@scribd.com', '207-898-7786');
insert into Clients (FullName, Email, Phone) values ('Hedwiga Noquet', 'hnoquet7@omniture.com', '830-345-9277');
insert into Clients (FullName, Email, Phone) values ('Trumann Meadowcroft', 'tmeadowcroft8@yellowpages.com', '524-256-6758');
insert into Clients (FullName, Email, Phone) values ('Fredrika Alchin', 'falchin9@bbc.co.uk', '702-472-3923');
insert into Clients (FullName, Email, Phone) values ('Stefano Bransgrove', 'sbransgrovea@gravatar.com', '121-193-6105');
insert into Clients (FullName, Email, Phone) values ('Randy Fishburn', 'rfishburnb@naver.com', '501-748-9517');
insert into Clients (FullName, Email, Phone) values ('Angele Siward', 'asiwardc@weibo.com', '165-766-8760');
insert into Clients (FullName, Email, Phone) values ('Cassaundra Jeff', 'cjeffd@unicef.org', '277-450-2270');
insert into Clients (FullName, Email, Phone) values ('Fredelia Malpas', 'fmalpase@eventbrite.com', '831-887-0340');
insert into Clients (FullName, Email, Phone) values ('Iormina Engledow', 'iengledowf@uol.com.br', '501-461-9382');
insert into Clients (FullName, Email, Phone) values ('Bryn Kinze', 'bkinzeg@live.com', '207-248-2561');
insert into Clients (FullName, Email, Phone) values ('Elisabetta Matula', 'ematulah@live.com', '190-931-4444');
insert into Clients (FullName, Email, Phone) values ('Drusie Curro', 'dcurroi@paginegialle.it', '373-243-4040');
insert into Clients (FullName, Email, Phone) values ('Lorine Dennant', 'ldennantj@alibaba.com', '503-668-7636');
insert into Clients (FullName, Email, Phone) values ('Cleo Morden', 'cmordenk@bloglovin.com', '483-619-9674');
insert into Clients (FullName, Email, Phone) values ('Jill Carayol', 'jcarayoll@china.com.cn', '332-414-8943');
insert into Clients (FullName, Email, Phone) values ('Kippie Pigne', 'kpignem@diigo.com', '647-762-3780');
insert into Clients (FullName, Email, Phone) values ('Karee Vlasov', 'kvlasovn@phoca.cz', '201-591-0596');
insert into Clients (FullName, Email, Phone) values ('Kathleen O''Hengerty', 'kohengertyo@indiegogo.com', '624-732-1630');
insert into Clients (FullName, Email, Phone) values ('Philippe Kernes', 'pkernesp@adobe.com', '729-640-4650');
insert into Clients (FullName, Email, Phone) values ('Gennie Bernhardi', 'gbernhardiq@hp.com', '614-307-8364');
insert into Clients (FullName, Email, Phone) values ('Jess Ancketill', 'jancketillr@php.net', '197-674-8624');
insert into Clients (FullName, Email, Phone) values ('Keene Magnus', 'kmagnuss@bbb.org', '732-162-3657');
insert into Clients (FullName, Email, Phone) values ('Selby Applegarth', 'sapplegartht@hubpages.com', '210-508-9699');
insert into Clients (FullName, Email, Phone) values ('Maureene Langelaan', 'mlangelaanu@hibu.com', '591-572-5471');
insert into Clients (FullName, Email, Phone) values ('Victor Ripon', 'vriponv@ask.com', '304-308-8310');
insert into Clients (FullName, Email, Phone) values ('Niall Beckwith', 'nbeckwithw@weibo.com', '110-722-7846');
insert into Clients (FullName, Email, Phone) values ('Giacopo Coalburn', 'gcoalburnx@constantcontact.com', '751-354-1019');
insert into Clients (FullName, Email, Phone) values ('Rebekkah Jennens', 'rjennensy@meetup.com', '174-138-9266');
insert into Clients (FullName, Email, Phone) values ('Cyndia Sellick', 'csellickz@opensource.org', '661-736-3204');
insert into Clients (FullName, Email, Phone) values ('Barris Mussotti', 'bmussotti10@jugem.jp', '633-398-6939');
insert into Clients (FullName, Email, Phone) values ('Harli Finlayson', 'hfinlayson11@foxnews.com', '719-233-6514');
insert into Clients (FullName, Email, Phone) values ('Geoff Queree', 'gqueree12@deviantart.com', '425-135-7256');
insert into Clients (FullName, Email, Phone) values ('Hardy Smardon', 'hsmardon13@wired.com', '747-113-1238');
insert into Clients (FullName, Email, Phone) values ('Che Hazeman', 'chazeman14@delicious.com', '908-326-5086');
insert into Clients (FullName, Email, Phone) values ('Gratia Shewery', 'gshewery15@wiley.com', '235-319-2855');
insert into Clients (FullName, Email, Phone) values ('Christye Trim', 'ctrim16@mlb.com', '111-375-0201');
insert into Clients (FullName, Email, Phone) values ('Corbett Chisolm', 'cchisolm17@prnewswire.com', '778-336-1759');
insert into Clients (FullName, Email, Phone) values ('Troy Halworth', 'thalworth18@phoca.cz', '802-477-3826');
insert into Clients (FullName, Email, Phone) values ('Esmaria Ledson', 'eledson19@amazon.de', '363-533-8838');
insert into Clients (FullName, Email, Phone) values ('April Purchall', 'apurchall1a@4shared.com', '459-248-6314');
insert into Clients (FullName, Email, Phone) values ('Joelle Lawrie', 'jlawrie1b@ycombinator.com', '958-696-0967');
insert into Clients (FullName, Email, Phone) values ('Emmalee Creigan', 'ecreigan1c@creativecommons.org', '740-636-6852');
insert into Clients (FullName, Email, Phone) values ('Cyb Mc Corley', 'cmc1d@biblegateway.com', '504-417-2293');
insert into Clients (FullName, Email, Phone) values ('Ivan Ivanov', 'ivanovka@mail.com', '504-417-2293');



insert into Ratings ([Name]) values ('Without Rating');
insert into Ratings ([Name]) values ('Very Bad');
insert into Ratings ([Name]) values ('Bad');
insert into Ratings ([Name]) values ('Normal');
insert into Ratings ([Name]) values ('Good');
insert into Ratings ([Name]) values ('Great');


insert into FeedBacks ([Name]) values ('Without FeedBack');
insert into FeedBacks ([Name]) values ('Super very fast and beautiful');
insert into FeedBacks ([Name]) values ('Fast and accurate');
insert into FeedBacks ([Name]) values ('Very sociable that time flew by');
insert into FeedBacks ([Name]) values ('Didnt like it very much');
insert into FeedBacks ([Name]) values ('Super but it was slow');



-- то что было с помощью тригера помещу в архив   TRİGGER -> InsertSessionsEndedToArchive
 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (42, 10, '2022-10-21 17:07:06', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (24, 9, '2020-02-19 13:44:31', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (23, 4, '2020-08-08 12:28:15', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 10, '2020-05-31 14:51:33', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (21, 8, '2021-05-13 12:49:21', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (38, 2, '2021-01-31 15:33:50', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (49, 5, '2021-02-22 09:14:02', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (5, 9, '2020-05-23 10:55:19', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (10, 9, '2020-07-18 17:06:03', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 9, '2021-01-24 12:10:39', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (14, 7, '2019-08-09 01:20:37', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (40, 8, '2019-09-11 17:45:26', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (17, 3, '2020-07-18 15:22:02', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (25, 5, '2020-10-08 13:59:08', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 4, '2020-02-09 16:25:11', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (3, 10, '2020-08-30 09:06:09', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (37, 6, '2020-10-12 09:26:29', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (43, 1, '2019-12-15 10:51:30', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (11, 3, '2019-06-16 13:28:35', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 8, '2020-02-26 10:46:11', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 3, '2019-09-13 11:11:38', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (17, 2, '2020-02-05 11:15:25', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (44, 3, '2019-07-31 12:25:33', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (3, 1, '2020-04-07 13:04:56', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 9, '2020-05-20 14:18:05', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (42, 3, '2020-04-14 15:40:40', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (10, 10, '2020-06-22 16:43:22', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (38, 10, '2020-07-17 09:04:01', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 6, '2021-01-24 17:11:50', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (10, 6, '2019-11-17 15:09:02', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (26, 6, '2021-01-06 16:56:46', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-03-26 03:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (19, 9, '2021-04-19 16:36:54', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (46, 8, '2020-11-24 17:07:32', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (34, 8, '2020-06-02 17:14:25', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (1, 5, '2020-06-12 17:41:27', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (48, 1, '2020-07-03 09:16:51', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (33, 3, '2020-09-13 11:29:34', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (27, 5, '2020-08-07 09:44:14', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (40, 9, '2020-12-07 03:51:54', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (27, 3, '2020-05-08 17:08:38', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (5, 8, '2020-10-12 09:22:57', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (12, 8, '2020-03-21 10:25:21', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (37, 7, '2020-02-17 08:54:49', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (30, 2, '2019-10-11 12:03:54', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (22, 10, '2020-12-02 09:38:52', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 8, '2021-04-26 17:01:20', 5);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (12, 6, '2020-04-13 16:54:31', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (9, 3, '2019-10-26 15:44:29', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (17, 6, '2020-09-03 14:28:50', 3); 
 
 --Расписание  На будущее
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (21, 8, '2021-07-11 12:49:21', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (38, 2, '2021-07-12 16:33:50', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (49, 5, '2021-07-13 09:14:02', 2); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 9, '2021-07-14 12:10:39', 4); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 6, '2021-07-15 17:11:50', 3); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (26, 6, '2021-07-16 11:56:46', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 13:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 15:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 09:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 03:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 14:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 10, '2021-07-17 18:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (19, 9, '2021-07-18 15:36:54', 4);  
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 8, '2021-07-19 10:01:20', 5);  
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (21, 2, '2021-07-11 14:49:21', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (38, 3, '2021-07-12 17:33:50', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (49, 2, '2021-07-13 09:14:02', 3); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (35, 5, '2021-07-14 12:10:39', 1); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 6, '2021-07-15 17:11:50', 2); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (26, 7, '2021-07-16 10:56:46', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 8, '2021-07-17 10:24:42', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (19, 9, '2021-07-18 11:36:54', 4);  
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 4, '2021-07-19 10:01:20', 2);  
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (11, 8, '2021-08-11 12:49:21', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 2, '2021-08-12 16:33:50', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (19, 5, '2021-08-13 09:14:02', 3); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (15, 9, '2021-08-14 12:10:39', 4); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (18, 6, '2021-08-15 17:11:50', 4); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (6, 6, '2021-08-16 11:56:46', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 1, '2021-08-17 03:24:42', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (9, 9, '2021-08-18 15:36:54', 1);   
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (21, 2, '2021-08-11 14:49:21', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (22, 3, '2021-08-12 17:33:50', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (23, 2, '2021-08-13 09:14:02', 4); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (24, 5, '2021-08-14 12:10:39', 4); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (5, 6, '2021-08-15 17:11:50', 3); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (4, 7, '2021-08-16 10:56:46', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (1, 8, '2021-08-17 10:24:42', 2);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (2, 9, '2021-08-18 11:36:54', 1);  
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (3, 4, '2021-08-19 10:01:20', 2); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (1, 4, '2021-08-19 09:51:20', 1); 
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (4, 4, '2021-08-19 12:11:20', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (5, 4, '2021-08-19 14:21:20', 1);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (6, 4, '2021-08-19 15:45:20', 4);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (7, 4, '2021-08-19 17:05:20', 3);
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 4, '2021-08-19 11:01:20', 2);
 

 --для 14ого задание тригеры 
insert into ArchiveOfVisits (ClientId, BarberId, [DateTime], ServiceId) values (50, 4, '2020-11-21 17:07:06', 2); 
insert into ArchiveOfVisits (ClientId, BarberId, [DateTime], ServiceId) values (51, 3, '2020-10-21 18:25:06', 2); 
insert into ArchiveOfVisits (ClientId, BarberId, [DateTime], ServiceId) values (50, 2, '2020-11-21 12:10:06', 1); 
insert into ArchiveOfVisits (ClientId, BarberId, [DateTime], ServiceId) values (33, 1, '2020-10-21 13:07:06', 3); 



--Задание 2. Используя триггеры, пользовательские функции, хранимые процедуры реализуйте следующую функциональность: 
--1. Вернуть информацию о барбере, который работает в барбершопе дольше всех 
 
--FUNCTION
CREATE FUNCTION OldEmployee()
RETURNS TABLE
AS
        RETURN (SELECT TOP 1 FullName,Gender,Email,Phone,YearOfBirth,EmploymentDate,[Name] 
                FROM Barbers
				JOIN Positions ON Barbers.PositionId = Positions.Id
                ORDER BY EmploymentDate)

SELECT * FROM dbo.OldEmployee()

--PROCEDURE
CREATE PROC OldEmployee2
AS
BEGIN 
SELECT TOP 1 FullName,Gender,Email,Phone,YearOfBirth,EmploymentDate,[Name] 
                FROM Barbers
				JOIN Positions ON Barbers.PositionId = Positions.Id
                ORDER BY EmploymentDate
END


EXEC OldEmployee2



--2. Вернуть информацию о барбере, который обслужил максимальное количество клиентов в указанном диапазоне дат. Даты передаются в качестве параметра 

--FUNCTION
ALTER FUNCTION BarberMaxWorkByDate(@startDate DATE,@endDate DATE)
RETURNS TABLE 
AS 
	 RETURN(SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Count Client],Positions.[Name]
			FROM Barbers , (SELECT TOP 1  Barbers.Id , COUNT(*) as 'Count Client'
	                        FROM Barbers
			                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId 
			                WHERE  ArchiveOfVisits.[DateTime] BETWEEN @startDate AND @endDate
			                GROUP BY Barbers.Id
			                ORDER BY  COUNT(*) DESC )AS SubQuery , Positions  
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id)
			
 
SELECT * FROM dbo.BarberMaxWorkByDate('2018' , '2021')
 
  
--PROCEDURE
CREATE PROC BarberMaxWorkByDate2
@startDate DATE,
@endDate DATE
AS 
BEGIN
            SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Count Client],Positions.[Name]
			FROM Barbers , (SELECT TOP 1  Barbers.Id , COUNT(*) as 'Count Client'
	                        FROM Barbers
			                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId 
			                WHERE  ArchiveOfVisits.[DateTime] BETWEEN @startDate AND @endDate
			                GROUP BY Barbers.Id
			                ORDER BY  COUNT(*) DESC )AS SubQuery , Positions  
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id
END

EXEC BarberMaxWorkByDate2 '2018' , '2021'



--3. Вернуть информацию о клиенте, который посетил барбершоп максимальное количество раз 

--FUNCTION
CREATE FUNCTION MaxVisitorClient()
RETURNS TABLE
AS 
       RETURN(SELECT Clients.FullName,Clients.Email,Clients.Phone,SubQuery.[Times visit]
	   FROM Clients , (SELECT TOP 1 Clients.Id,COUNT(*) AS 'Times visit'
	                   FROM ArchiveOfVisits
	                   JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
			           GROUP BY Clients.Id
			           ORDER BY COUNT(*) DESC) AS SubQuery
	   WHERE Clients.Id = SubQuery.Id) 

SELECT * FROM dbo.MaxVisitorClient()


--PROCEDURE 
CREATE PROC MaxVisitorClient2
AS
BEGIN
   SELECT Clients.FullName,Clients.Email,Clients.Phone,SubQuery.[Times visit]
   FROM Clients , (SELECT TOP 1 Clients.Id,COUNT(*) AS 'Times visit'
	               FROM ArchiveOfVisits
	               JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
			       GROUP BY Clients.Id
			       ORDER BY COUNT(*) DESC) AS SubQuery
   WHERE Clients.Id = SubQuery.Id
END 

EXEC MaxVisitorClient2


--4. Вернуть информацию о клиенте, который потратил в барбершопе максимальное количество денег 

--FUNCTION
CREATE FUNCTION MaxCashClient()
RETURNS TABLE
AS 
       RETURN(SELECT Clients.FullName,Clients.Email,Clients.Phone,SubQuery.[Sum Сash]
	   FROM Clients , (SELECT TOP 1 Clients.Id,SUM(Services.Cost) AS 'Sum Сash'
	                   FROM ArchiveOfVisits
	                   JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
					   JOIN Services ON ArchiveOfVisits.ServiceId = Services.Id
			           GROUP BY Clients.Id
			           ORDER BY SUM(Services.Cost) DESC) AS SubQuery
	   WHERE Clients.Id = SubQuery.Id) 

SELECT * FROM dbo.MaxCashClient()

--PROCEDURE
CREATE PROC MaxCashClient2
AS
BEGIN
   SELECT Clients.FullName,Clients.Email,Clients.Phone,SubQuery.[Sum Сash]
	   FROM Clients , (SELECT TOP 1 Clients.Id,SUM(Services.Cost) AS 'Sum Сash'
	                   FROM ArchiveOfVisits
	                   JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
					   JOIN Services ON ArchiveOfVisits.ServiceId = Services.Id
			           GROUP BY Clients.Id
			           ORDER BY SUM(Services.Cost) DESC) AS SubQuery
	   WHERE Clients.Id = SubQuery.Id
END

EXEC MaxCashClient2


--5. Вернуть информацию о самой длинной по времени услуге в барбершопе

--FUNCTION
CREATE FUNCTION LongService()
RETURNS TABLE
AS
RETURN SELECT TOP 1  Types.[Name], Services.Duration , Services.Cost
       FROM Services
       JOIN [Types] ON Services.TypeId = Types.Id
	   ORDER BY Duration DESC

SELECT * FROM dbo.LongService()


--Procedure
ALTER PROC LongService2
AS
BEGIN 
       SELECT TOP 1  Types.[Name], Services.Duration , Services.Cost
       FROM Services
       JOIN [Types] ON Services.TypeId = Types.Id
       ORDER BY Duration DESC
END

EXEC LongService2



--6. Вернуть информацию о самом популярном барбере (по количеству клиентов) 

--FUNCTION
CREATE FUNCTION PopularBarber()
RETURNS TABLE 
AS 
	 RETURN(SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Count Client],Positions.[Name]
			FROM Barbers , (SELECT TOP 1  Barbers.Id , COUNT(*) as 'Count Client'
	                        FROM Barbers
			                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId  
			                GROUP BY Barbers.Id
			                ORDER BY  COUNT(*) DESC )AS SubQuery , Positions  
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id)
			
 
SELECT * FROM dbo.PopularBarber()
 
  
--PROCEDURE
CREATE PROC PopularBarber2 
AS 
BEGIN
        SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
		       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Count Client],Positions.[Name]
		FROM Barbers , (SELECT TOP 1  Barbers.Id , COUNT(*) as 'Count Client'
		                FROM Barbers
		                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId  
		                GROUP BY Barbers.Id
		                ORDER BY  COUNT(*) DESC )AS SubQuery , Positions  
		WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id  
END

EXEC PopularBarber2 



--7. Вернуть топ-3 барберов за месяц (по сумме денег, потраченной клиентами) 
 
--FUNCTION
CREATE FUNCTION PopularBarberTopByMonth(@Month INT)
RETURNS TABLE 
AS 
	 RETURN(SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Sum Money],Positions.[Name] 
			FROM Barbers , (SELECT TOP 3  Barbers.Id , SUM(Services.Cost) as 'Sum Money'
	                        FROM Barbers
			                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId  
							JOIN Services ON ArchiveOfVisits.ServiceId = Services.Id
							WHERE MONTH(ArchiveOfVisits.[DateTime]) = @Month
			                GROUP BY Barbers.Id 
			                ORDER BY SUM(Services.Cost) DESC )AS SubQuery , Positions 
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id )
			
 
SELECT * FROM dbo.PopularBarberTopByMonth(6) --по месяцам возращает топ 3



--PROC
CREATE PROC PopularBarberByTopAndMonth
@Month INT,@top INT
AS 
BEGIN
	 IF	(@Month BETWEEN 1 AND 12) AND (@top>0)
	   BEGIN
	 SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Sum Money],Positions.[Name] 
			FROM Barbers , (SELECT TOP (@top)  Barbers.Id , SUM(Services.Cost) as 'Sum Money'
	                        FROM Barbers
			                JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId  
							JOIN Services ON ArchiveOfVisits.ServiceId = Services.Id
							WHERE MONTH(ArchiveOfVisits.[DateTime]) = @Month
			                GROUP BY Barbers.Id 
			                ORDER BY SUM(Services.Cost) DESC )AS SubQuery , Positions 
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id 
	   END
	ELSE 
		PRINT 'Incorrect data'
 END
			
 
EXEC PopularBarberByTopandMonth 2 ,  3 -- возращает по месяцам и количество топ  



--8. Вернуть топ-3 барберов за всё время (по средней оценке). Количество посещений клиентов не меньше 30 

--FUNC
CREATE FUNCTION BarberByRating()
RETURNS TABLE 
AS 
	 RETURN(SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Avg Rating],Positions.[Name] 
			FROM Barbers , (SELECT TOP 3 Barbers.Id , AVG(Ratings.Id) AS 'Avg Rating'
                            FROM Barbers
                            JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId
		                    JOIN Ratings ON ArchiveOfVisits.RatingId = Ratings.Id
		                    GROUP BY Barbers.Id 
					        ORDER BY AVG(Ratings.Id) DESC)AS SubQuery , Positions 
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id )


SELECT * FROM dbo.BarberByRating()
	 

--PROC
CREATE PROC BarberByRatingWithTop
@Top INT
AS
BEGIN
	  SELECT Barbers.FullName,Barbers.Gender,Barbers.Email,Barbers.Phone,
			       Barbers.YearOfBirth,Barbers.EmploymentDate ,SubQuery.[Avg Rating],Positions.[Name] 
			FROM Barbers , (SELECT TOP (@Top) Barbers.Id , AVG(Ratings.Id) AS 'Avg Rating'
                            FROM Barbers
                            JOIN ArchiveOfVisits ON Barbers.Id = ArchiveOfVisits.BarberId
		                    JOIN Ratings ON ArchiveOfVisits.RatingId = Ratings.Id
		                    GROUP BY Barbers.Id 
					        ORDER BY AVG(Ratings.Id) DESC)AS SubQuery , Positions 
		    WHERE SubQuery.Id = Barbers.Id AND Barbers.PositionId = Positions.Id  
END

EXEC BarberByRatingWithTop 2


--9. Показать расписание на день конкретного барбера. Информация о барбере и дне передаётся в качестве параметра  
CREATE FUNCTION SchedulesBarber(@FullName NVARCHAR(30),@Date DATE )
RETURNS TABLE
AS
	RETURN(SELECT Clients.FullName, Types.[Name],   CONVERT(VARCHAR(5), Schedules.DateTime, 108) + 
    (CASE WHEN DATEPART(HOUR, Schedules.DateTime) > 12 THEN 'PM'
        ELSE 'AM'
    END) 'AM or PM (h-m)'
	       FROM Schedules
	       JOIN Barbers ON Schedules.BarberId = Barbers.Id
		   JOIN Clients ON Schedules.ClientId = Clients.Id
		   JOIN Services ON Schedules.ServiceId = Services.Id
		   JOIN Types ON Services.TypeId = Types.Id
		   WHERE Barbers.FullName LIKE @FullName AND DAY(Schedules.[DateTime]) = DAY(@Date) AND MONTH(Schedules.[DateTime]) = MONTH(@Date) )
	 
SELECT * FROM dbo.SchedulesBarber('Melisent Fransinelli','2021-08-19' ) -- Расписание клиентов и форма услуги



--PROC
CREATE PROC AllSchedulesBarber
@FullName NVARCHAR(30) 
AS
BEGIN
	 SELECT Clients.FullName, Types.[Name], Schedules.DateTime 
	       FROM Schedules
	       JOIN Barbers ON Schedules.BarberId = Barbers.Id
		   JOIN Clients ON Schedules.ClientId = Clients.Id
		   JOIN Services ON Schedules.ServiceId = Services.Id
		   JOIN Types ON Services.TypeId = Types.Id
		   WHERE Barbers.FullName LIKE @FullName  
END
	 
EXEC AllSchedulesBarber 'Cobb Bootman' -- Расписание клиентов за весь период
 

--10. Показать свободные временные слоты на неделю конкретного барбера. Информация о барбере и дне передаётся в качестве параметра 

--PROC
CREATE PROC  SchedulesBarberEmptyTime
@FullName NVARCHAR(30),
@Date DATE
AS
BEGIN   
           SELECT 
		   CASE
		       WHEN DATEPART(HOUR,Schedules.DateTime ) != 9  
			   AND DATEPART(HOUR,Schedules.DateTime ) != 10 
			   AND DATEPART(HOUR,Schedules.DateTime ) != 11 
			   AND DATEPART(HOUR,Schedules.DateTime ) != 12  
			   AND DATEPART(HOUR,Schedules.DateTime ) != 14 
			   AND DATEPART(HOUR,Schedules.DateTime ) != 15 
			   AND DATEPART(HOUR,Schedules.DateTime ) != 16 
			   AND DATEPART(HOUR,Schedules.DateTime ) != 17 THEN CONCAT( DATEPART(HOUR,Schedules.DateTime ) ,':00') 
			   ELSE 'BEASY'
		   END 
	       FROM Schedules
	       JOIN Barbers ON Schedules.BarberId = Barbers.Id 
		    WHERE Barbers.FullName LIKE 'Papagena Messenger' AND DATEPART(DAY,Schedules.DateTime) LIKE DATEPART(DAY,@Date)
			     AND DATEPART(MONTH,Schedules.DateTime) LIKE DATEPART(MONTH,@Date)
		   ORDER BY Schedules.DateTime  
END 

EXEC SchedulesBarberEmptyTime 'Melisent Fransinelli' ,'2019-07-17'


--11. Перенести в архив информацию о всех уже завершенных услугах (это те услуги, которые произошли в прошлом)  
--12. Запретить записывать клиента к барберу на уже занятое время и дату 
-- здесь оба тригеры на одну таблицу и INSTEAD OF INSERT  поэтому я объеденил их в 1 тригер и решил 2 задачи одновременно

CREATE TRIGGER InsertSessionsEndedToArchive ON Schedules
INSTEAD OF INSERT
AS
BEGIN  
        DECLARE @Time DATETIME;
		DECLARE @ClietnId INT;
		DECLARE @BarberId INT;
		DECLARE @ServiceId INT;

		(SELECT @Time=inserted.[DateTime],@ClietnId = inserted.ClientId,
		       @BarberId = inserted.BarberId , @ServiceId = inserted.ServiceId FROM inserted)
			
		DECLARE @IsBeasyTime DATETIME;
		SELECT @IsBeasyTime = Schedules.[DateTime] FROM Schedules WHERE Schedules.[DateTime] LIKE @Time
		
		IF	@IsBeasyTime IS NULL -- проверка на свободность графика
		BEGIN
		     IF @Time <= GETDATE()
		         BEGIN  --Значит сеасн либо завершон либо в процессе и следует переместить в архив 
			 
		      	   --Рандомны отзывы и оценки клиентов
			        DECLARE @RatingId INT = CAST(RAND()*(7-1)+1 AS INT);
			        DECLARE @FeedBackId INT = CAST(RAND()*(7-1)+1 AS INT);
				   
			        insert into ArchiveOfVisits(ClientId, BarberId, ServiceId,[DateTime],FeedBackId,RatingId) 
			        values (@ClietnId,@BarberId ,@ServiceId ,@Time ,@FeedBackId ,@RatingId);
		         END
		     ELSE
		         BEGIN
		              insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) 
		         	values (@ClietnId, @BarberId, @Time, @ServiceId);
		         END 
		END
		ELSE
		PRINT 'This date barber beasy' 
END
  
  --FOR CHECK
insert into Schedules (ClientId, BarberId, [DateTime], ServiceId) values (8, 4, '2021-08-19 11:01:20', 2);


--13. Запретить добавление нового джуниор-барбера, если в салоне уже работают 5 джуниор-барберов  

CREATE TRIGGER AddBarberJunior ON Barbers
INSTEAD OF INSERT
AS
BEGIN
         DECLARE @Position NVARCHAR(30);
		 DECLARE @CountJunior INT;
		 DECLARE @FullName NVARCHAR(30);
		 DECLARE @Gender NVARCHAR(10);
		 DECLARE @Email NVARCHAR(30);
		 DECLARE @Phone NVARCHAR(30);
		 DECLARE @YearOfBirth DATE;
		 DECLARE @EmploymentDate DATETIME; 
		 DECLARE @PositionId INT;

		 SELECT @CountJunior = COUNT(*)
		 from Barbers
		 JOIN Positions ON Barbers.PositionId = Positions.Id
		 WHERE Positions.Name LIKE 'Junior'
		  

		 SELECT @Position=Positions.Name ,@FullName = inserted.FullName,@Gender = inserted.Gender, @Email = inserted.Email,
		        @Phone = inserted.Phone,@YearOfBirth=inserted.YearOfBirth,@EmploymentDate = inserted.EmploymentDate,@PositionId = inserted.PositionId
		 FROM inserted
		 JOIN Positions ON inserted.PositionId = Positions.Id

		 IF @Position LIKE 'Junior'
		 BEGIN
		     IF @CountJunior<5
		        BEGIN 
                 insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId)
		     	 values (@FullName, @Gender, @Email, @Phone, @YearOfBirth, @EmploymentDate,@PositionId); 
		     	END
		     ELSE
			PRINT 'limit is filled Junior'
		 END 
END

--FOR CHECK
insert into Barbers (FullName, Gender, Email, Phone, YearOfBirth, EmploymentDate, PositionId) values ('Sawka Ivanov', 'Man', 'wmcmyler0@weebly.com', '489-833-3094', '1991-01-28', '2010-03-30', 3);


--14. Вернуть информацию о клиентах, которые не поставили ни одного фидбека и ни одной оценки 
--PROC
CREATE PROC ClientNoRatingNoFeedBack
AS
BEGIN
       SELECT DISTINCT Clients.FullName,Clients.Email,Clients.Phone FROM ArchiveOfVisits
	   JOIN FeedBacks ON ArchiveOfVisits.FeedBackId = FeedBacks.Id
	   JOIN Ratings ON ArchiveOfVisits.RatingId = Ratings.Id
	   JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id 
	   WHERE FeedBacks.Id LIKE 1 AND Ratings.Id LIKE 1  -- 1 это Without Rating\Feedback
END

EXEC ClientNoRatingNoFeedBack


--FUNC
CREATE FUNCTION ClientNoRatingNoFeedBack2()
RETURNS TABLE
AS
RETURN(SELECT DISTINCT Clients.FullName,Clients.Email,Clients.Phone FROM ArchiveOfVisits
	   JOIN FeedBacks ON ArchiveOfVisits.FeedBackId = FeedBacks.Id
	   JOIN Ratings ON ArchiveOfVisits.RatingId = Ratings.Id
	   JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id 
	   WHERE FeedBacks.Id LIKE 1 AND Ratings.Id LIKE 1)  -- 1 это Without Rating\Feedback

SELECT * FROM dbo.ClientNoRatingNoFeedBack2()

--15. Вернуть информацию о клиентах, которые не посещали барбершоп свыше одного года
--PROC
CREATE PROC LongNotVisitBarbershop
AS
BEGIN
	   SELECT Clients.FullName,Clients.Phone,Clients.Email
	   FROM Clients, (SELECT Clients.Id, MAX(ArchiveOfVisits.DateTime) as 'Last visit'
	                  FROM ArchiveOfVisits
	                  JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
	                  GROUP BY Clients.Id) AS SubQuery
	   WHERE Clients.Id LIKE SubQuery.Id AND DATEDIFF(year, SubQuery.[Last visit],GETDATE()) >= 1 
END


EXEC LongNotVisitBarbershop


--FUNC
CREATE FUNCTION LongNotVisitBarbershopByYear(@year INT)
RETURNS TABLE
	RETURN (SELECT Clients.FullName,Clients.Phone,Clients.Email
	        FROM Clients, (SELECT Clients.Id, MAX(ArchiveOfVisits.DateTime) as 'Last visit'
	                       FROM ArchiveOfVisits
	                       JOIN Clients ON ArchiveOfVisits.ClientId = Clients.Id
	                       GROUP BY Clients.Id) AS SubQuery
	        WHERE Clients.Id LIKE SubQuery.Id AND DATEDIFF(year, SubQuery.[Last visit],GETDATE()) >= @year)


SELECT *
FROM dbo.LongNotVisitBarbershopByYear(1)


--Я специально сделал по 2 раза каждое задание(некоторые расширил функйионал) чтобы просто руку набить и запомнить синтаксис
