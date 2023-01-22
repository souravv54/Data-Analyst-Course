--------------------------------------
-- CORRELATED SUB-QUERIES
--------------------------------------

SELECT employee_number,
       employee_first_name,
       employee_last_name,
       (
           SELECT COUNT(*)
           FROM tbl_transaction t
           WHERE t.employee_number = e.employee_number  
       ) number_of_transactions,
       (
           SELECT SUM(Amount)
           FROM tbl_transaction t
           WHERE t.employee_number = e.employee_number  
       ) value_of_transactions
FROM tbl_employee e
WHERE upper(e.employee_last_name) LIKE 'Y%';


SELECT T.*
FROM tbl_transaction T
WHERE exists(Select employee_number from tbl_employee E WHERE UPPER(employee_last_name) like 'Y%' AND
T.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER)
ORDER BY EMPLOYEE_NUMBER;

-- UDPATE THE AMOUNT TO HALF for above employees

UPDATE TBL_TRANSACTION T
SET AMOUNT = AMOUNT/2
WHERE exists(Select employee_number from tbl_employee E WHERE UPPER(employee_last_name) like 'Y%' AND
T.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER); -- 9 Rows updated

ROLLBACK;

-- IF WE need to delete the records from the tbl_transaction table

DELETE FROM TBL_TRANSACTION T
WHERE exists(Select employee_number from tbl_employee E WHERE UPPER(employee_last_name) like 'Y%' AND
T.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER); --9 rows deleted.

ROLLBACK;

--------------------------------------
-- WITH CLAUSE And getting TOP rows
--------------------------------------

-- Q: Select top 5 rows from each department in a single query

Select D.Department , D.Department_head,E.employee_number, employee_first_name, employee_last_name
    , ROW_NUMBER() OVER (PARTITION BY D.Department order by Employee_number) as MY_RANK 
From tbl_department D
JOIN tbl_employee E
on D.Department = E.Department
Order by employee_number;

-- NOW Put the above query as the derived query/sub-query

select * from (Select D.Department , D.Department_head,E.employee_number, employee_first_name, employee_last_name
    , ROW_NUMBER() OVER (PARTITION BY D.Department order by Employee_number) as MY_RANK 
From tbl_department D
JOIN tbl_employee E
on D.Department = E.Department
Order by employee_number) where my_rank <=5
ORDER BY Department,employee_number;

-----------------------------------------------
-- WITH statments

---- SYNTAX :
/*
WITH <Table name(alias)> AS
(<Derived query>)
Select * from <Table name(alias)>;
 */
 
WITH tbl_With_Ranking AS (Select D.Department , D.Department_head,E.employee_number, employee_first_name, employee_last_name
    , ROW_NUMBER() OVER (PARTITION BY D.Department order by Employee_number) as MY_RANK 
From tbl_department D
JOIN tbl_employee E
on D.Department = E.Department
Order by employee_number)

select * from tbl_With_Ranking
where my_rank <=5
ORDER BY Department,employee_number;

-- ADDING Table transaction as well

WITH tbl_With_Ranking AS (Select D.Department , D.Department_head,E.employee_number, employee_first_name, employee_last_name
    , ROW_NUMBER() OVER (PARTITION BY D.Department order by Employee_number) as MY_RANK 
From tbl_department D
JOIN tbl_employee E
on D.Department = E.Department
Order by employee_number),
tbl_transaction_2021 AS
(Select * from tbl_transaction Where extract(YEAR FROM DATE_OF_TRANSACTION) = 2021)

select * from tbl_With_Ranking NATURAL LEFT JOIN tbl_transaction_2021
where my_rank <=5
ORDER BY Department,employee_number;

---------------------------------------------------------------------------------