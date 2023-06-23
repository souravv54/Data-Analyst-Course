-- NAMESPACES :

Connect c##sourav/sourav
Create table c##sourav.tbl_employee
(myfield varchar2(20));

select * from c##sourav.tbl_employee;

DROP table c##sourav.tbl_employee;
-----------------
Connect c##sourav/sourav
Create view c##sourav.tbl_employee as 
select user from dual;  

----------------
--Schema Namespaces : 
TABLES
VIEWS
SEQUENCES
PRIVATE SYNONYMS
--------------

--Namespace : 
Indexes
Constraints 

DROP USER C##sourav CASCADE;
-- CASCADE is here because we have created the objects for this user,
-- so if we need to drop the user without any hurdle then we need to use CASCADE.

------------------
-- Privilages DATA Dictionary
------------------

select * from USER_TAB_PRIVS;  -- all objects where the current user is the grantee
select * from ALL_TAB_PRIVS;  -- all objects where the user or PUBLIC is the grantee.
select * from DBA_TAB_PRIVS;  -- list all grants on all objects in the database.


--------- 
-- UNUSED columns 
---------

Alter table tbl_employee
Drop column Manager; -- Give error :  "cannot drop column from table owned by SYS"

Alter table C##sourav.tbl_employee
add  MyField2 Number(4,0);

select * from C##sourav.tbl_employee;

Alter table C##sourav.tbl_employee
set unused (MyField2);

select * from C##sourav.tbl_employee; -- only 1 column present

Alter table C##sourav.tbl_employee
Drop unused columns ; --- we can drop USER table but not the SYS table.

------------------------

