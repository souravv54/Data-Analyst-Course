----------------------------
-- THE OVER CLAUSE
----------------------------

-- Attendance table
SELECT employee_number,
       attendance_month,
       number_attendance
FROM tbl_attendance;

--Q : All of attendence for each employee per year.

SELECT employee_number,
       EXTRACT(YEAR FROM attendance_month) AS attendance_year,
       SUM(number_attendance)              AS total_attendance
FROM tbl_attendance
GROUP BY employee_number,
         EXTRACT(YEAR FROM attendance_month)
ORDER BY employee_number,
         EXTRACT(YEAR FROM attendance_month);

-- USING OVER CLAUSE

SELECT employee_number,
       attendance_month,
       SUM(number_attendance)
       OVER() AS total_attendance
FROM tbl_attendance;

-- Add percentage column

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER()   AS total_attendance,
       round(number_attendance /(SUM(number_attendance)
                                 OVER()) * 100,
             4) AS percentage_attendance
FROM tbl_attendance;

-------------------------------------
--- PARTITION BY And ORDER BY
-------------------------------------

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number)   AS total_attendance,
       round(number_attendance /(SUM(number_attendance)
                                 OVER(PARTITION BY employee_number)) * 100,
             4) AS percentage_attendance
FROM tbl_attendance
WHERE extract(year from attendance_month) = 2021;

-- ADDING order by in the above query

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number ORDER BY attendance_month)  AS RUNNING_attendance
      -- ,round(number_attendance /(SUM(number_attendance) OVER(PARTITION BY employee_number)) * 100,4) AS percentage_attendance
FROM tbl_attendance
WHERE extract(year from attendance_month) = 2021;

--------------------
-- 3rd component of over clause is RANGE OR ROWS BETWEEN

SELECT employee_number,
       attendance_month,
       number_attendance,
       SUM(number_attendance)
       OVER(PARTITION BY employee_number , EXTRACT (YEAR FROM attendance_month)
       ORDER BY attendance_month ROWS BETWEEN 1 PRECEDING and 1 FOLLOWING)  AS MY_TOTAL
       FROM tbl_attendance
WHERE extract(year from attendance_month) = 2021;
