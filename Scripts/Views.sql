USE [KR_DB]
GO

-- 5.5	Створення представлень
CREATE OR ALTER VIEW PurchaseOfTickets
AS SELECT F.[FlightID], T.[TicketID], T.[Comfort], T.[DateOfPurchase],
	ISNULL(F.[EconomyPrice], 0) * (1 - C.[Discount]) Bill
FROM [Flights] F, [Tickets] T, [Clients] C
WHERE T.[FlightID] = F.[FlightID] AND 
	LOWER(T.[Comfort]) = 'економ' AND T.[ClientID] = C.[ClientID]
UNION
SELECT F.[FlightID], T.[TicketID], T.[Comfort], T.[DateOfPurchase], 
	ISNULL(F.[BusinessPrice], 0) * (1 - C.[Discount]) Bill
FROM [Flights] F, [Tickets] T, [Clients] C
WHERE T.[FlightID] = F.[FlightID] AND 
	LOWER(T.[Comfort]) = 'бізнес' AND T.[ClientID] = C.[ClientID]
GO

SELECT * FROM PurchaseOfTickets
GO


CREATE OR ALTER VIEW TicketsEconomyClass
AS SELECT F.[FlightID], COUNT(T.TicketID) BookedTickets,
	MAX(M.[NumberOfEconomySeats]) - COUNT(T.TicketID) AvailableTickets
FROM [Flights] F
LEFT JOIN [Tickets] T
ON F.[FlightID] = T.[FlightID] AND T.[Comfort] = 'економ'
LEFT JOIN [Planes] P
ON F.[PlaneID] = P.[PlaneID]
INNER JOIN [AircraftModels] M
ON P.[ModelID] = M.[ModelID] AND M.[NumberOfEconomySeats] > 0
GROUP BY F.[FlightID]
GO

SELECT * FROM TicketsEconomyClass
GO


CREATE OR ALTER VIEW TicketsBusinessClass
AS SELECT F.[FlightID], COUNT(T.TicketID) BookedTickets, 
	MAX(M.[NumberOfBusinessSeats]) - COUNT(T.TicketID) AvailableTickets
FROM [Flights] F
LEFT JOIN [Tickets] T
ON F.[FlightID] = T.[FlightID] AND T.[Comfort] = 'бізнес'
LEFT JOIN [Planes] P
ON F.[PlaneID] = P.[PlaneID]
INNER JOIN [AircraftModels] M
ON P.[ModelID] = M.[ModelID] AND M.[NumberOfBusinessSeats] > 0
GROUP BY F.[FlightID]
GO

SELECT * FROM TicketsBusinessClass
GO