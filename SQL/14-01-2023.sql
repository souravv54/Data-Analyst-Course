-- Use ampersand substitution to restrict and sort the output as runtime

-- "&" Substitution

-- one select statement
SELECT employee_number,
       employee_first_name,
       employee_middle_name,
       employee_last_name,
       employee_government_id,
       date_of_birth,
       department
FROM tbl_employee
ORDER BY employee_number;

-- using & substitution
SELECT employee_number,
       employee_first_name,
       employee_middle_name,
       employee_last_name,
       employee_government_id,
       date_of_birth,
       department
FROM tbl_employee
ORDER BY &how_do_you_wnant_me_to_order_by;

--Define and Undefine the variable and substitute

DEFINE L_number = 45;

SELECT &l_number AS employee_number
FROM dual;

UNDEFINE L_number;

---------------
define L_NAME = 'SMITH';

define;

SELECT length('&L_NAME') AS myname
FROM dual;

undefine L_NAME;

-------------------
-- usnig substitution variable in sorting and filtering 

SELECT employee_number,
       employee_first_name,
       employee_middle_name,
       employee_last_name,
       employee_government_id,
       date_of_birth,
       department
FROM tbl_employee
WHERE upper(employee_first_name) LIKE '%&First_Name_Needed%'
ORDER BY &how_do_you_wnant_me_to_order_by;

----------------------
-- CASE  function (IF else statement in SQL)

DEFINE myoption = 'Option A';

SELECT CASE
    WHEN '&myoption' = 'Option A' THEN
        'First Option'
    WHEN '&myoption' = 'Option B' THEN
        'Second Option'
    ELSE
        'No Option'
       END AS myoptions
FROM dual;

-- ELSE statement is not compulsary here and if condition fall under ELSE then it will give (null) value.

------- CASE FUNCTION over table tbl_employee
SELECT employee_government_id,
       employee_number,
       CASE substr(employee_government_id, 1, 1)
           WHEN 'A' THEN
               employee_first_name
           WHEN 'B' THEN
               employee_last_name
           ELSE
               'Neither Letter'
       END
       || '.' AS mycol
FROM tbl_employee;

----- CASE Using substitution
ACCEPT myoption PROMPT ' What option are you going to choose?';

SELECT CASE
    WHEN '&myoption' = 'Option A' THEN
        'First Option'
    WHEN '&myoption' = 'Option B' THEN
        'Second Option'
    ELSE
        'No Option'
       END AS myoptions
FROM dual;

---------------------------------------------------
-- NVL and NVL2 and coalesce ( NULL FUNCTIONS )
define;

UNDEFINE &MYOPTION;

SELECT CASE
           WHEN '&myOption1' IS NOT NULL THEN
               'IS NOT NULL'
           ELSE
               'IS NULL'
       END AS myanswer
FROM dual;

--- How to handle null values using NVL , it takes 2 arguements
-- SYNTAX: -  NVL (value is null, then print this value)

SELECT nvl('&myOption1', 'NO Option') AS myoptions
FROM dual;

--NVL 2 Takes 3 aruguement
--SYNTX : - NVL2(input, IF NOT NULL, IF NULL)

SELECT nvl2('&myfirstoption', 'IS NOT NULL', 'IS NULL') AS myoptions
FROM dual;

-- Coalesce can take n number of arguements
-- SNYTAX:- COALESCE(input1, input2, input3.....,'IF all are NULL') 

SELECT coalesce('&myfirstoption', '&mysecondoption', 'NO OPTION') AS myoptions
FROM dual;

-- Differnece between NVL and COALESCE is COALESCE required same datatype over functions.

SELECT coalesce('ABC', 1)
FROM dual; -- give errror due to inconsistent data types
SELECT nvl('ABC', 1)
FROM dual; -- NO ERROR

SELECT nvl(NULL, NULL) AS myanswer
FROM dual; -- it will also work.
------------------------------------------------------