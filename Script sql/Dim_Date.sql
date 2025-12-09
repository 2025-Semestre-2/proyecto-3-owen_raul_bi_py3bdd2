USE BikeStore_DW;
GO

---------------------------------------------------------
-- LIMPIAR DIMDATE 
---------------------------------------------------------
DELETE FROM dbo.DimDate;
GO

---------------------------------------------------------
-- CREAR RANGO DE FECHAS
---------------------------------------------------------
DECLARE @StartDate DATE = '2015-01-01';
DECLARE @EndDate   DATE = '2030-12-31';

;WITH DateRange AS (
    SELECT @StartDate AS FullDate
    UNION ALL
    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateRange
    WHERE DATEADD(DAY, 1, FullDate) <= @EndDate
)
INSERT INTO dbo.DimDate (
    DateKey,
    FullDate,
    Year,
    Quarter,
    Month,
    Day,
    Week,
    MonthName
)
SELECT
    CONVERT(INT, FORMAT(FullDate, 'yyyyMMdd')) AS DateKey,
    FullDate,
    YEAR(FullDate) AS Year,
    DATEPART(QUARTER, FullDate) AS Quarter,
    MONTH(FullDate) AS Month,
    DAY(FullDate) AS Day,
    DATEPART(WEEK, FullDate) AS Week,
    DATENAME(MONTH, FullDate) AS MonthName
FROM DateRange
OPTION (MAXRECURSION 0);

---------------------------------------------------------
-- VALIDAR
---------------------------------------------------------
SELECT * FROM dbo.DimDate 

SELECT COUNT(*) AS TotalFechas FROM dbo.DimDate;
GO