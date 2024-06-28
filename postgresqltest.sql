
-- crear tabla basica
CREATE TABLE online_sales_data(
    --TransacctionID es INT para usar los ID del csv como primary key.
    TransactionID INT PRIMARY KEY,
    Date DATE NOT NULL,
    ProductCategory VARCHAR(255) NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    UnitsSold INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    TotalRevenue DECIMAL(10, 2) NOT NULL,
    Region VARCHAR(255) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL
);

-- copiar los datos del csv a la tabla de SQL
COPY online_sales_data(TransactionID, Date, ProductCategory, ProductName, UnitsSold, UnitPrice, TotalRevenue, Region, PaymentMethod)
FROM 'Online Sales Data.csv'
DELIMITER ','
CSV HEADER;


-- query parte 2 tarea 1
SELECT 
    ProductCategory,
    Region,
    SUM(TotalRevenue) AS TotalSales
FROM 
    SalesTransactions
GROUP BY 
    ProductCategory, 
    Region
ORDER BY 
    ProductCategory, 
    Region;

-- optimizar el siguiente query:
SELECT category, SUM(total_price)
FROM sales
WHERE total_price IS NOT NULL
GROUP BY category;

--optimización general: agregar un index a la categoria, asumiendo que no tiene uno.
--hacer esto facilita la agrupación por category y puede mejorar el rendimiento de la operación SUM.
CREATE INDEX id_sales_category ON sales(category);

-- query optimizada 1
SELECT category, SUM(total_price) AS total_sales
FROM sales
GROUP BY category;

--explicacion: asumiendo que el campo de total_price no va a tener nunca nulos el WHERE es redundante

-- query optimizada 2
SELECT category, SUM(COALESCE(total_price, 0)) AS total_sales
FROM sales
GROUP BY category;

-- explicacion: asumiendo que exista la posibilidad de que haya campos nulos,
--usar COALESCE los agrega a la suma como 0, lo cual podría ser mas eficiente en algunos casos.

-- query optimizada 3
WITH filtered_sales AS (
    SELECT category, total_price
    FROM sales
    WHERE total_price IS NOT NULL
)
SELECT category, SUM(total_price)
FROM filtered_sales
GROUP BY category;

-- explicacion: asumiendo que puede haber nulos, usando WITH para filtrar los datos antes de aplicar la función de agregación puede optimizar la ejecución de la consulta.
-- esto depende de la configuración de PostgreSQL, y debería ser validado usando EXPLAIN.