USE [BookLibrary]
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Books]
	(
	BookID int NOT NULL IDENTITY (1, 1),
	BookTitle varchar(100) NOT NULL,
	BookAuthor varchar(50) NOT NULL,
	BookGenre varchar(30) NOT NULL,
	BookISBN varchar(13) NOT NULL,
	BookPrice float NOT NULL,
	BookQuantity int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Books] ADD CONSTRAINT
	[PK_Books] PRIMARY KEY CLUSTERED 
	(
	BookID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Books] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
INSERT INTO [dbo].[Books]
			(BookTitle, BookAuthor, BookGenre, BookISBN, BookPrice, BookQuantity)
		VALUES
			('Hideaway', 'Nora Roberts', 'Crime Drama', '9789100183172', 229, 5),
			('Undercurrents', 'Nora Roberts', 'Crime Drama', '9789100186135', 95, 3),
			('Vinterpacket', 'Jacob Lindfors', 'Crime Drama', '9789164206886', 249, 2),
			('Camino Winds', 'John Grisham', 'Crime Drama', '9781529349900', 149, 5),
			('The Last Train to London', 'Meg Waite Clayton', 'Fiction', '9789177891185', 95, 0),
			('N�stan bra p� livet', 'Conny Palmkvist', 'Fiction', '9789180060561', 249, 2),
			('Pobeda 1946', 'Ilmar Taska', 'Fiction', '9789177895015', 95, 10),
			('Bakvatten', 'Maria Broberg', 'Fiction', '9789113098517', 95, 3),
			('Koirapuisto', 'Sofi Oksanen', 'Fiction', '9789100181680', 269, 2),
			('Nattens f�rger', 'Kristin F�gerskj�ld', 'Fiction', '9789177992097', 245, 8),
			('Noveller', 'Tessa Hadley', 'Fiction', '9789146236238', 249, 9),
			('Atlantis och andra myter', 'Dick Harrison', 'History', '9789177895701', 95, 0),
			('Catalinaaff�ren', 'Wilhelm Agrell', 'History', '9789177894315', 199, 8),
			('Fascism : a warning', 'Madeleine Albright', 'History', '9789177894940', 95, 4),
			('Leonardo da Vinci', 'Walter Isaacson', 'History', '9789127169036', 95, 5),
			('Boy from the woods', 'Harlan Coben', 'Crime Drama', '9781538702734', 278, 6),
			('Remote Control', 'Nnedi Okorafor', 'Science Fiction', '9781250772800', 249, 13),
			('Labyrinten', 'Simon St�lenhag', 'Science Fiction', '9789189143012', 349, 0),
			('Dune', 'Frank Herbert', 'Science Fiction', '9780340960196', 119, 3),
			('Blood of Elves', 'Andrzej Sapkowski', 'Fantasy', '9780575084841', 179, 7),
			('The Last Wish', 'Andrzej Sapkowski', 'Fantasy', '9781473231061', 99, 3),
			('The Shining', 'Stephen King', 'Horror', '9780385121675', 219, 2),
			('Cujo', 'Stephen King', 'Horror', '9780670451937', 179, 8),
			('The Stand', 'Stephen King', 'Horror', '9780385121682', 229, 9),
			('Ut kom vargarna', 'Jesper Ersg�rd', 'Crime Drama', '9789185535514', 69, 0),
			('The Stranger', 'Harlan Coben', 'Crime Drama', '9781409103981', 299, 8),
			('Centurion', 'Simon Scarrow', 'Fiction', '9780755380220', 199, 4),
			('The Eagle in the Sand', 'Simon Scarrow', 'Fiction', '9780755327744', 199, 5),
			('Agency', 'William Gibson', 'Science Fiction', '9780241974575', 149, 5),
			('Fury of Magnus', 'Graham McNeill', 'Science Fiction', '9781789992915', 229, 3)
COMMIT
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Customers]
	(
	CustomerID int NOT NULL IDENTITY (1, 1),
	FirstName varchar(25) NOT NULL,
	Lastname varchar(25) NOT NULL,
	Street varchar(30) NOT NULL,
	Zip varchar(10) NOT NULL,
	City varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Customers] ADD CONSTRAINT
	[PK_Customers] PRIMARY KEY CLUSTERED 
	(
	CustomerID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Customers] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
INSERT INTO [dbo].[Customers]
			(FirstName, LastName, Street, Zip, City)
		VALUES
			('Martin', 'Machl', 'Duvnäsgatan 14', '11436', 'Stockholm'),
			('Göran', 'Persson', 'Hyltingeö Torps Gård', '64696', 'Stjärnhov'),
			('David', 'Hellenius', 'Observatoriegatan 2A', '11329', 'Stockholm')
COMMIT
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Orders]
	(
	ID int NOT NULL IDENTITY (1, 1),
	OrderID int NOT NULL,
	CustomerID int NOT NULL,
	BookID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Orders] ADD CONSTRAINT
	[PK_Orders] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Orders] ADD CONSTRAINT
	FK_Link_Order FOREIGN KEY
	(
	OrderID
	) REFERENCES dbo.[OrderNumbers]
	(
	OrderID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Orders] ADD CONSTRAINT
	FK_Link_Customer FOREIGN KEY
	(
	CustomerID
	) REFERENCES dbo.[Customers]
	(
	CustomerID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Orders] ADD CONSTRAINT
	FK_Link_Book FOREIGN KEY
	(
	BookID
	) REFERENCES dbo.[Books]
	(
	BookID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Orders] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[BackOrders]
	(
	ID int NOT NULL IDENTITY (1, 1),
	OrderID int NOT NULL,
	CustomerID int NOT NULL,
	BookID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[BackOrders] ADD CONSTRAINT
	[PK_BackOrders] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[BackOrders] ADD CONSTRAINT
	FK_Link_BOrder FOREIGN KEY
	(
	OrderID
	) REFERENCES dbo.[OrderNumbers]
	(
	OrderID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[BackOrders] ADD CONSTRAINT
	FK_Link_BO_Customer FOREIGN KEY
	(
	CustomerID
	) REFERENCES dbo.[Customers]
	(
	CustomerID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[BackOrders] ADD CONSTRAINT
	FK_Link_BO_Book FOREIGN KEY
	(
	BookID
	) REFERENCES dbo.[Books]
	(
	BookID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[BackOrders] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
INSERT INTO [dbo].[Orders]
			(OrderID, CustomerID, BookID)
		VALUES
			(1, 1, 4),
			(1, 1, 21),
			(2, 2, 13),
			(3, 3, 16),
			(3, 3, 28),
			(3, 3, 26),
			(4, 5, 20),
			(4, 5, 22),
			(5, 7, 31),
			(5, 7, 30)
COMMIT
GO

BEGIN TRANSACTION
INSERT INTO [dbo].[BackOrders]
			(OrderID, CustomerID, BookID)
		VALUES
			(1, 1, 5),
			(2, 2, 20)
COMMIT
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[OrderNumbers]
	(
	OrderID int NOT NULL IDENTITY (1, 1),
	OrderNum int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[OrderNumbers] ADD CONSTRAINT
	[PK_OrderNumbers] PRIMARY KEY CLUSTERED 
	(
	OrderID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[OrderNumbers] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

BEGIN TRANSACTION
GO
CREATE TABLE dbo.[WishList]
	(
	WishID int NOT NULL IDENTITY (1, 1),
	BookTitle varchar(50)
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[WishList] ADD CONSTRAINT
	[PK_WishList] PRIMARY KEY CLUSTERED 
	(
	WishID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[WishList] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

insert into WishList (BookTitle) VALUES ('Harry Potter'),('Lord of the Rings The Two Towers'),('Mio min Mio')

select * from books

select * from orders

select * from customers

select * from OrderNumbers

delete from customers where customerid = 9

select * from backorders

update Customers
set UserName ='Hellan'
where customerID = 4

update Customers
set Password = 'hylans'
where customerID = 4

update Customers
set UserName ='Rhenen'
where customerID = 5

update Customers
set Password = 'NileCity'
where customerID = 5

update Customers
set UserName ='Sventon'
where customerID = 7

update Customers
set Password = 'svenne420'
where customerID = 7

update Customers
set UserName ='Semlan'
where customerID = 8

update Customers
set Password = 'rosen'
where customerID = 8

SELECT O.OrderNum, C.FirstName, C.LastName, C.Street, C.Zip, C.City, B.BookTitle, B.BookPrice 
FROM OrderNumbers as O
INNER JOIN BackOrders as BO 
ON O.OrderID = BO.OrderID
INNER JOIN Customers as C
ON C.CustomerID = O.OrderID
INNER JOIN Books as B
ON BO.BookID = B.BookID order by BO.OrderID

SELECT O.OrderNum, C.FirstName, C.LastName, C.Street, C.Zip, C.City, B.BookTitle, B.BookPrice 
FROM OrderNumbers as O
INNER JOIN Orders as O2
ON O.OrderID = O2.OrderID
INNER JOIN Customers as C
ON C.CustomerID = O2.CustomerID
INNER JOIN Books as B
ON O2.BookID = B.BookID order by O2.OrderID

delete from orders where orderid = 9

update books set BookQuantity = BookQuantity + 1 where BookTitle like 'the stand'

