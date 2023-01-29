--------------------------------------
-- Timezone and interval Datatype
--------------------------------------

DROP TABLE mytesttable;

CREATE TABLE mytesttable (
    mydate TIMESTAMP
);

INSERT INTO mytesttable VALUES ( DATE '2020-04-03' );

INSERT INTO mytesttable VALUES ( TIMESTAMP '2020-04-03 11:20:30' );

COMMIT;

SELECT *
FROM mytesttable;

-- ADDING TIMEZONE

DROP TABLE mytesttable;

CREATE TABLE mytesttable (
    mydate TIMESTAMP WITH TIME ZONE
);

INSERT INTO mytesttable VALUES ( TIMESTAMP '2020-04-03 11:20:30 +08:00' );

INSERT INTO mytesttable VALUES ( TIMESTAMP '2020-04-03 11:20:30 -05:00' );

COMMIT;

SELECT *
FROM mytesttable;