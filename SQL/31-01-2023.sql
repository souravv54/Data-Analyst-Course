-----------------
-- INDEXES
-----------------
-- Unique and Primary constraint automatically create index.


CREATE INDEX idx_tbl_transaction ON
    tbl_transaction (
        amount
    ); -- By Default it is NON UNIQUE

DROP INDEX idx_tbl_transaction;

-- Create UNIQUE Index

CREATE UNIQUE INDEX idx_tbl_attendance ON
    tbl_attendance (
        employee_number,
        attendance_month,
        number_attendance
    );

DROP INDEX idx_tbl_attendance;

--Alter the indexes

ALTER INDEX idx_tbl_attendance UNUSABLE; -- stop indexing

ALTER INDEX idx_tbl_attendance REBUILD; -- start indexing

SELECT o.name,
       i.*
FROM sys.ind$ i
LEFT JOIN obj$     o ON i.obj# = o.obj#
ORDER BY o.name;