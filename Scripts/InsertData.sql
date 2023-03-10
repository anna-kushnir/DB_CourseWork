USE [KR_DB]
GO

-- Додавання тестових даних до  таблиць.
INSERT INTO [Routes] 
	([DestinationAirport])
	VALUES
	('Міжнародний аеропорт "Львів" ім. Данила Галицького'),
	('Міжнародний аеропорт "Дніпро"'),
	('Міжнародний аеропорт "Одеса"'),
	('Міжнародний аеропорт "Харків"'),
	('Міжнародний Аеропорт "Бориспіль" (Київ)'),
	('Аеропорт "Варшава-Модлін"'),
	('Аеропорт "Берлін-Бранденбург"'),
	('Аеропорт імені Фридерика Шопена (Варшава)'),
	('Будапештський міжнародний аеропорт ім. Ф.Ліста'),
	('Milan Bergamo International Airport (Мілан)'),
	('Міжнародний аеропорт Краків - Баліце'),
	('Аеропорт "Станстед" (Лондон)'),
	('Аеропорт "Рига"'),
	('Аеропорт "Каструп" (Копенгаген)'),
	('Празький аеропорт ім. Вацлава Гавела')
	;

SELECT * FROM [Routes]


INSERT INTO [AircraftModels]
	([Name], [NumberOfEconomySeats], [NumberOfBusinessSeats])
	VALUES
	('Boeing 747', 128, 32),
	('А380', 112, 16),
	('A300', 64, 16),
	('A310', 0, 16),
	('A330', 48, 8),
	('A340', 48, 12),
	('Boeing 767', 64, 8),
	('Boeing 777', 64, 16),
	('Boeing 787', 36, 16),
	('Іл-86', 72, 0),
	('Іл-96', 32, 8)
	;

SELECT * FROM [AircraftModels]


INSERT INTO [Planes]
	([RegistrationNumber], [ModelID])
	VALUES
	(324729, 1),
	(840292, 2),
	(384249, 2),
	(382410, 3),
	(320810, 4),
	(118401, 4),
	(958934, 5),
	(732791, 5),
	(437892, 7),
	(324810, 8),
	(824981, 10),
	(735829, 10),
	(843932, 10),
	(593558, 11)
	;

SELECT * FROM [Planes]


INSERT INTO [Flights]
	([RouteID], [PlaneID], [DepartureTime], [EconomyPrice], [BusinessPrice])
	VALUES
	(1, 1, '2023-01-01 12:00', 900, 1500),
	(2, 5, '2023-01-01 13:00', null, 2000),
	(3, 6, '2023-01-01 13:00', null, 1800),
	(4, 7, '2023-01-02 10:00', 1000, 2200),
	(5, 3, '2023-01-02 10:00', 800, 1200),
	(6, 1, '2023-01-02 11:00', 1000, 2000),
	(7, 2, '2023-01-02 20:00', 900, 1800),
	(8, 8, '2023-01-03 08:00', 850, 1600),
	(9, 9, '2023-01-03 18:00', 1000, 2300),
	(10, 10, '2023-01-04 10:00', 1100, 2400),
	(11, 6, '2023-01-04 12:00', null, 1950),
	(12, 12, '2023-01-04 15:00', 800, null),
	(13, 5, '2023-01-04 17:00', null, 1900),
	(14, 4, '2023-01-04 18:00', 750, 1550),
	(15, 11, '2023-01-05 09:00', 1000, null)
	;

SELECT * FROM [Flights]


INSERT INTO [Clients]
	([Surname], [Name], [Patronymic], [Document])
	VALUES
	('Тейт', 'Табіта', null, '001956782426'),
	('Тейт', 'Боб', null, '002046183263'),
	('Блоссом', 'Шеріл', null, '003791936729'),
	('Дізель', 'Він', null, '003527193001'),
	('Українка', 'Леся', null, 'CX271835'),
	('Шевченко', 'Тарас', 'Григорович', '57913729'),
	('Ніякий', 'Хтось', null, '0552689470'),
	('Стеценко', 'Аліса', 'Володимирівна', '001729372'),
	('Погорельцева', 'Тетяна', 'Михайлівна', '002738171'),
	('Рейнхарт', 'Лілі', null, '081936273'),
	('Зальцман', 'Лізі', null, '001983936'),
	('Купер', 'Поллі', null, '009826381'),
	('Сальваторе', 'Стефан', null, '019972410'),
	('Сальваторе', 'Деймон', null, '115793111'),
	('Шевченко', 'Катерина', 'Григорівна', 'EE829128')
	;
GO
UPDATE [Clients]
SET [Discount] = 0.1
WHERE [ClientID] IN (2, 5, 6, 9)
GO
UPDATE [Clients]
SET [Discount] = 0.2
WHERE [ClientID] IN (3, 12)
GO

SELECT * FROM [Clients]


INSERT INTO [Tickets]
	([FlightID], [ClientID], [Comfort], [SeatNumber], [DateOfPurchase])
	VALUES
	(1, 1, 'економ', 1, '2022-10-30'),
	(1, 2, 'економ', 2, '2022-10-30'),
	(2, 5, 'бізнес', 3, '2022-11-18'),
	(3, 7, 'бізнес', 7, '2022-11-27'),
	(5, 9, 'економ', 3, '2022-12-02')
	;

SELECT * FROM [Tickets]


INSERT INTO [Positions]
	([Name], [Salary])
	VALUES
	('Директор', 60000),
	('Зам. директора', 55000),
	('Адміністратор', 38000),
	('Менеджер продаж', 35000),
	('Пілот', 50000),
	('Помічник пілота', 45000),
	('Стюрдеса', 35000),
	('Обсл. літака', 30000),
	('Охоронець', 25000),
	('Тех. персонал', 20000)
	;

SELECT * FROM [Positions]


INSERT INTO [Personnel]
	([Surname], [Name], [Patronymic], [Document], [PositionID], [DateOfEmployement])
	VALUES
	('Гранде', 'Аріана', null, '001927381', 1, '2021-01-20'),
	('Ришко', 'Тетяна', 'Миколаївна', '001825728', 2, '2021-02-18'),
	('Карпюк', 'Олесь', null, '001728192', 4, '2021-09-01'),
	('Ларін', 'Микола', 'Валерійович', '001927628', 6, '2022-01-20'),
	('Кропів', 'Віктор', 'Вікторович', '002818283', 9, '2022-04-01'),
	('Рурік', 'Станіслав', null, '002828162', 5, '2022-05-10'),
	('Рахів', 'Карина', 'Андріївна', '001562738', 3, '2021-03-11'),
	('Шкредь', 'Ірина', 'Вікторівна', 'CB728193', 6, '2022-05-20'),
	('Вест', 'Ханна', null, '00172829182', 5, '2022-09-15'),
	('Микулинич', 'Іван', 'Іванович', 'CB627183', 8, '2022-10-20'),
	('Клименко', 'Надія', 'Степанівна', 'EB637183', 7, '2022-08-10'),
	('Фрейман', 'Нік', null, '01283947281', 6, '2022-10-30'),
	('Лейбніц', 'Мартін', null, '26173829193', 8, '2022-11-20'),
	('Вірна', 'Іванна', 'Артемівна', '001828361', 10, '2022-07-07'),
	('Степаненко', 'Стефанія', 'Степанівна', 'EE617293', 7, '2022-12-10'),
	('Кришна', 'Єлизавета', 'Андріївна', '001836431', 7, '2022-05-08')
	;

SELECT * FROM [Personnel]


INSERT INTO [Aircrew]
	([FlightID], [EmployeeID])
	VALUES
	(1, 6),
	(1, 4),
	(1, 11),
	(1, 15),
	(1, 16),
	(1, 10),
	(5, 9),
	(5, 12),
	(5, 11),
	(5, 15),
	(5, 16)
	;

SELECT * FROM [Aircrew]


INSERT INTO [SalaryPayment]
	([EmployeeID], [PaymentDate], [Coefficient])
	VALUES
	(1, '2022-11-30', 1),
	(2, '2022-11-30', 1),
	(3, '2022-11-30', 1),
	(4, '2022-11-30', 1),
	(5, '2022-11-30', 1),
	(6, '2022-11-30', 1),
	(7, '2022-11-30', 1),
	(8, '2022-11-30', 1),
	(9, '2022-11-30', 1),
	(10, '2022-11-30', 1),
	(11, '2022-11-30', 1),
	(12, '2022-11-30', 1),
	(13, '2022-11-30', 1),
	(14, '2022-11-30', 1),
	(15, '2022-11-30', 1),
	(1, '2022-12-20', 0.3),
	(2, '2022-12-20', 0.3),
	(3, '2022-12-20', 0.3),
	(4, '2022-12-20', 0.3),
	(5, '2022-12-20', 0.3),
	(6, '2022-12-20', 0.3),
	(7, '2022-12-20', 0.3),
	(8, '2022-12-20', 0.3),
	(9, '2022-12-20', 0.3),
	(10, '2022-12-20', 0.3),
	(11, '2022-12-20', 0.3),
	(12, '2022-12-20', 0.3),
	(13, '2022-12-20', 0.3),
	(14, '2022-12-20', 0.3),
	(15, '2022-12-20', 0.3)
	;

SELECT * FROM [SalaryPayment]