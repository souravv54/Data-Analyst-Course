---------------------
-- CTE Statement
---------------------

--Adding a new column - Manager in employee table

ALTER TABLE tbl_employee ADD manager NUMBER(6, 0);

-- Add Managers

UPDATE tbl_employee
SET
    manager = trunc(((employee_number - 123) / 10) + 123)
WHERE employee_number > 123;

SELECT e.employee_number,
       e.employee_first_name,
       e.employee_last_name,
       m.employee_number     AS manager_number,
       m.employee_first_name AS manager_first_name,
       m.employee_last_name  AS manager_last_name
FROM tbl_employee e
JOIN tbl_employee m ON e.manager = m.employee_number
ORDER BY e.employee_number;

-------------------------
-- Recursive CTEs

-- It is a WITH Statement that called itself

WITH mytable (
    employee_number,
    employee_first_name,
    employee_last_name,
    boss_number
) AS (
    SELECT e.employee_number, -- Anchor Part
           e.employee_first_name,
           e.employee_last_name,
           0 AS boss_number
    FROM tbl_employee e
    WHERE manager IS NULL
    UNION ALL
    SELECT e.employee_number,  -- Recursive part
           e.employee_first_name,
           e.employee_last_name,
           m.boss_number + 1 AS boss_number
    FROM tbl_employee e
    JOIN mytable m ON e.manager = m.employee_number
)
SELECT *
FROM mytable
ORDER BY employee_number;