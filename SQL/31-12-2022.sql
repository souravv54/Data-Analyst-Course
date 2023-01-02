-- Date Field types

DROP TABLE MYTESTTABLE; 

/*CREATE TABLE MYTESTTABLE
(mydate DATE);*/
-- For timestamp 

CREATE TABLE MYTESTTABLE
(mydate TIMESTAMP);

INSERT INTO MYTESTTABLE
VALUES ('01-JAN-2023');

--ANSI SQL FORMAT
INSERT INTO MYTESTTABLE
VALUES (DATE '2023-01-02');

--TIMESTAMP
INSERT INTO MYTESTTABLE
VALUES (TIMESTAMP '2023-01-03 11:20:30');

COMMIT;

SELECT * FROM MYTESTTABLE;

select mydate - 1 as result from mytesttable;

select extract(year from mydate) as result from mytesttable;


select mydate,trunc(mydate)-extract(month from mydate) as result from mytesttable;

-- Convert Date to strings
select 'The date is ' || mydate as result from mytesttable;

select 'The date is ' || to_char(mydate,'YYYY-MM-DD') as result from mytesttable;

select 'The date is ' || to_char(mydate,'DS') as result from mytesttable;

select 'The date is ' || to_char(mydate,'DL') as result from mytesttable;

