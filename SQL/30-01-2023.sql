--------------------------------------
-- Timezone and interval Datatype -2
--------------------------------------

-- TIMEZONE Functions

SELECT localtimestamp
FROM dual; -- Current Date/time as timestamp

SELECT sessiontimezone
FROM dual;  -- Current session timezone

SELECT tz_offset('Asia/Calcutta')
FROM dual; -- What is the timezone offset

SELECT current_timestamp
FROM dual;  -- Current session date/time as timezone

SELECT systimestamp
FROM dual; -- Current Database date/time as Timezone

--------------------------------

-- Interval Data types:

DROP TABLE mytesttable;

CREATE TABLE mytesttable (
    myinterval INTERVAL YEAR(3) TO MONTH
);

INSERT INTO mytesttable VALUES ( INTERVAL '123-11' YEAR ( 3 ) TO MONTH );

INSERT INTO mytesttable VALUES ( INTERVAL '3-5' YEAR ( 3 ) TO MONTH );

INSERT INTO mytesttable VALUES ( INTERVAL '-3-5' YEAR ( 3 ) TO MONTH );

INSERT INTO mytesttable VALUES ( INTERVAL '13' YEAR );

INSERT INTO mytesttable VALUES ( INTERVAL '50' MONTH );

INSERT INTO mytesttable VALUES ( INTERVAL '2021' YEAR ); -- wil not work

COMMIT;

SELECT *
FROM mytesttable;

--------------
DROP TABLE mytesttable;

CREATE TABLE mytesttable (
    myinterval INTERVAL DAY(3) TO SECOND(6)
);

INSERT INTO mytesttable VALUES ( INTERVAL '1 2:3:4.567' DAY ( 3 ) TO SECOND ( 3 ) );

INSERT INTO mytesttable VALUES ( INTERVAL '3 4:5' DAY TO MINUTE );

INSERT INTO mytesttable VALUES ( INTERVAL '400 1' DAY ( 3 ) TO HOUR );

SELECT *
FROM mytesttable;


----------------------------------

--------------------------------------
-- SEQUENCE and DATA DICTIONARY
--------------------------------------

-- Data Dictionary

SELECT *
FROM all_objects
WHERE object_type = 'TABLE' AND object_name LIKE 'TBL%';

SELECT *
FROM user_objects
WHERE object_type = 'TABLE' AND object_name LIKE 'TBL%';

SELECT *
FROM dba_objects
ORDER BY object_name;

SELECT *
FROM cat;

---------

-- Data Sequence

-- Generated Always/By default as Identity

CREATE SEQUENCE newseq START WITH 1 INCREMENT BY 1 MINVALUE 1;

SELECT *
FROM seq$;

DROP SEQUENCE newseq;

CREATE SEQUENCE newseq START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 CYCLE CACHE 50;

SELECT o.name,
       s.*
FROM sys.seq$ s
LEFT JOIN obj$     o ON s.obj# = o.obj#
ORDER BY o.name;

-- Default values
CREATE SEQUENCE secondseq;

SELECT o.name,
       s.*
FROM sys.seq$ s
LEFT JOIN obj$     o ON s.obj# = o.obj#
ORDER BY o.name;  -- Max val : 999..... and Cache = 20

----------------------------------

-- Using Sequence

-- NO rollback worked on sequence

DROP SEQUENCE newseq;

CREATE SEQUENCE newseq START WITH 1 INCREMENT BY 1 MINVALUE 1 CACHE 50;

SELECT newseq.CURRVAL AS currvalue
FROM dual; -- can't use CURRVAL before NEXTVAL

SELECT newseq.NEXTVAL AS nextvalue
FROM dual;

SELECT newseq.CURRVAL AS current_value
FROM dual;

DROP SEQUENCE newseq;

CREATE SEQUENCE newseq START WITH 1 INCREMENT BY 1 MINVALUE 1 CACHE 50;

CREATE TABLE tbl_transaction2 (
    amount              NUMBER(15, 2) NOT NULL,
    date_of_transaction DATE,
    employee_number     NUMBER(4, 0) NOT NULL,
    nextnumber          NUMBER(7, 0) DEFAULT newseq.NEXTVAL
);

SELECT *
FROM tbl_transaction2;

INSERT INTO tbl_transaction2 (
    amount,
    date_of_transaction,
    employee_number
) VALUES (
    1,
    DATE '2017-01-01',
    123
);

SELECT *
FROM tbl_transaction2
WHERE employee_number = 123;

ALTER SEQUENCE newseq INCREMENT BY 4 NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE;

INSERT INTO tbl_transaction2 (
    amount,
    date_of_transaction,
    employee_number
) VALUES (
    1,
    DATE '2017-01-01',
    123
);

SELECT *
FROM tbl_transaction2
WHERE employee_number = 123;

-- NOTE : The sequence number can't be reset to 1, for this we have to drop the sequence.