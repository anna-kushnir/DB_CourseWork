USE [KR_DB]
GO

-- 5.3	Створення функцій
CREATE OR ALTER FUNCTION getFlightReport (@FlightID INT)
RETURNS @Report TABLE (
	[FlightID] INT NOT NULL,
	[Tickets] INT NOT NULL,
	[TicketRevenue] MONEY NOT NULL
	)
AS
BEGIN
	INSERT @Report
	SELECT @FlightID, COUNT(*), 
		(SELECT ISNULL(SUM(V.[Bill]), 0) FROM PurchaseOfTickets V
		WHERE V.[FlightID] = @FlightID)
	FROM [Tickets]
	WHERE [Tickets].[FlightID] = @FlightID
	RETURN;
END
GO

SELECT * FROM getFlightReport(1)
GO


CREATE OR ALTER FUNCTION getTicketsReportForPeriod (@Start NVARCHAR(10), @End NVARCHAR(10))
RETURNS @Report TABLE (
	[StartDate] NVARCHAR(10) NOT NULL,
	[EndDate] NVARCHAR(10) NOT NULL,
	[Tickets] INT NOT NULL,
	[TicketRevenue] MONEY NOT NULL
	)
AS
BEGIN
	INSERT @Report
	SELECT @Start, @End, COUNT(*), 
		(SELECT ISNULL(SUM(V.[Bill]), 0) FROM PurchaseOfTickets V
		WHERE V.[DateOfPurchase] BETWEEN @Start AND @End)
	FROM [Tickets]
	WHERE [Tickets].[DateOfPurchase] BETWEEN @Start AND @End
	RETURN;
END
GO

SELECT * FROM getTicketsReportForPeriod('2022-10-20', '2022-11-20')
SELECT * FROM PurchaseOfTickets