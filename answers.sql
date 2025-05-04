-- Step 1: Create the ProductDetail table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 2: Insert values
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 3: Split Products into atomic rows (1NF)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n <= 5
)
SELECT 
    pd.OrderID,
    pd.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', n), ',', -1)) AS Product
FROM 
    ProductDetail pd
JOIN 
    numbers ON n <= 1 + LENGTH(pd.Products) - LENGTH(REPLACE(pd.Products, ',', ''));



     -- STEP 1: Clean up any existing tables
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;

-- STEP 2: Create Orders table (OrderID, CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- STEP 3: Create OrderItems table (OrderID, Product, Quantity)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- STEP 4: Insert data into Orders table (only one row per OrderID)
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- STEP 5: Insert data into OrderItems table (multiple products per order)
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);