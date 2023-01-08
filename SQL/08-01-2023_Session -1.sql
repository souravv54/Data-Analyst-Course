-- Updating Data

Select * from TBL_EMPLOYEE WHERE employee_number = 194;
Select * from tbl_transaction where employee_number = 3;
Select * from tbl_transaction Where employee_number = 194;

-- UPDATE STATEMENT
UPDATE TBL_TRANSACTION set
employee_number = 194 
WHERE
    employee_number = 3;

-----------------------------------------

UPDATE TBL_TRANSACTION set
employee_number = 194 
WHERE
    employee_number IN (3,5,7,9)
AND trunc(date_of_transaction) > '01-JAN-1986';

---------------------------------------


