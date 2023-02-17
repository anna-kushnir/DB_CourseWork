USE [KR_DB]
GO

-- 5.6	Написання SQL-запитів
-- 5.6.1
SELECT [PlaneID], [RegistrationNumber], (SELECT M.[Name] FROM [AircraftModels] M WHERE M.[ModelID] = P.[ModelID]) Model
FROM [Planes] P

-- 5.6.2
SELECT *
FROM [Clients]
WHERE [ClientID] IN (SELECT [ClientID] FROM [Tickets])

-- 5.6.3
DECLARE @ClientID INT
SET @ClientID = 9

SELECT F.[FlightID], F.[EconomyPrice] * (1 - C.[Discount]) [EconomyPrice], 
	F.[BusinessPrice] * (1 - C.[Discount]) [BusinessPrice]
FROM [Clients] C, [Flights] F
WHERE C.[ClientID] = @ClientID AND F.[DepartureTime] > CURRENT_TIMESTAMP

SELECT CURRENT_TIMESTAMP CurrTime

-- 5.6.4
SELECT F.[FlightID], F.[DepartureTime], R.[DestinationAirport],
	F.[EconomyPrice], V.[AvailableTickets]
FROM [Flights] F, [Routes] R, TicketsEconomyClass V
WHERE F.[RouteID] = R.[RouteID] AND F.[FlightID] = V.[FlightID]


-- 5.6.5
SELECT F.[FlightID], F.[DepartureTime], R.[DestinationAirport],
	F.[BusinessPrice], V.[AvailableTickets]
FROM [Flights] F, [Routes] R, TicketsBusinessClass V
WHERE F.[RouteID] = R.[RouteID] AND F.[FlightID] = V.[FlightID]

-- 5.6.6
SELECT E.[EmployeeID], ROUND(SUM(P.[Salary] * S.[Coefficient]), 2) Payment
FROM [Personnel] E
INNER JOIN [Positions] P
ON E.[PositionID] = P.[PositionID]
INNER JOIN [SalaryPayment] S
ON E.[EmployeeID] = S.[EmployeeID]
GROUP BY E.[EmployeeID]
ORDER BY Payment DESC

-- 5.6.7
SELECT C.[ClientID] ID, C.[Name] + ' ' + C.[Surname] FullName,
	C.[Document], COUNT(T.[TicketID]) BookedTickets
FROM [Clients] C
LEFT JOIN [Tickets] T
ON C.[ClientID] = T.[ClientID]
GROUP BY C.[ClientID], C.[Name] + ' ' + C.[Surname], C.[Document]

------------
SELECT E.[Surname] + ' ' + E.[Name] + ISNULL(' ' + E.[Patronymic], '') FullName,
	E.[Document], 'Працівник' [Type]
FROM [Personnel] E
UNION
SELECT C.[Surname] + ' ' + C.[Name] + ISNULL(' ' + C.[Patronymic], '') FullName,
	C.[Document], 'Клієнт' [Type]
FROM [Clients] C
ORDER BY FullName

-- 5.6.8
SELECT P.[PositionID], P.[Name] PositionName, COUNT(E.[EmployeeID]) EmployeesNumber
FROM [Personnel] E, [Positions] P
WHERE E.[PositionID] = P.[PositionID]
GROUP BY P.[PositionID], P.[Name]

-- 5.6.9
SELECT E.[Surname] + ' ' + E.[Name] FullName, E.[Document], E.[DateOfEmployement], P.[Name] Position, P.[Salary]
FROM [Personnel] E, [Positions] P
WHERE E.[PositionID] = P.[PositionID]
ORDER BY FullName

-- 5.6.10
DECLARE @FlightID INT
SET @FlightID = 1

SELECT A.[FlightID], P.[Name] EmployeePosition, E.[EmployeeID], E.[Surname] + ' ' + E.[Name] FullName
FROM [Aircrew] A, [Personnel] E, [Positions] P
WHERE A.[FlightID] = @FlightID AND
	A.[EmployeeID] = E.[EmployeeID] AND
	E.[PositionID] = P.[PositionID]
ORDER BY EmployeePosition, FullName


-- 5.7
SELECT F.[FlightID], F.[DepartureTime], R.[DestinationAirport],
	F.[EconomyPrice]
FROM [Flights] F
INNER JOIN [Routes] R
ON F.[RouteID] = R.[RouteID]


CREATE INDEX flights_index ON [Flights] ([FlightID], [RouteID]);
DROP INDEX flights_index ON [Flights]