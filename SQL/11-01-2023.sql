---- Foreign Key constraint
-- It is counter part of parimary key
-- Foreign key is the child key of parent table primary key

------ IN PRACTICE
ALTER TABLE tbl_transaction
    ADD CONSTRAINT fk_tbl_transaction_employee_number FOREIGN KEY ( employee_number )
        REFERENCES tbl_employee ( employee_number )
    ENABLE NOVALIDATE;

SELECT t.*
FROM tbl_transaction t
LEFT JOIN tbl_employee    e ON t.employee_number = e.employee_number
WHERE e.employee_number IS NULL;

SELECT *
FROM tbl_transaction
WHERE employee_number = 123;

SELECT *
FROM tbl_employee
WHERE employee_number = 123;

--try to delete the records
DELETE tbl_employee
WHERE employee_number = 123; --ORA-02292: integrity constraint (SYS.FK_TBL_TRANSACTION_EMPLOYEE_NUMBER) violated - child record found

-- DROP constraint
ALTER TABLE tbl_transaction DROP CONSTRAINT fk_tbl_transaction_employee_number;

ALTER TABLE tbl_transaction
    ADD CONSTRAINT fk_tbl_transaction_employee_number FOREIGN KEY ( employee_number )
        REFERENCES tbl_employee ( employee_number )
            ON DELETE CASCADE
    ENABLE NOVALIDATE;

--try to delete the records
DELETE tbl_employee
WHERE employee_number = 123;


--CHECK
SELECT *
FROM tbl_transaction
WHERE employee_number = 123;

SELECT *
FROM tbl_employee
WHERE employee_number = 123;

ROLLBACK;

------
-- DROP constraint and create with delete set to NULL
ALTER TABLE tbl_transaction DROP CONSTRAINT fk_tbl_transaction_employee_number;

ALTER TABLE tbl_transaction
    ADD CONSTRAINT fk_tbl_transaction_employee_number FOREIGN KEY ( employee_number )
        REFERENCES tbl_employee ( employee_number )
            --ON DELETE CASCADE
            ON DELETE SET NULL
    ENABLE NOVALIDATE;
    
--try to delete the records
DELETE tbl_employee
WHERE employee_number = 123; --ORA-01407: cannot update ("SYS"."TBL_TRANSACTION"."EMPLOYEE_NUMBER") to NULL

ALTER TABLE tbl_transaction MODIFY
    employee_number DECIMAL(4, 0) NULL;

--try to delete the records
DELETE tbl_employee
WHERE employee_number = 123;

--CHECK
SELECT *
FROM tbl_transaction
WHERE employee_number IS NULL; -- 4 Rows

SELECT *
FROM tbl_employee
WHERE employee_number = 123;  -- 0 Rows

ROLLBACK;
------------------------------------------------------
