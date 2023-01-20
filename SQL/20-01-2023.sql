----------------------------
-- GROUP FUNCTIONS
----------------------------

--- ADDING TOTALS

SELECT department,
       employee_number,
       attendance_month       AS attendance_month,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number,
         attendance_month
ORDER BY department,
         employee_number,
         attendance_month;

-- We need Total attendance per employee number :


SELECT department,
       employee_number,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
ORDER BY department,
         employee_number;

-- UNION BOTH TABLES

SELECT department,
       employee_number,
       attendance_month       AS attendance_month,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number,
         attendance_month
UNION
SELECT department,
       employee_number,
       TO_DATE('2099-01-01', 'YYYY-MM-DD'), -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
ORDER BY department,
         employee_number;

-- We can also use NULL instead of Dummy date column, and use order by attendance_month as well.

-- Create department wise total as well using UNION

SELECT department,
       employee_number,
       attendance_month       AS attendance_month,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number,
         attendance_month
UNION
SELECT department,
       employee_number,
       NULL, -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
UNION
SELECT department,
       NULL, -- NULL every employee_number
       NULL, -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
ORDER BY 1,
         2,
         3;


--TOTAL also known as ROLLUP ( Will see in next SQL Query)

SELECT department,
       employee_number,
       attendance_month       AS attendance_month,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number,
         attendance_month
UNION
SELECT department,
       employee_number,
       NULL, -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
UNION
SELECT department,
       NULL, -- NULL every employee_number
       NULL, -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY department,
         employee_number
UNION
SELECT NULL, -- NULL every Department
       NULL, -- NULL every employee_number
       NULL, -- Extra Dummy column we created to match the number of columns
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
ORDER BY 1,
         2,
         3;

------------------------------------------------------------
-- ROLLUP, GROUPING and GROUPING ID
-----------------------------------------------------------

--ROLLUP

SELECT department,
       employee_number,
       attendance_month       AS attendance_month,
       SUM(number_attendance) AS number_attendance
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY ROLLUP(department,
                employee_number,
                attendance_month)
ORDER BY department,
         employee_number,
         attendance_month;

-- GROUPING 

SELECT department,
       employee_number,
       attendance_month           AS attendance_month,
       SUM(number_attendance)     AS number_attendance,
       GROUPING(attendance_month) AS is_groupiing_attendance_month
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY ROLLUP(department,
                employee_number,
                attendance_month)
ORDER BY department,
         employee_number,
         attendance_month;

-- GROUPING_ID

SELECT department,
       employee_number,
       attendance_month                                           AS attendance_month,
       SUM(number_attendance)                                     AS number_attendance,
       GROUPING(attendance_month)                                 AS is_groupiing_attendance_month,
       GROUPING_ID(department, employee_number, attendance_month) AS my_grouping_id
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY ROLLUP(department,
                employee_number,
                attendance_month)
ORDER BY department,
         employee_number,
         attendance_month;
         
----------------------------------------------------------------------------
-- GROUPING SETS
----------------------------------------------------------------------------
-- Use CUBE instead of ROLLUP

SELECT department,
       employee_number,
       attendance_month                                           AS attendance_month,
       SUM(number_attendance)                                     AS number_attendance,
       GROUPING(attendance_month)                                 AS is_groupiing_attendance_month,
       GROUPING_ID(department, employee_number, attendance_month) AS my_grouping_id
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY CUBE(department,
              employee_number,
              attendance_month)
ORDER BY department,
         employee_number,
         attendance_month;
         
-- Grouping set wise using GROUPING SETS

SELECT department,
       employee_number,
       attendance_month                                           AS attendance_month,
       SUM(number_attendance)                                     AS number_attendance,
       GROUPING(attendance_month)                                 AS is_groupiing_attendance_month,
       GROUPING_ID(department, employee_number, attendance_month) AS my_grouping_id
FROM tbl_employee
JOIN tbl_attendance USING ( employee_number )
GROUP BY GROUPING SETS ( ( department,
                           employee_number,
                           attendance_month ), ( department ),
                                               ( employee_number ), ( ) ) -- () represents Grand total 
ORDER BY department NULLS FIRST,
         employee_number NULLS FIRST,
         attendance_month NULLS FIRST; -- NULLS FIRST, used to display the NULL records first