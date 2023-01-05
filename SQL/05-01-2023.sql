-- ORDER BY NULLS FIRST AND LAST
    
-- Q : How many have a middle name, how many don't , and what is the DOB range (min/max)

select 
    to_char(date_of_birth , 'FMMonth') AS "Month Name"
    ,count(*) AS "Number of employees"
    ,count(employee_middle_name) AS "NUMBER OF MIDDLE NAMES"
    ,count(*)- count(employee_middle_name) AS "NUMBER OF EMPLOYEES W/O MIDDLE NAMES"
    ,MIN(date_of_birth) AS "EARLIEST_DATE_OF_BIRTH"
    ,MAX(date_of_birth) AS "LATEST_DATE_OF_BIRTH"
FROM TBL_EMPLOYEE
GROUP BY
    TO_CHAR(date_of_birth,'FMMonth'), To_CHAR(date_of_birth, 'MM')
ORDER BY
    To_CHAR(date_of_birth, 'MM');
-------------------------------------------------------
SELECT
    employee_number,
    employee_first_name,
    employee_middle_name,
    employee_last_name,
    employee_government_id,
    date_of_birth,
    department
FROM
    tbl_employee
WHERE
    TO_CHAR(DATE_OF_BIRTH,'MM') = 01
--ORDER BY employee_middle_name NULLS FIRST;
ORDER BY employee_middle_name NULLS LAST;