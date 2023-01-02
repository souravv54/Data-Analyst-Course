-- 01/01/2023
--Creating and Querying part of a table

select * from tbl_employee
where employee_number >200;

--NOT clause
select * from tbl_employee
where NOT (employee_number >= 200 AND employee_number <= 209);

-- selecting a part of table - Dates

select * from tbl_employee where date_of_birth < '01-Mar-1992';

-- USING TO_DATE function Conversion.
select * from tbl_employee
where date_of_birth >= TO_DATE('1976-01-01','YYYY-MM-DD') and 
        date_of_birth < TO_DATE('1987-01-01','YYYY-MM-DD');
    
-- EXTRACT keyword ( Do not use )
select * from tbl_employee
Where extract(year from date_of_birth) between 1976 and 1986;

-----------------------------------------------------------------



