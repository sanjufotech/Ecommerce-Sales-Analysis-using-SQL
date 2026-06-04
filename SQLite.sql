CREATE TABLE ecommerce (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TEXT,
    UnitPrice REAL,
    CustomerID INTEGER,
    Country TEXT
);

SELECT * 
FROM ecommerce
LIMIT 10;

SELECT 
    InvoiceNo,
    StockCode,
    Quantity,
    UnitPrice,
    (Quantity * UnitPrice) AS TotalPrice
FROM ecommerce;


DELETE FROM ecommerce
WHERE CustomerID IS NULL;

SELECT COUNT(*)
FROM ecommerce;

SELECT COUNT(*) AS total_transactions
FROM ecommerce;

SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM ecommerce;

SELECT DISTINCT Country
FROM ecommerce
ORDER BY Country;

SELECT
SUM(Quantity * UnitPrice) AS total_revenue
FROM ecommerce;

SELECT
Description,
SUM(Quantity) AS total_quantity
FROM ecommerce
GROUP BY Description
ORDER BY total_quantity DESC
LIMIT 10;

SELECT
Description,
ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM ecommerce
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

SELECT
CustomerID,
ROUND(SUM(Quantity * UnitPrice),2) AS spending
FROM ecommerce
GROUP BY CustomerID
ORDER BY spending DESC
LIMIT 10;

SELECT
Country,
ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM ecommerce
GROUP BY Country
ORDER BY revenue DESC;

SELECT
    SUBSTR(InvoiceDate, 4, 2) AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM ecommerce
GROUP BY Month
ORDER BY 1;

SELECT
MIN(UnitPrice) AS minimum_price,
MAX(UnitPrice) AS maximum_price,
AVG(UnitPrice) AS average_price
FROM ecommerce;

SELECT *
FROM
(
    SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS spending
    FROM ecommerce
    GROUP BY CustomerID
)
WHERE spending >
(
    SELECT AVG(total_spending)
    FROM
    (
        SELECT
        SUM(Quantity * UnitPrice) AS total_spending
        FROM ecommerce
        GROUP BY CustomerID
    )
);

CREATE VIEW customer_revenue AS

SELECT
CustomerID,
ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM ecommerce
GROUP BY CustomerID;

SELECT *
FROM customer_revenue
LIMIT 10;

CREATE INDEX idx_customer
ON ecommerce(CustomerID);

CREATE INDEX idx_country
ON ecommerce(Country);

SELECT
Country,
ROUND(SUM(Quantity * UnitPrice),2) AS revenue
FROM ecommerce
GROUP BY Country
ORDER BY revenue DESC
LIMIT 5;

SELECT
Description,
SUM(Quantity) AS quantity_sold
FROM ecommerce
GROUP BY Description
ORDER BY quantity_sold DESC
LIMIT 1;

SELECT
CustomerID,
COUNT(DISTINCT InvoiceNo) AS orders
FROM ecommerce
GROUP BY CustomerID
HAVING orders > 5
ORDER BY orders DESC;


