-- VIEWS-- It is a virtual table created by using multiple table
-- Uses of Views :
-- Restrict the users from rows and columns
-- Join multple tables which look like a single table

-- Create a view
CREATE VIEW view_by_department AS
    SELECT d.department,
           t.employee_number,
           t.date_of_transaction,
           t.amount AS total_amount
    FROM tbl_department  d
    LEFT JOIN tbl_employee    e ON d.department = e.department
    LEFT JOIN tbl_transaction t ON t.employee_number = e.employee_number
    WHERE t.employee_number BETWEEN 120 AND 139
    ORDER BY d.department,
             t.employee_number;

--Check the view data
SELECT *
FROM view_by_department;

-- Create an another view

CREATE VIEW view_summary AS
    SELECT d.department,
           t.employee_number AS empnum,
           SUM(t.amount)     AS totalamount
    FROM tbl_department  d
    LEFT JOIN tbl_employee    e ON d.department = e.department
    LEFT JOIN tbl_transaction t ON t.employee_number = e.employee_number
    GROUP BY d.department,
             t.employee_number
    ORDER BY d.department,
             t.employee_number;

--Check the view data
SELECT *
FROM view_summary;

--------------------------------------------------------------------------
-- Alteration on views
-- We have to use the keyword CREATE OR REPLACE

CREATE OR REPLACE VIEW view_by_department AS
    SELECT d.department,
           t.employee_number,
           t.date_of_transaction,
           t.amount     AS total_amount,
           t.amount * 2 AS double_amount -- Alter check point
    FROM tbl_department  d
    LEFT JOIN tbl_employee    e ON d.department = e.department
    LEFT JOIN tbl_transaction t ON t.employee_number = e.employee_number
    WHERE t.employee_number BETWEEN 120 AND 139
    ORDER BY d.department,
             t.employee_number;
             
--Check the view data
SELECT *
FROM view_by_department;

--Drop the view
DROP VIEW view_by_department;

----------------------------------------------------------------------
--Adding new rows to views(DML on views)

INSERT INTO view_by_department (
    employee_number,
    date_of_transaction,
    total_amount
) VALUES (
    132,
    '07-Jul-2015',
    999.99
); -- ERROR : "cannot modify a column which maps to a non key-preserved table"

--TO rectify this,
ALTER TABLE tbl_department ADD CONSTRAINT pk_tbl_deartment PRIMARY KEY ( department );

-- Now inserting 
INSERT INTO view_by_department (
    employee_number,
    date_of_transaction,
    total_amount
) VALUES (
    132,
    '07-Jul-2015',
    999.99
); -- Executed without any error

--NOTE : We inserting the record in view for single table and single transaction.

SELECT *
FROM view_by_department; -- recorded in view
SELECT *
FROM tbl_transaction
WHERE employee_number = 132;  -- Records also present in master table

ROLLBACK;

-- Inserting rows into multple table of view
INSERT INTO view_by_department (
    department,
    employee_number,
    date_of_transaction,
    total_amount
) VALUES (
    'Customer Relations',
    132,
    '07-Jul-2015',
    999.99
); -- ERROR

--CASE 2 : UPDATE The Records

SELECT *
FROM view_by_department
ORDER BY employee_number,
         date_of_transaction;

SELECT *
FROM tbl_transaction
WHERE employee_number IN ( 132, 142 );

--Update query:
UPDATE view_by_department
SET
    employee_number = 142
WHERE employee_number = 132; -- 5 rows updated.

--Data check
SELECT *
FROM view_by_department
ORDER BY employee_number,
         date_of_transaction;

SELECT *
FROM tbl_transaction
WHERE employee_number IN ( 132, 142 );

ROLLBACK;

-- ALTER the view to read only mode :

CREATE OR REPLACE VIEW view_by_department AS
    SELECT d.department,
           t.employee_number,
           t.date_of_transaction,
           t.amount AS total_amount
    FROM tbl_department  d
    LEFT JOIN tbl_employee    e ON d.department = e.department
    LEFT JOIN tbl_transaction t ON t.employee_number = e.employee_number
    WHERE t.employee_number BETWEEN 120 AND 139
    ORDER BY d.department,
             t.employee_number
WITH READ ONLY;
             
-- AFTER THAT DML OPERATION IS NOT POSSIBLE

INSERT INTO view_by_department (
    employee_number,
    date_of_transaction,
    total_amount
) VALUES (
    132,
    '07-Jul-2015',
    999.99
); -- ERR : cannot perform a DML operation on a read-only view

-- Need to add constraint :

CREATE OR REPLACE VIEW view_by_department AS
    SELECT d.department,
           t.employee_number,
           t.date_of_transaction,
           t.amount AS total_amount
    FROM tbl_department  d
    LEFT JOIN tbl_employee    e ON d.department = e.department
    LEFT JOIN tbl_transaction t ON t.employee_number = e.employee_number
    WHERE t.employee_number BETWEEN 120 AND 139
WITH CHECK OPTION CONSTRAINT constraint_view_by_deparment;
             
-- Updating data out of bound :
UPDATE view_by_department
SET
    employee_number = 142
WHERE employee_number = 132; -- ERR : "virtual column not allowed here"

ROLLBACK;

--------------------------------------------------------------------