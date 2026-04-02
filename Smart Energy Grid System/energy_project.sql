-- STEP 1: CREATE DATABASE
CREATE DATABASE energy_db;
-- STEP 2: USE DATABASE
USE energy_db;

-- Table: Household
-- Stores user/household details
CREATE TABLE Household (
    Household_ID INT PRIMARY KEY,
    Owner_Name VARCHAR(50),
    Address VARCHAR(100)
);

-- Table: SmartMeter
-- Stores installed smart meters linked to households
CREATE TABLE SmartMeter (
    Meter_ID INT PRIMARY KEY,
    Household_ID INT,
    Installation_Date DATE,
    FOREIGN KEY (Household_ID) REFERENCES Household(Household_ID)
);

-- Table: Consumption
-- Stores daily electricity usage
CREATE TABLE Consumption (
    Consumption_ID INT PRIMARY KEY,
    Meter_ID INT,
    Units_Used INT,
    Reading_Date DATE,
    FOREIGN KEY (Meter_ID) REFERENCES SmartMeter(Meter_ID)
);

-- Table: Billing
-- Stores billing information
CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY,
    Household_ID INT,
    Amount DECIMAL(10,2),
    Bill_Date DATE
);
-- ============================================
-- STEP 4: INSERT SAMPLE DATA
-- ============================================
-- Insert households
INSERT INTO Household VALUES
(1,'Rahul','Mumbai'),
(2,'Sneha','Pune'),
(3,'Amit','Delhi');

-- Insert smart meters
INSERT INTO SmartMeter VALUES
(101,1,'2024-01-01'),
(102,2,'2024-01-02'),
(103,3,'2024-01-03');

-- Insert consumption data (daily readings)
INSERT INTO Consumption VALUES
(1,101,120,'2026-04-01'),
(2,101,130,'2026-04-02'),
(3,102,110,'2026-04-01'),
(4,103,150,'2026-04-01');

-- ============================================
-- STEP 5: INDEXING (IMPORTANT FOR PERFORMANCE)
-- ============================================
-- Index on Meter_ID to speed up search queries
CREATE INDEX idx_meter
ON Consumption(Meter_ID);

-- Index on Reading_Date for faster date-based queries
CREATE INDEX idx_date
ON Consumption(Reading_Date);

-- ============================================
-- STEP 6: QUERY OPTIMIZER (EXPLAIN)
-- ============================================
-- Using EXPLAIN to check execution plan of query
EXPLAIN SELECT *
FROM Consumption
WHERE Meter_ID = 101;

-- ============================================
-- STEP 7: DATABASE SIZE CONCEPT
-- ============================================
-- More records can be inserted to simulate large data
-- Example:
-- INSERT INTO Consumption VALUES (...);
-- This shows how database grows with daily smart meter data

-- ============================================
-- STEP 8: SECURITY & AUTHORIZATION
-- ============================================
-- Creating admin user with full privileges
CREATE USER 'admin1'@'localhost'
IDENTIFIED BY 'admin123';

GRANT ALL PRIVILEGES
ON energy_db.*
TO 'admin1'@'localhost';
-- Creating viewer user with limited access
CREATE USER 'viewer'@'localhost'
IDENTIFIED BY 'viewer123';

GRANT SELECT
ON energy_db.*
TO 'viewer'@'localhost';
-- ============================================
-- END OF SQL PROJECT
-- ============================================