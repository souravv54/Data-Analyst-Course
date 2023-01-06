-- Missing Data

select E_number from (
             select E.Employee_number AS E_NUMBER, T.Employee_number AS T_NUMBER,
                    E.Employee_First_name , E.Employee_last_name,
                    Sum(T.Amount) AS TOTAL_AMOUNT
            from TBL_EMPLOYEE E
            left  join TBL_TRANSACTION T
            ON 
                E.Employee_number = T.Employee_number
            WHERE
                t.employee_number IS NULL
            Group by E.Employee_number, T.Employee_number, E.Employee_First_name , E.Employee_last_name
            ORder by E.Employee_number, T.Employee_number, E.Employee_First_name , E.Employee_last_name)
Where
E_number <200;

-- NOTE : In above query, Is called subquery, where the inner query runs first then the outer one.
-- That' the reason we are using 'E_Number' in outer query instead of 'E.Employee_number'

-- DELETING DATA

select E.Employee_number AS E_NUMBER, T.Employee_number AS T_NUMBER,
       E.Employee_First_name , E.Employee_last_name,
       T.Amount AS TOTAL_AMOUNT
from TBL_EMPLOYEE E
Right join TBL_TRANSACTION T
ON 
    E.Employee_number = T.Employee_number
WHERE
    E.employee_number IS NULL
--Group by E.Employee_number, T.Employee_number, E.Employee_First_name , E.Employee_last_name
ORder by E.Employee_number, T.Employee_number, E.Employee_First_name , E.Employee_last_name;

-- DELETE STATEMENT
Select Count(*) from TBL_TRANSACTION;

Delete from TBL_TRANSACTION
Where EMPLOYEE_NUMBER in
(select T.Employee_number AS T_NUMBER
from TBL_EMPLOYEE E
Right join TBL_TRANSACTION T
ON 
    E.Employee_number = T.Employee_number
WHERE
    E.employee_number IS NULL
);

Select Count(*) from TBL_TRANSACTION;

ROLLBACK;
--COMMIT;