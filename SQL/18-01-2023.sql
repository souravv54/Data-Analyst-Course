----------------------------
-- ANALYTICAL FUNCTIONS
----------------------------
-- ROW_NUMBER , RANK , DENSE_RANK
SELECT employee_number,
       attendance_month,
       number_attendance,
       ROWNUM --Pseudo column
       ,
       ROW_NUMBER()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS the_row_number
FROM tbl_attendance;

----- Another example :
-- RAnk and DENSE RANK :

SELECT employee_number,
       attendance_month,
       number_attendance,
       ROWNUM --Pseudo column
       ,
       ROW_NUMBER()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS the_row_number,
       RANK()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS the_rank,
       DENSE_RANK()
       OVER(PARTITION BY employee_number
            ORDER BY attendance_month
       ) AS the_dense_rank
FROM (SELECT *
    FROM tbl_attendance
    UNION ALL
    SELECT *
    FROM tbl_attendance);
    
--> ROWS - ROW_NUMBER
--> RANGE - RANK/DENSE RANK
--> Partition by is optional and Order by is compulsary

-------------------------------------------------
--- NTILE :
-------------------------------------------------

-- Also called as Number of tiles helps in Grouping the columns using NTILE function

Select employee_number, attendance_month, number_attendance,
    ROW_NUMBER() OVER (PARTITION BY employee_number ORDER BY attendance_month) AS THE_ROW_NUMBER,
    NTILE(10) OVER (PARTITION BY employee_number ORDER BY attendance_month) AS THE_NTILE
FROM tbl_attendance
WHERE ATTENDANCE_MONTH < TO_DATE('2022-05-01','YYYY-MM-DD');


