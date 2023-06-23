-------------------
--USERS & SCHEMA
-------------------
select user from DUAL; -- fetch the user for the session

-- SCHEMA objects == USER

select * from sys.tbl_employee;
-- select * from <schema>.<object>;

Create user newuser IDENTIFIED BY MyPassword;

Create user C##Philip Identified by phillip;

--Connect to the user : 
CONNECT C##Phillip/phillip
--Connect <user>/<Password>

--------------
--Privilages
--------------

--- Role : A collection of system privilages , object privilages and roles.

Grant select on object to user;
-- Using ROLE 
ROLE  = GRANT SELECT ON object to user;
Phillip ROLE;

--- Hands on ROLE

Drop user C##Phillip CASCADE;

Create user c##sourav identified by sourav;

select cdb from v$database;

connect C##sourav/sourav

Grant create session to c##sourav;
Grant unlimited tablespace to c##sourav;

Grant CONNECT, RESOURCE, DBA to C##sourav;

Revoke Resource from C##sourav;

Grant create any table to c##sourav with admin option;

Grant select on sys.tbl_employee to C##sourav;

Create role C##new_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sys.tbl_attendance TO c##new_role;

GRANT C##new_role to C##sourav;

Show user;