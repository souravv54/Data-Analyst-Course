----------------------------
-- MERGE STATEMENT
----------------------------
-- merge statement will help in either updator/insert OR delete the data to the situation accordingly.
--if data get matched it will perform update or delete operation
-- if data didn't get matched then it will perform insert operation.

-----------------------------
-- Lets Build a MERGE statement
-- target table : tbl_transaction
-- source table : tbl_transaction_new

MERGE INTO tbl_transaction t
USING tbl_transaction_new s ON ( t.employee_number = s.employee_number AND t.date_of_transaction = s.date_of_transaction )
WHEN MATCHED THEN UPDATE
SET amount = t.amount + s.amount
WHEN NOT MATCHED THEN
INSERT (
    amount,
    date_of_transaction,
    employee_number )
VALUES
    ( s.amount,
      s.date_of_transaction,
      s.employee_number ); -- ERR : ORA-02290: check constraint (SYS.CHKAMT) violated
      
--Try to recitfy the errors by expanding the merge statment :

-- make a list of employees who present in tansaction new table but not in employee table

select distinct T.employee_number
from tbl_transaction_new T
left join tbl_employee E
ON T.employee_number = E.employee_number
Where E.employee_number is NULL; -- 93 Records

-- NOW delete those rows whose employee number listed from above query.

DELETE FROM tbl_transaction_new
WHERE employee_number IN (
    SELECT DISTINCT t.employee_number
    FROM tbl_transaction_new t
    LEFT JOIN tbl_employee        e ON t.employee_number = e.employee_number
    WHERE e.employee_number IS NULL
); -- 183 rows deleted.

-- Check the data again by running the above select query. -- 0 Rows return , All good!!

-- NOW again run the Merge statement.

MERGE INTO tbl_transaction t
USING tbl_transaction_new s ON ( t.employee_number = s.employee_number AND t.date_of_transaction = s.date_of_transaction )
WHEN MATCHED THEN UPDATE
SET amount = t.amount + s.amount
WHEN NOT MATCHED THEN
INSERT (
    amount,
    DATE_OF_TRANSACTION,
    employee_number )
VALUES
    ( s.amount,
      s.DATE_OF_TRANSACTION,
      s.employee_number ); -- again fall with below errors : 

--ORA-02290: check constraint (SYS.CHKAMT) violated
ALTER TABLE tbl_transaction DISABLE CONSTRAINT chkamt;

--ORA-30926: unable to get a stable set of rows in the source tables
-- We have to remove duplicates here
select employee_number,Date_of_transaction,count(*)
from tbl_transaction_new
group by employee_number , date_of_transaction
having count(*)>1;
  
delete from tbl_transaction_new where employee_number in(select employee_number
from tbl_transaction_new
group by employee_number , date_of_transaction
having count(*)>1)

-- Try to execute the MERGE STATEMENT now :

MERGE INTO tbl_transaction t
USING tbl_transaction_new s ON ( t.employee_number = s.employee_number AND t.date_of_transaction = s.date_of_transaction )
WHEN MATCHED THEN UPDATE
SET amount = t.amount + s.amount
WHEN NOT MATCHED THEN
INSERT (
    amount,
    DATE_OF_TRANSACTION,
    employee_number )
VALUES
    ( s.amount,
      s.DATE_OF_TRANSACTION,
      s.employee_number ); -- 1480 rows merged
      
-- Check the data
select * from tbl_transaction_new where employee_number = 245;
select * from tbl_transaction where employee_number = 245;

Rollback;

-------