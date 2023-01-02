-- Create a table TBL_EMPLOYEE
drop table TBL_EMPLOYEE;
Create table TBL_EMPLOYEE(
EMPLOYEE_NUMBER DECIMAL(4,0) NOT NULL
,EMPLOYEE_FIRST_NAME VARCHAR2(50 CHAR) NOT NULL
,EMPLOYEE_MIDDLE_NAME VARCHAR2(50 CHAR) NULL
,EMPLOYEE_LAST_NAME VARCHAR2(50 CHAR) NOT NULL
,EMPLOYEE_GOVERNMENT_ID CHAR(10 CHAR) NULL
,DATE_OF_BIRTH DATE NOT NULL);

-- Adding and modifying additional columns

ALTER  TABLE TBL_EMPLOYEE
ADD DEPARTMENT VARCHAR2(10);

-- the below query will give error because of value too large for column : Dept.
INSERT INTO TBL_EMPLOYEE
VALUES (132, 'Dylan','A','Word','NHS1777D','14-sep-1994','Customer Relations');

ALTER TABLE TBL_EMPLOYEE
MODIFY DEPARTMENT VARCHAR2(20 CHAR);

INSERT INTO TBL_EMPLOYEE
VALUES (132, 'Dylan','A','Word','NHS1777D','14-sep-1994','Customer Relations');

-- if we need to drop the columns :
ALTER TABLE TBL_EMPLOYEE
DROP COLUMN DEPARTMENT;

select * from tbl_employee where upper(employee_Last_name) = 'WORD';

