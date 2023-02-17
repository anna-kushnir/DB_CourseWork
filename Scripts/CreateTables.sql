USE [KR_DB]
GO


-- Таблиця [Routes]
-- Структура:
-- [RouteID], int, колонка ідентифікаторів, PK
-- [DestinationAirport], nvarchar(70), колонка не може приймати значення NULL, FK
CREATE TABLE [Routes]
(
	[RouteID] INT IDENTITY(1, 1) NOT NULL,
	[DestinationAirport] NVARCHAR(70) NOT NULL,
	CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED ([RouteID])
)
-- Встановити обмеження для таблиці [Routes]
ALTER TABLE [dbo].[Routes]  
	WITH CHECK ADD CONSTRAINT [CK_Routes_DestinationAirport] 
	CHECK ([DestinationAirport] <> '')
GO


-- Таблиця [AircraftModels]
-- Структура:
-- [ModelID], int, колонка ідентифікаторів, PK
-- [Name], nvarchar(20), колонка не може приймати значення NULL
-- [NumberOfEconomySeats], int, колонка не може приймати значення NULL
-- [NumberOfBusinessSeats], int, колонка не може приймати значення NULL
CREATE TABLE [AircraftModels]
(
	[ModelID] INT IDENTITY(1, 1) NOT NULL,
	[Name] NVARCHAR(20) NOT NULL,
	[NumberOfEconomySeats] INT NOT NULL,
	[NumberOfBusinessSeats] INT NOT NULL,
	CONSTRAINT [PK_AircraftModels] PRIMARY KEY CLUSTERED ([ModelID])
)
-- Встановити обмеження для таблиці [AircraftModels]
ALTER TABLE [dbo].[AircraftModels]  
	WITH CHECK ADD CONSTRAINT [CK_AircraftModels_Name] 
	CHECK ([Name] <> '')
GO
ALTER TABLE [dbo].[AircraftModels]  
	WITH CHECK ADD CONSTRAINT [CK_AircraftModels_NumberOfSeats] 
	CHECK (([NumberOfEconomySeats] >= 0) AND ([NumberOfBusinessSeats] >= 0))
GO
ALTER TABLE [dbo].[AircraftModels]  
	WITH CHECK ADD CONSTRAINT [DF_AircraftModels_NumberOfEconomySeats] 
	DEFAULT 0 FOR [NumberOfEconomySeats]
GO
ALTER TABLE [dbo].[AircraftModels]  
	WITH CHECK ADD CONSTRAINT [DF_AircraftModels_NumberOfBusinessSeats] 
	DEFAULT 0 FOR [NumberOfBusinessSeats]
GO


-- Таблиця [Planes]
-- Структура:
-- [PlaneID], int, колонка ідентифікаторів, PK
-- [RegistrationNumber], int, колонка не може приймати значення NULL
-- [ModelID], int, колонка не може приймати значення NULL, FK
CREATE TABLE [Planes]
(
	[PlaneID] INT IDENTITY(1, 1) NOT NULL,
	[RegistrationNumber] INT NOT NULL,
	[ModelID] INT NOT NULL,
	CONSTRAINT [PK_Planes] PRIMARY KEY CLUSTERED ([PlaneID])
)
-- Встановити зв'язок  FK між таблицями [Planes] та [AircraftModels]
-- Зв'язок: [Planes].[ModelID] -> [AircraftModels].[ModelID]
ALTER TABLE [dbo].[Planes]  
	WITH CHECK ADD CONSTRAINT [FK_Planes_AircraftModels] 
	FOREIGN KEY([ModelID])
	REFERENCES [dbo].[AircraftModels] ([ModelID])
		ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити обмеження для таблиці [Planes]
ALTER TABLE [dbo].[Planes]  
	WITH CHECK ADD CONSTRAINT [CK_Planes_RegistrationNumber] 
	CHECK ([RegistrationNumber] > 0)
GO
ALTER TABLE [dbo].[Planes]  
	WITH CHECK ADD CONSTRAINT [UQ_Planes_RegistrationNumber] 
	UNIQUE ([RegistrationNumber])
GO


-- Таблиця [Flights]
-- Структура:
-- [FlightID], int, колонка ідентифікаторів, PK
-- [RouteID], int, колонка не може приймати значення NULL, FK
-- [PlaneID], int, колонка не може приймати значення NULL, FK
-- [DepartureTime], datetime, колонка не може приймати значення NULL
-- [EconomyPrice], [BusinessPrice], money, колонка може приймати значення NULL
CREATE TABLE [Flights]
(
	[FlightID] INT IDENTITY(1, 1) NOT NULL,
	[RouteID] INT NOT NULL,
	[PlaneID] INT NOT NULL,
	[DepartureTime] DATETIME NOT NULL,
	[EconomyPrice] SMALLMONEY NULL,
	[BusinessPrice] SMALLMONEY NULL,
	CONSTRAINT [PK_Flights] PRIMARY KEY CLUSTERED ([FlightID])
)
-- Встановити зв'язок  FK між таблицями [Flights] та [Routes]
-- Зв'язок: [Flights].[RouteID] -> [Routes].[RouteID]
ALTER TABLE [dbo].[Flights]  
	WITH CHECK ADD CONSTRAINT [FK_Flights_Routes] 
	FOREIGN KEY([RouteID])
	REFERENCES [dbo].[Routes] ([RouteID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити зв'язок  FK між таблицями [Flights] та [Planes]
-- Зв'язок: [Flights].[PlaneID] -> [Planes].[PlaneID]
ALTER TABLE [dbo].[Flights]  
	WITH CHECK ADD CONSTRAINT [FK_Flights_Planes] 
	FOREIGN KEY([PlaneID])
	REFERENCES [dbo].Planes ([PlaneID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити обмеження для таблиці [Flights]
ALTER TABLE [dbo].[Flights]  
	WITH CHECK ADD CONSTRAINT [CK_Flights_Price] 
	CHECK (([BusinessPrice] >= 0 OR [BusinessPrice] IS NULL)
		AND ([EconomyPrice] >= 0 OR [EconomyPrice] IS NULL))
GO


-- Таблиця [Clients]
-- Структура:
-- [ClientID], int, колонка ідентифікаторів, PK
-- [Surname], nvarchar(15), колонка не може приймати значення NULL
-- [Name], nvarchar(15), колонка не може приймати значення NULL
-- [Patronymic], nvarchar(15), колонка може приймати значення NULL
-- [Document], nvarchar(12), колонка не може приймати значення NULL, UQ
-- [Discount], real, колонка може приймати значення NULL
CREATE TABLE [Clients]
(
	[ClientID] INT IDENTITY(1, 1) NOT NULL,
	[Surname] NVARCHAR(15) NOT NULL,
	[Name] NVARCHAR(15) NOT NULL,
	[Patronymic] NVARCHAR(15) NULL,
	[Document] NVARCHAR(12) NOT NULL,
	[Discount] REAL NOT NULL,
	CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([ClientID])
)
-- Встановити обмеження для таблиці [Clients]
ALTER TABLE [dbo].[Clients]  
	WITH CHECK ADD CONSTRAINT [CK_Clients_Surname] 
	CHECK ([Surname] <> '')
GO
ALTER TABLE [dbo].[Clients]  
	WITH CHECK ADD CONSTRAINT [CK_Clients_Name] 
	CHECK ([Name] <> '')
GO
ALTER TABLE [dbo].[Clients]  
	WITH CHECK ADD CONSTRAINT [UQ_Clients_Document] 
	UNIQUE ([Document])
GO
ALTER TABLE [dbo].[Clients]  
	WITH CHECK ADD CONSTRAINT [CK_Clients_Discount] 
	CHECK ([Discount] BETWEEN 0 AND 1)
GO
ALTER TABLE [dbo].[Clients]  
	WITH CHECK ADD CONSTRAINT [DF_Clients_Discount] 
	DEFAULT 0 FOR [Discount]
GO


-- Таблиця [Tickets]
-- Структура:
-- [TicketID], int, колонка ідентифікаторів, PK
-- [FlightID], int, колонка не може приймати значення NULL, FK
-- [ClientID], int, колонка не може приймати значення NULL, FK
-- [Comfort], nvarchar(8), колонка не може приймати значення NULL
-- [SeatNumber], int, колонка не може приймати значення NULL, UQ

CREATE TABLE [Tickets]
(
	[TicketID] INT IDENTITY(1, 1) NOT NULL,
	[FlightID] INT NOT NULL,
	[ClientID] INT NOT NULL,
	[Comfort] NVARCHAR(8) NOT NULL,
	[SeatNumber] INT NOT NULL,
	[DateOfPurchase] DATE NOT NULL,
	CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED ([TicketID])
)
-- Встановити зв'язок  FK між таблицями [Tickets] та [Flights]
-- Зв'язок: [Tickets].[FlightID] -> [Flights].[FlightID]
ALTER TABLE [dbo].[Tickets] 
	WITH CHECK ADD CONSTRAINT [FK_Tickets_Flights] 
	FOREIGN KEY([FlightID])
	REFERENCES [dbo].[Flights] ([FlightID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити зв'язок  FK між таблицями [Tickets] та [Clients]
-- Зв'язок: [Tickets].[ClientID] -> [Clients].[ClientID]
ALTER TABLE [dbo].[Tickets]
	WITH CHECK ADD CONSTRAINT [FK_Tickets_Clients] 
	FOREIGN KEY([ClientID])
	REFERENCES [dbo].[Clients] ([ClientID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити обмеження для таблиці [Tickets]
ALTER TABLE [dbo].[Tickets]  
	WITH CHECK ADD CONSTRAINT [CK_Tickets_Comfort] 
	CHECK (LOWER([Comfort]) IN ('бізнес', 'економ'))
GO
ALTER TABLE [dbo].[Tickets]  
	WITH CHECK ADD CONSTRAINT [UQ_Tickets]
	UNIQUE ([FlightID], [Comfort], [SeatNumber])
GO


-- Таблиця [Positions]
-- Структура:
-- [PositionID], int, колонка ідентифікаторів, PK
-- [Name], nvarchar(15), колонка не може приймати значення NULL
-- [Salary], smallmoney, колонка не може приймати значення NULL
CREATE TABLE [Positions]
(
	[PositionID] INT IDENTITY(1, 1) NOT NULL,
	[Name] NVARCHAR(15) NOT NULL,
	[Salary] SMALLMONEY NOT NULL,
	CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([PositionID])
)
-- Встановити обмеження для таблиці [Positions]
ALTER TABLE [dbo].[Positions]  
	WITH CHECK ADD CONSTRAINT [CK_Positions_Name] 
	CHECK ([Name] <> '')
GO
ALTER TABLE [dbo].[Positions]  
	WITH CHECK ADD CONSTRAINT [CK_Positions_Salary] 
	CHECK ([Salary] >= 0)
GO


-- Таблиця [Personnel]
-- Структура:
-- [EmployeeID], int, колонка ідентифікаторів, PK
-- [Surname], nvarchar(15), колонка не може приймати значення NULL
-- [Name], nvarchar(15), колонка не може приймати значення NULL
-- [Patronymic], nvarchar(15), колонка може приймати значення NULL
-- [Document], nvarchar(12), колонка не може приймати значення NULL, UQ
-- [PositionID], int, колонка не може приймати значення NULL, FK
-- [DateOfEmployement], date, колонка не може приймати значення NULL
CREATE TABLE [Personnel]
(
	[EmployeeID] INT IDENTITY(1, 1) NOT NULL,
	[Surname] NVARCHAR(15) NOT NULL,
	[Name] NVARCHAR(15) NOT NULL,
	[Patronymic] NVARCHAR(15) NULL,
	[Document] NVARCHAR(12) NOT NULL,
	[PositionID] INT NOT NULL,
	[DateOfEmployement] DATE NOT NULL,
	CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED ([EmployeeID])
)
-- Встановити зв'язок  FK між таблицями [Personnel] та [Positions]
-- Зв'язок: [Personnel].[PositionID] -> [Positions].[PositionID]
ALTER TABLE [dbo].[Personnel]  
	WITH CHECK ADD CONSTRAINT [FK_Personnel_Positions] 
	FOREIGN KEY([PositionID])
	REFERENCES [dbo].[Positions] ([PositionID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити обмеження для таблиці [Clients]
ALTER TABLE [dbo].[Personnel]  
	WITH CHECK ADD CONSTRAINT [CK_Personnel_Surname] 
	CHECK ([Surname] <> '')
GO
ALTER TABLE [dbo].[Personnel]  
	WITH CHECK ADD CONSTRAINT [CK_Personnel_Name] 
	CHECK ([Name] <> '')
GO
ALTER TABLE [dbo].[Personnel]  
	WITH CHECK ADD CONSTRAINT [UQ_Personnel_Document] 
	UNIQUE ([Document])
GO


-- Таблиця [Aircrew]
-- Структура:
-- [FlightID], int, колонка ідентифікаторів, PK, FK
-- [EmployeeID], int, колонка ідентифікаторів, PK, FK
CREATE TABLE [Aircrew]
(
	[FlightID] INT NOT NULL,
	[EmployeeID] INT NOT NULL,
	CONSTRAINT [PK_Aircrew] PRIMARY KEY CLUSTERED ([FlightID], [EmployeeID])
)
-- Встановити зв'язок  FK між таблицями [Aircrew] та [Flights]
-- Зв'язок: [Aircrew].[FlightID] -> [Flights].[FlightID]
ALTER TABLE [dbo].[Aircrew]  
	WITH CHECK ADD CONSTRAINT [FK_Aircrew_Flights] 
	FOREIGN KEY([FlightID])
	REFERENCES [dbo].[Flights] ([FlightID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити зв'язок  FK між таблицями [Aircrew] та [Personnel]
-- Зв'язок: [Aircrew].[EmployeeID] -> [Personnel].[EmployeeID]
ALTER TABLE [dbo].[Aircrew]  
	WITH CHECK ADD CONSTRAINT [FK_Aircrew_Personnel] 
	FOREIGN KEY([EmployeeID])
	REFERENCES [dbo].[Personnel] ([EmployeeID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO


-- Таблиця [SalaryPayment]
-- Структура:
-- [FlightID], int, колонка ідентифікаторів, PK, FK
-- [EmployeeID], int, колонка ідентифікаторів, PK, FK
CREATE TABLE [SalaryPayment]
(
	[PaymentID] INT IDENTITY(1, 1) NOT NULL,
	[EmployeeID] INT NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[Coefficient] REAL NOT NULL
	CONSTRAINT [PK_SalaryPayment] PRIMARY KEY CLUSTERED ([PaymentID])
)
-- Встановити зв'язок  FK між таблицями [SalaryPayment] та [Personnel]
-- Зв'язок: [SalaryPayment].[EmployeeID] -> [Personnel].[EmployeeID]
ALTER TABLE [dbo].[SalaryPayment]  
	WITH CHECK ADD CONSTRAINT [FK_SalaryPayment_Personnel] 
	FOREIGN KEY([EmployeeID])
	REFERENCES [dbo].[Personnel] ([EmployeeID])
	ON UPDATE CASCADE ON DELETE CASCADE
GO
-- Встановити обмеження для таблиці [SalaryPayment]
ALTER TABLE [dbo].[SalaryPayment]  
	WITH CHECK ADD CONSTRAINT [DF_SalaryPayment_Coefficient] 
	DEFAULT 1 FOR [Coefficient]
GO
ALTER TABLE [dbo].[SalaryPayment]  
	WITH CHECK ADD CONSTRAINT [CK_SalaryPayment_Coefficient] 
	CHECK ([Coefficient] > 0)
GO