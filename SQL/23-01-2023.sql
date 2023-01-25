-----------------------------------------
-- Generating a list of Numbers

SELECT employee_number
FROM tbl_transaction
ORDER BY 1;

SELECT employee_number
FROM tbl_employee
WHERE employee_number NOT IN (
    SELECT DISTINCT employee_number
    FROM tbl_transaction
)
ORDER BY employee_number;

-- Missing Employee Numbers

WITH numbers AS (
    SELECT ROWNUM AS my_row_number
    FROM tbl_transaction
)
SELECT my_row_number AS missing_employee_numbers
FROM numbers         n
LEFT JOIN tbl_transaction t ON n.my_row_number = t.employee_number
WHERE t.employee_number IS NULL
ORDER BY employee_number;

-- Missing employee NUmbers with max value

WITH numbers AS (
    SELECT ROWNUM AS my_row_number
    FROM tbl_transaction
), numbers2 AS (
    SELECT *
    FROM numbers
    WHERE my_row_number <= (
        SELECT MAX(employee_number)
        FROM tbl_employee
    )
)
SELECT my_row_number AS missing_employee_numbers
FROM numbers2        n
LEFT JOIN tbl_transaction t ON n.my_row_number = t.employee_number
WHERE t.employee_number IS NULL
ORDER BY employee_number;

-----------------------------------------------------------
-- Grouping Numbers

WITH numbers AS (
    SELECT ROWNUM AS my_row_number
    FROM tbl_transaction
), numbers2 AS (
    SELECT *
    FROM numbers
    WHERE my_row_number <= (
        SELECT MAX(employee_number)
        FROM tbl_employee
    )
), transaction_2021 AS (
    SELECT *
    FROM tbl_transaction
    WHERE EXTRACT(YEAR FROM date_of_transaction) = 2021
)
SELECT my_row_number AS missing_employee_numbers
FROM numbers2         n
LEFT JOIN transaction_2021 t ON n.my_row_number = t.employee_number
WHERE t.employee_number IS NULL
ORDER BY employee_number;

----------------------
--  Group of empoyees

WITH numbers AS (
    SELECT ROWNUM AS my_row_number
    FROM tbl_transaction
), numbers2 AS (
    SELECT *
    FROM numbers
    WHERE my_row_number <= (
        SELECT MAX(employee_number)
        FROM tbl_employee
    )
), transaction_2021 AS (
    SELECT *
    FROM tbl_transaction
    WHERE EXTRACT(YEAR FROM date_of_transaction) = 2021
), gaps AS (
    SELECT my_row_number AS missing_employee_numbers,
           LAG(my_row_number)
           OVER(
               ORDER BY my_row_number
           )             AS previous_number,
           my_row_number - LAG(my_row_number)
                           OVER(
               ORDER BY my_row_number
                           )             AS gap,
           CASE
               WHEN my_row_number - LAG(my_row_number)
                                    OVER(
                   ORDER BY my_row_number
                                    ) = 1 THEN
                   0
               ELSE
                   1
           END           AS group_gap
    FROM numbers2         n
    LEFT JOIN transaction_2021 t ON n.my_row_number = t.employee_number
    WHERE t.employee_number IS NULL
), groups AS (
    SELECT g.*,
           SUM(group_gap)
           OVER(
           ORDER BY missing_employee_numbers) AS the_group
    FROM gaps g
)
SELECT the_group,
       MIN(missing_employee_numbers) AS starting_employee,
       MAX(missing_employee_numbers) AS ending_employee
FROM groups
GROUP BY the_group
ORDER BY the_group;

-----------------
-- Rownum, OFFSET and FETCH

SELECT t.*,
       ROWNUM
FROM tbl_transaction t
WHERE ROWNUM <= 10;

SELECT t.*,
       ROWNUM
FROM tbl_transaction t
WHERE ROWNUM = 2;  -- 0 Records returned

--Rectification
SELECT *
FROM (
    SELECT t.*,
           ROWNUM AS myrownum
    FROM tbl_transaction t
)
WHERE myrownum = 2;

-- USE FETCH
SELECT *
FROM tbl_transaction
FETCH FIRST 2 ROWS ONLY;

-- USE OFFSET
SELECT *
FROM tbl_transaction
OFFSET 1 ROW -- OFFSET MEANS SKIP the number of rows
FETCH FIRST 1 ROW ONLY; -- FETCH means consider the number of rows from pointing area

SELECT *
FROM tbl_transaction
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--NOTE :- TOP (10) is not present in oracle SQL.

-- EXTENSION OF FETCH AND OFFSET

SELECT employee_number
FROM tbl_transaction
ORDER BY employee_number
OFFSET 2 ROWS FETCH NEXT 3 ROWS WITH TIES;