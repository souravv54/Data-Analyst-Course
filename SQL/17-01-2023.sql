-- CURRENT ROW And UNBOUNDED

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING
       ) AS my_total
FROM tbl_attendance
WHERE EXTRACT(YEAR FROM attendance_month) = 2021;

--------------------
--For unbounded preceding 
SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING
       ) AS my_total
FROM tbl_attendance
WHERE EXTRACT(YEAR FROM attendance_month) = 2021;

--For unbounded following 

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING
       ) AS my_total
FROM tbl_attendance
WHERE EXTRACT(YEAR FROM attendance_month) = 2021;


------------------
-- RANGE vs ROWS

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS rows_total,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS range_total
FROM tbl_attendance
WHERE EXTRACT(YEAR FROM attendance_month) = 2021; -- NO diff between Range and rows


-- NOEW we duplicate the values :

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS rows_total,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number,
           EXTRACT(YEAR FROM attendance_month)
            ORDER BY attendance_month
           RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS range_total
FROM (
    SELECT *
    FROM tbl_attendance
    UNION ALL
    SELECT *
    FROM tbl_attendance
)
WHERE EXTRACT(YEAR FROM attendance_month) = 2021;

--FOR RANGE :
-- UNBOUNDED PRECEDING AND CURRENT ROW = RANGE UNBOINDED PRECEDING
-- CURRENT ROW AND UNBOUNDED FOLLOWING = RANGE UNBOUNDED FOLLOWING 
-- UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWINFG 

-- FOR RANGE :
-- IF ORDER BY  ASC = RANGE UNBOUNDED PRECEDING , DESC = RANGE UNBOUNDED FOLLOWING 
-- RANGE AND ROWS ARE ALSO CALLED WINDOWS PARTITIONING.