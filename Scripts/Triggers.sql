USE [KR_DB]
GO

-- 5.4	Створення тригерів
CREATE OR ALTER TRIGGER on_insert_tickets
ON [Tickets]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @FlightID INT, @ClientID INT, @Comfort NVARCHAR(8), 
		@SeatNumber INT, @Date DATE
	SELECT @FlightID = [FlightID], @ClientID = [ClientID], @Comfort = [Comfort], 
		@SeatNumber = [SeatNumber], @Date = [DateOfPurchase] FROM inserted
	IF DATEDIFF(DAY, @Date, (SELECT F.[DepartureTime] FROM [Flights] F WHERE F.[FlightID] = @FlightID)) < 0
		SELECT 'Flight tickets can only be purchased before the flight. The input was:' Error,
		@FlightID FlightID, @ClientID ClientID, @Comfort Comfort, @SeatNumber SeatNumber, @Date DateOfPurchase
	ELSE IF LOWER(@Comfort) = 'економ' AND NOT @SeatNumber BETWEEN 1 AND (
    SELECT [AircraftModels].[NumberOfEconomySeats]
    FROM [Flights], [Planes], [AircraftModels]
    WHERE @FlightID = [Flights].[FlightID]
      AND [Flights].[PlaneID] = [Planes].[PlaneID]
      AND [Planes].[ModelID] = [AircraftModels].[ModelID]
    )
    OR
    LOWER(@Comfort) = 'бізнес' AND NOT @SeatNumber BETWEEN 1 AND (
    SELECT [AircraftModels].[NumberOfBusinessSeats]
    FROM [Flights], [Planes], [AircraftModels]
    WHERE @FlightID = [Flights].[FlightID]
      AND [Flights].[PlaneID] = [Planes].[PlaneID]
      AND [Planes].[ModelID] = [AircraftModels].[ModelID]
    )
		SELECT 'The number of the seat is out of the range. The input was:' Error, 
		@FlightID FlightID, @ClientID ClientID, @Comfort Comfort, @SeatNumber SeatNumber, @Date DateOfPurchase
	ELSE
		INSERT INTO [Tickets]
			([FlightID], [ClientID], [Comfort], [SeatNumber], [DateOfPurchase])
		VALUES
			(@FlightID, @ClientID, @Comfort, @SeatNumber, @Date)		
END
GO

INSERT INTO [Tickets]
	([FlightID], [ClientID], [Comfort], [SeatNumber], [DateOfPurchase])
	VALUES
	-- (11, 4, 'економ', 1, '2022-12-23')
	-- (15, 3, 'економ', 15, '2022-12-23'),
	-- (11, 8, 'бізнес', 1, '2022-12-23')
	(11, 4, 'економ', 1, '2023-01-05')
	;

SELECT * FROM [Tickets]
GO



CREATE OR ALTER TRIGGER on_insert_flights
ON [Flights]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @RouteID INT, @PlaneID INT, @DepartureTime DATETIME,
		@EconomyPrice SMALLMONEY, @BusinessPrice SMALLMONEY
	SELECT @RouteID = [RouteID], @PlaneID = [PlaneID], 
	@DepartureTime = [DepartureTime], @EconomyPrice = [EconomyPrice], 
	@BusinessPrice = [BusinessPrice] FROM inserted
	IF @EconomyPrice IS NULL AND
		(SELECT M.[NumberOfEconomySeats] FROM [AircraftModels] M, 
		[Planes] P WHERE P.PlaneID = @PlaneID AND M.ModelID = P.ModelID) > 0
		SELECT 'You must enter the price of the economy seat!' Error
	IF @BusinessPrice IS NULL AND
		(SELECT M.[NumberOfBusinessSeats] FROM [AircraftModels] M, 
		[Planes] P WHERE P.PlaneID = @PlaneID AND M.ModelID = P.ModelID) > 0
		SELECT 'You must enter the price of the business seat!' Error
	ELSE
		INSERT INTO [Flights]
		([RouteID], [PlaneID], [DepartureTime], [EconomyPrice], [BusinessPrice])
		VALUES
		(@RouteID, @PlaneID, @DepartureTime, @EconomyPrice, @BusinessPrice)
END
GO

INSERT INTO [Flights]
	([RouteID], [PlaneID], [DepartureTime], [EconomyPrice], [BusinessPrice])
	VALUES
	(5, 1, '2023-02-01 10:00', null, null)
	;
GO

INSERT INTO [Flights]
	([RouteID], [PlaneID], [DepartureTime], [EconomyPrice], [BusinessPrice])
	VALUES
	(5, 1 , '2023-02-01 10:00', 1300, 2500)
	;
	GO

SELECT * FROM [Flights]
GO



CREATE OR ALTER TRIGGER on_insert_salary
ON [SalaryPayment]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @EmployeeID INT, @PaymentDate DATE,
		@Coefficient REAL
	SELECT @EmployeeID = [EmployeeID], @PaymentDate = [PaymentDate], 
	@Coefficient = [Coefficient] FROM inserted
	IF DATEDIFF(DAY, @PaymentDate, (SELECT [DateOfEmployement] FROM [Personnel] E WHERE E.[EmployeeID] = @EmployeeID)) > 0
		SELECT 'It is impossible to pay the employee a salary before he is employed! The input was:' Error,
		@EmployeeID EmployeeID, @PaymentDate PaymentDate, @Coefficient Coefficient
	ELSE
		INSERT INTO [SalaryPayment]
		([EmployeeID], [PaymentDate], [Coefficient])
		VALUES
		(@EmployeeID, @PaymentDate,	@Coefficient)
END
GO

INSERT INTO [SalaryPayment] 
	([EmployeeID], [PaymentDate], [Coefficient])
	VALUES
	(1, '2020-02-05', 1)
	;

SELECT * FROM [Personnel] WHERE [EmployeeID] = 1