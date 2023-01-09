-------------------------------
-- DATA INTEGRITY
-------------------------------

-- What are constraints?
-- A rule that restricts the value of the database
-- TYPES :
-- NOT NULL
-- PRIMARY
-- UNIQUE
-- FOREIGN
-- CHECK

---------------------------------------------
--UNIQUE constraint: It will restrict to add duplicate values in table (CAN BE NULL)

ALTER TABLE tbl_employee ADD CONSTRAINT unq_government_id UNIQUE ( employee_government_id );  --gives errpr because duplicate records present

-- CHECK for duplicate values
SELECT EMPLOYEE_GOVERNMENT_ID, count(EMPLOYEE_GOVERNMENT_ID)
from TBL_EMPLOYEE
group by EMPLOYEE_GOVERNMENT_ID
having count(EMPLOYEE_GOVERNMENT_ID)>1;

--Check all the records
select * from tbl_employee
where employee_government_id in ('HI108464V','QK881576I');

-- DELETE THE DUPLICATE RECORDS
DELETE FROM tbl_employee where employee_number <3;

--VALIDATE
SELECT EMPLOYEE_GOVERNMENT_ID, count(EMPLOYEE_GOVERNMENT_ID)
from TBL_EMPLOYEE
group by EMPLOYEE_GOVERNMENT_ID
having count(EMPLOYEE_GOVERNMENT_ID)>1;

Select * from tbl_employee where tbl_employee.employee_number IN (131,132);

-- Delete duplicates
delete from tbl_employee where tbl_employee.employee_number IN (131,132)

Insert into tbl_employee (EMPLOYEE_NUMBER,EMPLOYEE_FIRST_NAME,EMPLOYEE_MIDDLE_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_GOVERNMENT_ID,DATE_OF_BIRTH,DEPARTMENT) values (131,'Jossef','H','Wright','HI108464V ',to_date('04-04-80','DD-MM-RR'),'Customer Relations');
Insert into tbl_employee (EMPLOYEE_NUMBER,EMPLOYEE_FIRST_NAME,EMPLOYEE_MIDDLE_NAME,EMPLOYEE_LAST_NAME,EMPLOYEE_GOVERNMENT_ID,DATE_OF_BIRTH,DEPARTMENT) values (132,'Dylan','A','Word','QK881576I ',to_date('24-03-71','DD-MM-RR'),'Customer Relations');

COMMIT

----------------
--VALIDATE
SELECT EMPLOYEE_GOVERNMENT_ID, count(EMPLOYEE_GOVERNMENT_ID)
from TBL_EMPLOYEE
group by EMPLOYEE_GOVERNMENT_ID
having count(EMPLOYEE_GOVERNMENT_ID)>1; -- 0 Rows

--ADDING CONTRAINT:
ALTER TABLE tbl_employee ADD CONSTRAINT unq_government_id UNIQUE ( employee_government_id );

ALTER TABLE tbl_transaction ADD CONSTRAINT unqtransaction UNIQUE (AMOUNT, DATE_OF_TRANSACTION,EMPLOYEE_NUMBER);

-- TEMPORARY Disable the constraint
Alter table tbl_transaction disable constraint unqtransaction;

-- Enable it again.
Alter table tbl_transaction disable constraint unqtransaction;

---------------------------------------

