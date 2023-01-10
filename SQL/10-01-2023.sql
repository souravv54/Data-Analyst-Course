-- DEFAULT CONSTRAINT
-- ADDING one column in Transaction table

ALTER TABLE tbl_transaction ADD date_of_entry TIMESTAMP(6) DEFAULT sysdate;

SELECT *
FROM tbl_transaction;

UPDATE tbl_transaction
SET
    date_of_entry = NULL;

DELETE FROM tbl_transaction
WHERE employee_number < 3;

SELECT *
FROM tbl_transaction;

ROLLBACK;

INSERT INTO tbl_transaction (
    amount,
    tbl_transaction.date_of_transaction,
    tbl_transaction.employee_number
) VALUES (
    1,
    '01-jan-2021',
    1
);

SELECT *
FROM tbl_transaction
ORDER BY date_of_entry DESC;

----------------------------------------------------
-- CHECK CONSTRAINT : Restrict the records on rules

ALTER TABLE tbl_transaction
    ADD CONSTRAINT chkamt CHECK ( amount > - 1000 AND amount < 1000 );

INSERT INTO tbl_transaction (
    tbl_transaction.amount,
    tbl_transaction.date_of_transaction,
    tbl_transaction.employee_number
) VALUES (
    1010,
    '01-JAN-2014',
    1
);

-- CHECK CONSTRAINT VAIDATED FROM ABOVE QUERY

------ANOTHER CHECK CONSTRAINT

ALTER TABLE tbl_employee
    ADD CONSTRAINT chkmiddlenames CHECK ( replace(employee_middle_name, '.', '') = employee_middle_name OR employee_middle_name IS NULL
    ) ENABLE NOVALIDATE; -- this line will help to create the constraint without validation of existing data.
    
----------------------------------------------------------------
--PRIMARY KEY CONSTRAINT : Uniquely identified a row with the help of primary key(CANNOT BE NULL)

SELECT employee_number,
       employee_first_name,
       employee_middle_name,
       employee_last_name,
       employee_government_id,
       date_of_birth,
       department
FROM tbl_employee;

-- ADD PRIMARY KEY

ALTER TABLE tbl_employee ADD CONSTRAINT pk_tbl_employee PRIMARY KEY ( employee_number );

INSERT INTO tbl_employee VALUES (
    2004,
    'Firstname',
    'Middlename',
    'lastname',
    'AB12345FI',
    '01-JAN-2014',
    'Accounts'
);  --- 2nd time it will throw error saying that constraint error.

select * from tbl_employee where employee_number = 2004;
---------------------------------------------------------------
