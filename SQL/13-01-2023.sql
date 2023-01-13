--------------------
-- COMBINING SETS --
--------------------

-- UNION and UNION ALL
-- Rules : 
-- 1. Same set of columns in all tables
-- 2. Same data type of every matching columns

SELECT CAST('hi' AS CHAR(5)) -- || '.'

 AS greeting
FROM dual
UNION
SELECT CAST('hello there' AS CHAR(11)) AS greetingnow
FROM dual;

----- 2nd example :
SELECT CAST('hi' AS CHAR(5)) -- || '.'
 AS greeting
FROM dual
UNION ALL
SELECT CAST('hello there' AS CHAR(11)) AS greetingnow
FROM dual
UNION ALL
SELECT CAST('bonjour' AS CHAR(11))
FROM dual
UNION ALL
SELECT CAST('hi' AS CHAR(11)) --||'.'
FROM dual;

-----------------------------------------
--TO remove duplicates remove 'ALL' from UNION

SELECT CAST('hi' AS CHAR(11)) -- || '.'

 AS greeting
FROM dual
UNION
SELECT CAST('hello there' AS CHAR(11)) AS greetingnow
FROM dual
UNION
SELECT CAST('bonjour' AS CHAR(11))
FROM dual
UNION
SELECT CAST('hi' AS CHAR(11)) --||'.'
FROM dual; -- Return 3  rows

--- UNION BETWEEN DATE and TIMESTAMP

SELECT CAST(TO_DATE('2021-01-01', 'YYYY-MM-DD') AS DATE) AS mycolumn
FROM dual
UNION
SELECT CAST(TO_DATE('2022-01-01', 'YYYY-MM-DD') AS TIMESTAMP)
FROM dual;

-- UNION between string and Number

SELECT '4'
FROM dual
UNION
SELECT 4
FROM dual; -- ERROR as they are not having same datatype

--------------------------------------------------------------------
-- INTERSECT and MINUS

-- CREATE NEW TABLE : TBL_TRANSACTION_NEW

CREATE TABLE tbl_transaction_new (
    "AMOUNT"              NUMBER(15, 2),
    "DATE_OF_TRANSACTION" DATE,
    "EMPLOYEE_NUMBER"     NUMBER(4, 0) DEFAULT 124,
    "DATE_OF_ENTRY"       TIMESTAMP(6) DEFAULT ON NULL sysdate,
    "SHOULD_I_DELETE"     NUMBER(1, 0)
);
    
-- INSERT THE RECORDS :

INSERT INTO tbl_transaction_new
    SELECT amount,
           date_of_transaction,
           employee_number,
           date_of_entry,
           mod(ROWNUM, 3) AS should_i_delete
    FROM tbl_transaction;

--Check the data
SELECT *
FROM tbl_transaction_new;

--Delete few records
DELETE FROM tbl_transaction_new
WHERE tbl_transaction_new.should_i_delete = 1; -- 834 rows deleted

--Update the records :

UPDATE tbl_transaction_new
SET
    date_of_transaction = date_of_transaction + 1
WHERE tbl_transaction_new.should_i_delete = 2; -- 834 rows updated

-- SET OPERATION : UNION ALL
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction -- 2501 rows
UNION ALL
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction_new; -- 1667 rows, 834 changed rows and 834 unchanged rows

--TOTAL -- 4168 rows
-- if We changed union all to union then it will give 2501 + 834 Changed rows.

SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction
UNION
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction_new; -- 3335 rows

-- Intersect will fetch only those which are unchanged or exactly matched.

SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction
INTERSECT
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction_new; -- 833 Rows


-- MINUS will take the first query and remove all data which are present in 2nd query
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction -- 1st query
MINUS
SELECT amount,
       date_of_transaction,
       employee_number
FROM tbl_transaction_new; -- 2nd query ,1668 Rows

------------------------------------------------------------------