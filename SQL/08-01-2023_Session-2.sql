-- What are Transactions?
-- Transaction is a group of statements or more than a group of statements.

-- Every transaction either COMMIT or ROLLBACK

-- ACID PROPERTIES :
-- ATOMIC
-- CONSISTENCY
-- ISOLATION
-- DURABILITY

-- In Case of Oracle SQL TRANSACTION FLOW :-
--Begin transaction
insert of 100,000 rows
--Commit transaction
Dropping the table -- DDL
-- Commit the transaction

--------------------------------------------------
-- Explicit Transactions
--------------------------------------------------
START TRANSACTION;
SELECT * FROM tbl_employee WHERE employee_number = 123;

UPDATE tbl_employee set employee_number = 122
WHERE employee_number = 123;

SELECT * FROM tbl_employee WHERE employee_number = 123;

ROLLBACK; -- Rollback complete.

-- DML statements/Transactions are need to be explicitly comiited.
----------------------------------------------------------------
--SAVEPOINTS and ROLLBACK to Savepoints:
----------------------------------------------------------------
/* 
Transaction starts
DML statements

SAVEPOINT 1
DML statements

SAVEPOINT 2
DML statements

ROLLBACK to SAVEPOINT 2;

ROLLBACK to SAVEPOINT 1;

COMMIT;
ROLLBACK;
*/

-----
-- Practical example

SET TRANSACTION NAME 'name of transaction';

SELECT 'Start' as status,employee_number FROM tbl_employee WHERE employee_number = 123;

SAVEPOINT spt_1;

UPDATE tbl_employee set employee_number = 122
WHERE employee_number = 123;

SELECT 'After_spt_1' as Status,employee_number FROM tbl_employee WHERE employee_number IN (122,123);

SAVEPOINT spt_2;

UPDATE tbl_employee set employee_number = 121
WHERE employee_number = 122;

SELECT 'After_spt_2' as Status,employee_number FROM tbl_employee WHERE employee_number IN (121,122,123);

ROLLBACK to spt_2;

SELECT 'Rollback to spt_2' as Status,employee_number FROM tbl_employee WHERE employee_number IN (121,122,123);

ROLLBACK to spt_1;

SELECT 'Rollback to spt_1' as Status,employee_number FROM tbl_employee WHERE employee_number IN (121,122,123);

ROLLBACK
SELECT 'ROLLBACK' AS status,
       employee_number
FROM tbl_employee
WHERE employee_number IN ( 121, 122, 123 );

--------------------------------------------------------------

