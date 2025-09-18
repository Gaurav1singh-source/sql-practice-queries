-- Create the property table
CREATE TABLE property (
    property_id INT PRIMARY KEY,
    property_name VARCHAR(100),
    no_of_floors INT,
    no_of_flats INT,
    sqft_area DECIMAL(10,2)
);

-- Insert initial data
INSERT INTO property VALUES
(1, 'Shantinketan', 4, 80, 600.67),
(2, 'Neel Sidhi', 7, 120, 1000.25),
(3, 'Adhiraj', 3, 60, 650.67),
(4, 'Shelter Complex', 10, 115, 1200.67),
(5, 'Bhoomi Heights', 18, 200, 1500.34),
(6, 'Goodwill', 7, 110, 800);

select * from property

--Q1. Insert a row and commit it

INSERT INTO property VALUES (7, 'Rekhi Residency', 15, 130, 1600);
COMMIT;

--Q2. Update property and commit

UPDATE property SET no_of_flats = 65 WHERE property_name = 'Adhiraj';
COMMIT;

--Q3. Insert rows and rollback

INSERT INTO property VALUES (8, 'Sunrise Apartments', 5, 40, 700);
INSERT INTO property VALUES (9, 'Ocean View', 12, 90, 1300);
INSERT INTO property VALUES (10, 'Mountain Peak', 6, 50, 850);
ROLLBACK;

--Q4. Delete a row and rollback

DELETE FROM property WHERE property_id = 6;
ROLLBACK;

--Q5. Insert rows, create savepoint, insert another row, then rollback to savepoint

BEGIN; -- Start transaction block
-- Insert rows
INSERT INTO property VALUES (11, 'Ambika heights', 8, 57, 1000);
INSERT INTO property VALUES (12, 'Amnol plaza', 7, 42, 900);
INSERT INTO property VALUES (13, 'Satyam heights', 10, 100, 1100);

-- Create savepoint
SAVEPOINT after_insert;

-- Insert another row
INSERT INTO property VALUES (14, 'New Property', 5, 30, 600);

-- Rollback to savepoint
ROLLBACK TO after_insert;

COMMIT; -- End transaction

--Q6. Delete records with floors >= 10, create savepoint, insert row, then rollback

BEGIN; -- Start transaction block
-- Delete records with floors >= 10
DELETE FROM property WHERE no_of_floors >= 10;

-- Create savepoint
SAVEPOINT after_delete;

-- Insert another row
INSERT INTO property VALUES (14, 'Nilgiri heights', 10, 80, 1400);

-- Rollback to savepoint
ROLLBACK TO after_delete;

COMMIT; -- End transaction


select * from property