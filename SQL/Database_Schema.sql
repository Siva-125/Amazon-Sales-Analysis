
-- Created Table to store the Data
CREATE TABLE IF NOT EXISTS Amazon_Sales(
	Order_ID VARCHAR(30),
	Date DATE,
	Month VARCHAR(10),
	Status	VARCHAR(20),
	Fulfilment VARCHAR(10),
	Sales_Channel VARCHAR(10),
	ship_service_level VARCHAR(10),
	Category VARCHAR(30),
	Size VARCHAR(5),
	Courier_Status VARCHAR(15),
	Qty	REAL,
	Amount	REAL,
	ship_city VARCHAR,
	ship_state	VARCHAR,
	B2B	BOOLEAN,
	fulfilled_by VARCHAR(10)
);

-- The Table is created and imported the data from csv file.
SELECT * FROM Amazon_Sales;

-- Total No. of Records imported
SELECT COUNT(*) FROM Amazon_Sales;
-- 126545 Records imported successfully.