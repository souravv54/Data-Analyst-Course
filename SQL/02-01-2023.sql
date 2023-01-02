---------------------------------------
-- Summarising and ordering data
---------------------------------------
select * from ptbl_product;

select * from ptbl_subcategory where subcategory_name like '%Bike%';

-- Summarising and ordering data
--Group by and order by clause

select extract(year from date_of_birth) , count(*) as Number_born
from tbl_employee
group by extract(year from date_of_birth) ;
-- above one is non deterministic

--make it in ordered way
select extract(year from date_of_birth) , count(*) as Number_born
from tbl_employee
group by extract(year from date_of_birth)
order by 1 desc;
--order by extract(Year from date_of_birth) desc;

-- by default its in ascending order

--Order of writing a query
SELECT/ FROM / WHERE / GROUP BY / HAVING / ORDER BY

-- The way that computer executes :
FROM /WHERE /GROUP BY / HAVING /SELECT / ORDER BY

---------------------------------------
-- Criteria on summarised data
---------------------------------------
SELECT
    SUBSTR(employee_last_name,1,1) as "INITIAL",
    count(*) as count_of_initial
FROM
    tbl_employee
WHERE
    DATE_OF_BIRTH >= TO_DATE('1986-01-01', 'YYYY-MM-DD')
GROUP BY 
    SUBSTR(employee_last_name,1,1)
HAVING 
    count(*) >=20
ORDER BY 
    1 DESC;
---------------------------------------
-- Exercise - 1
---------------------------------------

SELECT
    Extract(Month from date_of_birth),
    count(employee_number)
FROM
    tbl_employee
Group by Extract(Month from date_of_birth)
order by 1 ;
