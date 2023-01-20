--- FIRST_VALUE and LAST_VALUE
------------------------------

SELECT employee_number,
       attendance_month,
       number_attendance,
       FIRST_VALUE(number_attendance)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS first_month,
       LAST_VALUE(number_attendance)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_month
FROM tbl_attendance;

--- LAG AND LEAD

SELECT employee_number,
       attendance_month,
       number_attendance,
       LAG(number_attendance)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS my_lag,
       LEAD(number_attendance)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS my_lead
FROM tbl_attendance;

--Modification over lead and lag :
--syntax : LEAD/LAG (value,input lag by, fill by lag values)

SELECT employee_number,
       attendance_month,
       number_attendance,
       LAG(number_attendance, 3, 999)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS my_lag,
       LEAD(number_attendance, 3, 999)
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS my_lead
FROM tbl_attendance;

--------------------------------
--- CUME_DIST and PERCENT_RANK
--------------------------------
-- Cume_dist --> Cumulative distribution (cal : row number/count number in partition)
-- PERCENT_RANK(cal : row number -1 /count number in partition -1)

SELECT employee_number,
       attendance_month,
       number_attendance,
       CUME_DIST()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS mycume_dist,
       PERCENT_RANK()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS mypercent_rank
FROM tbl_attendance;

--------------------------------
--PERCENTILE_CONT and PERCENTILE_DISC

--cont means continous and disc means discrete
-- Percentile 50% is also known as median

SELECT DISTINCT employee_number,
                PERCENTILE_CONT(0.5) WITHIN GROUP(
                    ORDER BY number_attendance
                )
                OVER(PARTITION BY employee_number) AS my_percentile_cont,
                PERCENTILE_DISC(0.5) WITHIN GROUP(
                    ORDER BY number_attendance
                )
                OVER(PARTITION BY employee_number) AS my_percentile_disc
FROM tbl_attendance;

-- 40%

SELECT DISTINCT employee_number,
                PERCENTILE_CONT(0.4) WITHIN GROUP(
                    ORDER BY number_attendance
                )
                OVER(PARTITION BY employee_number) AS my_percentile_cont,
                PERCENTILE_DISC(0.4) WITHIN GROUP(
                    ORDER BY number_attendance
                )
                OVER(PARTITION BY employee_number) AS my_percentile_disc
FROM tbl_attendance;

-------------------------------------------------------------------------