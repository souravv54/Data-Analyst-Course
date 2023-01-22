--------------------------------------
-- SUB-QUERIES
--------------------------------------

-- The WHERE CLAUSE : Filter tool

SELECT *
FROM tbl_transaction
NATURAL JOIN tbl_employee
WHERE upper(employee_last_name) LIKE 'Y%'
ORDER BY employee_number;

-- Using Sub-query in WHERE Clause

SELECT *
FROM tbl_transaction
WHERE employee_number IN (
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number;

----------------------------------------------------
--WHERE And NOT

SELECT *
FROM tbl_transaction
WHERE employee_number IN (
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) NOT LIKE 'Y%'
)
ORDER BY employee_number; -- like inner join

--lets take the NOT operator ouside the sub-query

SELECT *
FROM tbl_transaction
WHERE employee_number NOT IN (
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number; --like outer join

-- ---------------------------------------------------
-- ANY,SOME and ALL


SELECT *
FROM tbl_transaction
WHERE employee_number = ANY (   -- Here employee_number = ANY (126,127,128,129) -- looks like OR operator
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number;

SELECT *
FROM tbl_transaction
WHERE employee_number = SOME (   -- Here employee_number = SOME (126,127,128,129)
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number;

SELECT *
FROM tbl_transaction
WHERE employee_number = ALL (   -- Here employee_number = ALL (126,127,128,129) --Looke like AND operator
    SELECT employee_number
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number;

-----------------------------------------------------------------------
-- The FROM Clause

SELECT *
FROM tbl_employee
WHERE upper(employee_last_name) LIKE 'Y%';

-- USing a JOIN with subquery 

SELECT *
FROM tbl_transaction
NATURAL JOIN (
    SELECT *
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
)
ORDER BY employee_number;

SELECT t.*,
       e.*
FROM tbl_transaction t
JOIN (
    SELECT *
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'
) e ON e.employee_number = t.employee_number
ORDER BY e.employee_number;

-- Compare the below two queries

SELECT *
FROM tbl_transaction
NATURAL LEFT JOIN (
    SELECT *
    FROM tbl_employee
    WHERE upper(employee_last_name) LIKE 'Y%'  -- FISTLY filter then JOIN --return 3239 rows
)
ORDER BY employee_number;

SELECT *
FROM tbl_transaction
NATURAL LEFT JOIN tbl_employee
WHERE upper(employee_last_name) LIKE 'Y%'
ORDER BY employee_number;   -- Fistly JOIN then Filter --return 9 rows

-------------------------------------------------------
-- The SELECT clause

SELECT employee_number,
       employee_first_name,
       employee_last_name
FROM tbl_employee
WHERE upper(employee_last_name) LIKE 'Y%';

-- Q: count the number of transaction in tbl_transaction table for above query


SELECT e.employee_number,
       e.employee_first_name,
       e.employee_last_name,
       COUNT(t.date_of_transaction)
FROM tbl_employee e
JOIN tbl_transaction t ON t.employee_number = e.employee_number
WHERE upper(e.employee_last_name) LIKE 'Y%'
GROUP BY e.employee_number,
         e.employee_first_name,
         e.employee_last_name;


-- Another way using correlated sub-query

SELECT employee_number,
       employee_first_name,
       employee_last_name,
       (
           SELECT COUNT(*)
           FROM tbl_transaction t
           WHERE t.employee_number = e.employee_number  -- using external table to define the inner query output
       ) number_of_transactions
FROM tbl_employee e
WHERE upper(e.employee_last_name) LIKE 'Y%';

---------------------------------------------------------------------------

