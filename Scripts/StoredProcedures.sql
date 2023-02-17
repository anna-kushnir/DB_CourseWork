USE [KR_DB]
GO

-- 5.2	Створення збережених процедур
CREATE OR ALTER PROCEDURE countIncome @Income MONEY OUTPUT
AS
BEGIN
	SELECT @Income = SUM([Bill]) 
	FROM PurchaseOfTickets;
	RETURN;
END
GO

DECLARE @Result MONEY;
EXEC countIncome @Income = @Result OUTPUT;
PRINT 'The income is: ' + CONVERT(varchar(10), @Result);
GO


CREATE OR ALTER PROCEDURE countExpenses @Expenses MONEY OUTPUT
AS
BEGIN
	SELECT @Expenses = ROUND(SUM(P.[Salary] * S.[Coefficient]), 2)
			FROM [SalaryPayment] S, [Personnel] E, [Positions] P
			WHERE S.[EmployeeID] = E.[EmployeeID] AND E.[PositionID] = P.[PositionID]
	RETURN;
END
GO

DECLARE @Result MONEY;
EXEC countExpenses @Expenses = @Result OUTPUT;
PRINT 'The expenses are: ' + CONVERT(varchar(10), @Result);
GO


CREATE OR ALTER PROCEDURE whetherTurnedIntoProfit
AS
BEGIN
	DECLARE @Income MONEY, @Expenses MONEY;
	EXEC countIncome @Income = @Income OUTPUT;
	EXEC countExpenses @Expenses = @Expenses OUTPUT;
	IF @Income > @Expenses
		PRINT 'Congratulations, your airport is profitable!'
	ELSE
		PRINT 'Unfortunately, your airport has not yet turned a profit...'
END
GO

EXEC whetherTurnedIntoProfit