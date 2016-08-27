-- ******************************************************
-- vac_approv.sql
--
-- Loader for HR Vacation Approval Database
--
-- Description: This script contains the DDL to load
--              the tables of the
--              HR Vacation Approval Database
--
-- There are 8 tables in this DB
--
-- Author:  Marnie Scully
--
-- Last Modified:   December 17, 2014
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION           
-- ******************************************************

spool vac_approv.lst

-- ******************************************************
--    DROP TABLES
-- ******************************************************

DROP table tbemp_day_req purge;
DROP table tbemp purge;
DROP table tbdept_shift purge;
DROP table tbday_req purge;
DROP table tbemp_type purge;
DROP table tbshift purge;
DROP table tbdept purge;
DROP table tbday_type purge;


-- ******************************************************
--    CREATE TABLES          
-- ******************************************************

CREATE table tbday_type (
    day_type_id  char(2)                                not null
        constraint pk_day_type primary key,
    day_type     varchar2(15)                           not null
);


CREATE table tbdept (
    dept_id        varchar2(10)                         not null
        constraint pk_dept primary key,
    dept           varchar2(30)                         not null   
);


CREATE table tbshift (
    shift_id       char(1)                              not null
        constraint pk_shift primary key,
    shift          varchar2(20)                         not null
);


CREATE table tbemp_type (
    emp_type_id  varchar2(5)                       not null
        constraint pk_emp_type primary key,
    emp_type     varchar2(15)                      not null
);

CREATE table tbday_req (
    day_req  date                                       not null
        constraint pk_day_req primary key,
    day_type_id  char(2)                                not null
        constraint fk_day_type_id_tbday_req references tbday_type (day_type_id)
);

CREATE table tbdept_shift (
    dept_id        varchar2(10)                         not null
        constraint fk_dept_id_tbdept_shift references tbdept (dept_id),
    shift_id       char(1)                              not null
        constraint fk_shift_id_tbdept_shift references tbshift (shift_id),
    num_emp_out    number(4,0)         default 1        not null,
        constraint pk_dept_shift primary key (dept_id, shift_id)
);


CREATE table tbemp(
    num_los        number(4,0)                          not null
        constraint pk_emp primary key,
    dept_id        varchar2(10)                         not null
        constraint fk_dept_id_tbemp references tbdept (dept_id),
    shift_id       char(1)                              not null
        constraint fk_shift_id_tbemp references tbshift (shift_id),
    emp_type_id    varchar2(5)                          not null
        constraint fk_emp_type_tbemp references tbemp_type (emp_type_id),
    first_name     varchar2(50)                         not null,
    last_name      varchar2(50)                         not null,
    num_vac_days   number(4,0)                          not null,
    email          varchar2(50)                         not null,
    password       varchar2(20)                         not null
);

CREATE table tbemp_day_req (
    num_los        number(4,0)                         not null
        constraint fk_num_los_tbemp_day_req references tbemp (num_los) on delete cascade,
    day_req  date                                       not null
        constraint fk_day_req_tbemp_day_req references tbday_req (day_req),
        constraint pk_emp_day_req primary key (num_los, day_req)
);


-- ******************************************************
--    POPULATE TABLES
-- ******************************************************

/* tbday_type */

INSERT into tbday_type values ('WD', 'Work Day');
INSERT into tbday_type values ('WE', 'Weekend');
INSERT into tbday_type values ('HD', 'Holiday');

/*  tbdept */

INSERT into tbdept values ('ADMIN', 'Administration');
INSERT into tbdept values ('HR', 'Human Resources');
INSERT into tbdept values ('IT', 'Information Technology');
INSERT into tbdept values ('PCK', 'Picking');
INSERT into tbdept values ('REC', 'Receiving');
INSERT into tbdept values ('SHP', 'Shipping');
INSERT into tbdept values ('STK', 'Stocking');

/* tbshift */

INSERT into tbshift values ('1', 'First');
INSERT into tbshift values ('2', 'Second');
INSERT into tbshift values ('3', 'Third');

/* tbemp_type */

INSERT into tbemp_type values ('EMP', 'Employee');
INSERT into tbemp_type values ('HR', 'Human Resources');
INSERT into tbemp_type values ('MGR', 'Manager');

/* tbday_req */

INSERT into tbday_req values ( '01-JAN-2015', 'HD');
INSERT into tbday_req values ( '02-JAN-2015', 'WD');
INSERT into tbday_req values ( '03-JAN-2015', 'WE');
INSERT into tbday_req values ( '04-JAN-2015', 'WE');
INSERT into tbday_req values ( '05-JAN-2015', 'WD');
INSERT into tbday_req values ( '06-JAN-2015', 'WD');
INSERT into tbday_req values ( '07-JAN-2015', 'WD');
INSERT into tbday_req values ( '08-JAN-2015', 'WD');
INSERT into tbday_req values ( '09-JAN-2015', 'WD');
INSERT into tbday_req values ( '10-JAN-2015', 'WE');
INSERT into tbday_req values ( '11-JAN-2015', 'WE');
INSERT into tbday_req values ( '12-JAN-2015', 'WD');
INSERT into tbday_req values ( '13-JAN-2015', 'WD');
INSERT into tbday_req values ( '14-JAN-2015', 'WD');
INSERT into tbday_req values ( '15-JAN-2015', 'WD');
INSERT into tbday_req values ( '16-JAN-2015', 'WD');
INSERT into tbday_req values ( '17-JAN-2015', 'WE');
INSERT into tbday_req values ( '18-JAN-2015', 'WE');
INSERT into tbday_req values ( '19-JAN-2015', 'WD');
INSERT into tbday_req values ( '20-JAN-2015', 'WD');
INSERT into tbday_req values ( '21-JAN-2015', 'WD');
INSERT into tbday_req values ( '22-JAN-2015', 'WD');
INSERT into tbday_req values ( '23-JAN-2015', 'WD');
INSERT into tbday_req values ( '24-JAN-2015', 'WE');
INSERT into tbday_req values ( '25-JAN-2015', 'WE');
INSERT into tbday_req values ( '26-JAN-2015', 'WD');
INSERT into tbday_req values ( '27-JAN-2015', 'WD');
INSERT into tbday_req values ( '28-JAN-2015', 'WD');
INSERT into tbday_req values ( '29-JAN-2015', 'WD');
INSERT into tbday_req values ( '30-JAN-2015', 'WD');
INSERT into tbday_req values ( '31-JAN-2015', 'WE');
INSERT into tbday_req values ( '01-FEB-2015', 'WE');
INSERT into tbday_req values ( '02-FEB-2015', 'WD');
INSERT into tbday_req values ( '03-FEB-2015', 'WD');
INSERT into tbday_req values ( '04-FEB-2015', 'WD');
INSERT into tbday_req values ( '05-FEB-2015', 'WD');
INSERT into tbday_req values ( '06-FEB-2015', 'WD');
INSERT into tbday_req values ( '07-FEB-2015', 'WE');
INSERT into tbday_req values ( '08-FEB-2015', 'WE');
INSERT into tbday_req values ( '09-FEB-2015', 'WD');
INSERT into tbday_req values ( '10-FEB-2015', 'WD');
INSERT into tbday_req values ( '11-FEB-2015', 'WD');
INSERT into tbday_req values ( '12-FEB-2015', 'WD');
INSERT into tbday_req values ( '13-FEB-2015', 'WD');
INSERT into tbday_req values ( '14-FEB-2015', 'WE');
INSERT into tbday_req values ( '15-FEB-2015', 'WE');
INSERT into tbday_req values ( '16-FEB-2015', 'WD');
INSERT into tbday_req values ( '17-FEB-2015', 'WD');
INSERT into tbday_req values ( '18-FEB-2015', 'WD');
INSERT into tbday_req values ( '19-FEB-2015', 'WD');
INSERT into tbday_req values ( '20-FEB-2015', 'WD');
INSERT into tbday_req values ( '21-FEB-2015', 'WE');
INSERT into tbday_req values ( '22-FEB-2015', 'WE');
INSERT into tbday_req values ( '23-FEB-2015', 'WD');
INSERT into tbday_req values ( '24-FEB-2015', 'WD');
INSERT into tbday_req values ( '25-FEB-2015', 'WD');
INSERT into tbday_req values ( '26-FEB-2015', 'WD');
INSERT into tbday_req values ( '27-FEB-2015', 'WD');
INSERT into tbday_req values ( '28-FEB-2015', 'WE');
INSERT into tbday_req values ( '01-MAR-2015', 'WE');
INSERT into tbday_req values ( '02-MAR-2015', 'WD');
INSERT into tbday_req values ( '03-MAR-2015', 'WD');
INSERT into tbday_req values ( '04-MAR-2015', 'WD');
INSERT into tbday_req values ( '05-MAR-2015', 'WD');
INSERT into tbday_req values ( '06-MAR-2015', 'WD');
INSERT into tbday_req values ( '07-MAR-2015', 'WE');
INSERT into tbday_req values ( '08-MAR-2015', 'WE');
INSERT into tbday_req values ( '09-MAR-2015', 'WD');
INSERT into tbday_req values ( '10-MAR-2015', 'WD');
INSERT into tbday_req values ( '11-MAR-2015', 'WD');
INSERT into tbday_req values ( '12-MAR-2015', 'WD');
INSERT into tbday_req values ( '13-MAR-2015', 'WD');
INSERT into tbday_req values ( '14-MAR-2015', 'WE');
INSERT into tbday_req values ( '15-MAR-2015', 'WE');
INSERT into tbday_req values ( '16-MAR-2015', 'WD');
INSERT into tbday_req values ( '17-MAR-2015', 'WD');
INSERT into tbday_req values ( '18-MAR-2015', 'WD');
INSERT into tbday_req values ( '19-MAR-2015', 'WD');
INSERT into tbday_req values ( '20-MAR-2015', 'WD');
INSERT into tbday_req values ( '21-MAR-2015', 'WE');
INSERT into tbday_req values ( '22-MAR-2015', 'WE');
INSERT into tbday_req values ( '23-MAR-2015', 'WD');
INSERT into tbday_req values ( '24-MAR-2015', 'WD');
INSERT into tbday_req values ( '25-MAR-2015', 'WD');
INSERT into tbday_req values ( '26-MAR-2015', 'WD');
INSERT into tbday_req values ( '27-MAR-2015', 'WD');
INSERT into tbday_req values ( '28-MAR-2015', 'WE');
INSERT into tbday_req values ( '29-MAR-2015', 'WE');
INSERT into tbday_req values ( '30-MAR-2015', 'WD');
INSERT into tbday_req values ( '31-MAR-2015', 'WD');
INSERT into tbday_req values ( '01-APR-2015', 'WD');
INSERT into tbday_req values ( '02-APR-2015', 'WD');
INSERT into tbday_req values ( '03-APR-2015', 'HD');
INSERT into tbday_req values ( '04-APR-2015', 'WE');
INSERT into tbday_req values ( '05-APR-2015', 'WE');
INSERT into tbday_req values ( '06-APR-2015', 'WD');
INSERT into tbday_req values ( '07-APR-2015', 'WD');
INSERT into tbday_req values ( '08-APR-2015', 'WD');
INSERT into tbday_req values ( '09-APR-2015', 'WD');
INSERT into tbday_req values ( '10-APR-2015', 'WD');
INSERT into tbday_req values ( '11-APR-2015', 'WE');
INSERT into tbday_req values ( '12-APR-2015', 'WE');
INSERT into tbday_req values ( '13-APR-2015', 'WD');
INSERT into tbday_req values ( '14-APR-2015', 'WD');
INSERT into tbday_req values ( '15-APR-2015', 'WD');
INSERT into tbday_req values ( '16-APR-2015', 'WD');
INSERT into tbday_req values ( '17-APR-2015', 'WD');
INSERT into tbday_req values ( '18-APR-2015', 'WE');
INSERT into tbday_req values ( '19-APR-2015', 'WE');
INSERT into tbday_req values ( '20-APR-2015', 'WD');
INSERT into tbday_req values ( '21-APR-2015', 'WD');
INSERT into tbday_req values ( '22-APR-2015', 'WD');
INSERT into tbday_req values ( '23-APR-2015', 'WD');
INSERT into tbday_req values ( '24-APR-2015', 'WD');
INSERT into tbday_req values ( '25-APR-2015', 'WE');
INSERT into tbday_req values ( '26-APR-2015', 'WE');
INSERT into tbday_req values ( '27-APR-2015', 'WD');
INSERT into tbday_req values ( '28-APR-2015', 'WD');
INSERT into tbday_req values ( '29-APR-2015', 'WD');
INSERT into tbday_req values ( '30-APR-2015', 'WD');
INSERT into tbday_req values ( '01-MAY-2015', 'WD');
INSERT into tbday_req values ( '02-MAY-2015', 'WE');
INSERT into tbday_req values ( '03-MAY-2015', 'WE');
INSERT into tbday_req values ( '04-MAY-2015', 'WD');
INSERT into tbday_req values ( '05-MAY-2015', 'WD');
INSERT into tbday_req values ( '06-MAY-2015', 'WD');
INSERT into tbday_req values ( '07-MAY-2015', 'WD');
INSERT into tbday_req values ( '08-MAY-2015', 'WD');
INSERT into tbday_req values ( '09-MAY-2015', 'WE');
INSERT into tbday_req values ( '10-MAY-2015', 'WE');
INSERT into tbday_req values ( '11-MAY-2015', 'WD');
INSERT into tbday_req values ( '12-MAY-2015', 'WD');
INSERT into tbday_req values ( '13-MAY-2015', 'WD');
INSERT into tbday_req values ( '14-MAY-2015', 'WD');
INSERT into tbday_req values ( '15-MAY-2015', 'WD');
INSERT into tbday_req values ( '16-MAY-2015', 'WE');
INSERT into tbday_req values ( '17-MAY-2015', 'WE');
INSERT into tbday_req values ( '18-MAY-2015', 'WD');
INSERT into tbday_req values ( '19-MAY-2015', 'WD');
INSERT into tbday_req values ( '20-MAY-2015', 'WD');
INSERT into tbday_req values ( '21-MAY-2015', 'WD');
INSERT into tbday_req values ( '22-MAY-2015', 'WD');
INSERT into tbday_req values ( '23-MAY-2015', 'WE');
INSERT into tbday_req values ( '24-MAY-2015', 'WE');
INSERT into tbday_req values ( '25-MAY-2015', 'HD');
INSERT into tbday_req values ( '26-MAY-2015', 'WD');
INSERT into tbday_req values ( '27-MAY-2015', 'WD');
INSERT into tbday_req values ( '28-MAY-2015', 'WD');
INSERT into tbday_req values ( '29-MAY-2015', 'WD');
INSERT into tbday_req values ( '30-MAY-2015', 'WE');
INSERT into tbday_req values ( '31-MAY-2015', 'WE');
INSERT into tbday_req values ( '01-JUN-2015', 'WD');
INSERT into tbday_req values ( '02-JUN-2015', 'WD');
INSERT into tbday_req values ( '03-JUN-2015', 'WD');
INSERT into tbday_req values ( '04-JUN-2015', 'WD');
INSERT into tbday_req values ( '05-JUN-2015', 'WD');
INSERT into tbday_req values ( '06-JUN-2015', 'WE');
INSERT into tbday_req values ( '07-JUN-2015', 'WE');
INSERT into tbday_req values ( '08-JUN-2015', 'WD');
INSERT into tbday_req values ( '09-JUN-2015', 'WD');
INSERT into tbday_req values ( '10-JUN-2015', 'WD');
INSERT into tbday_req values ( '11-JUN-2015', 'WD');
INSERT into tbday_req values ( '12-JUN-2015', 'WD');
INSERT into tbday_req values ( '13-JUN-2015', 'WE');
INSERT into tbday_req values ( '14-JUN-2015', 'WE');
INSERT into tbday_req values ( '15-JUN-2015', 'WD');
INSERT into tbday_req values ( '16-JUN-2015', 'WD');
INSERT into tbday_req values ( '17-JUN-2015', 'WD');
INSERT into tbday_req values ( '18-JUN-2015', 'WD');
INSERT into tbday_req values ( '19-JUN-2015', 'WD');
INSERT into tbday_req values ( '20-JUN-2015', 'WE');
INSERT into tbday_req values ( '21-JUN-2015', 'WE');
INSERT into tbday_req values ( '22-JUN-2015', 'WD');
INSERT into tbday_req values ( '23-JUN-2015', 'WD');
INSERT into tbday_req values ( '24-JUN-2015', 'WD');
INSERT into tbday_req values ( '25-JUN-2015', 'WD');
INSERT into tbday_req values ( '26-JUN-2015', 'WD');
INSERT into tbday_req values ( '27-JUN-2015', 'WE');
INSERT into tbday_req values ( '28-JUN-2015', 'WE');
INSERT into tbday_req values ( '29-JUN-2015', 'WD');
INSERT into tbday_req values ( '30-JUN-2015', 'WD');
INSERT into tbday_req values ( '01-JUL-2015', 'WD');
INSERT into tbday_req values ( '02-JUL-2015', 'WD');
INSERT into tbday_req values ( '03-JUL-2015', 'HD');
INSERT into tbday_req values ( '04-JUL-2015', 'WE');
INSERT into tbday_req values ( '05-JUL-2015', 'WE');
INSERT into tbday_req values ( '06-JUL-2015', 'WD');
INSERT into tbday_req values ( '07-JUL-2015', 'WD');
INSERT into tbday_req values ( '08-JUL-2015', 'WD');
INSERT into tbday_req values ( '09-JUL-2015', 'WD');
INSERT into tbday_req values ( '10-JUL-2015', 'WD');
INSERT into tbday_req values ( '11-JUL-2015', 'WE');
INSERT into tbday_req values ( '12-JUL-2015', 'WE');
INSERT into tbday_req values ( '13-JUL-2015', 'WD');
INSERT into tbday_req values ( '14-JUL-2015', 'WD');
INSERT into tbday_req values ( '15-JUL-2015', 'WD');
INSERT into tbday_req values ( '16-JUL-2015', 'WD');
INSERT into tbday_req values ( '17-JUL-2015', 'WD');
INSERT into tbday_req values ( '18-JUL-2015', 'WE');
INSERT into tbday_req values ( '19-JUL-2015', 'WE');
INSERT into tbday_req values ( '20-JUL-2015', 'WD');
INSERT into tbday_req values ( '21-JUL-2015', 'WD');
INSERT into tbday_req values ( '22-JUL-2015', 'WD');
INSERT into tbday_req values ( '23-JUL-2015', 'WD');
INSERT into tbday_req values ( '24-JUL-2015', 'WD');
INSERT into tbday_req values ( '25-JUL-2015', 'WE');
INSERT into tbday_req values ( '26-JUL-2015', 'WE');
INSERT into tbday_req values ( '27-JUL-2015', 'WD');
INSERT into tbday_req values ( '28-JUL-2015', 'WD');
INSERT into tbday_req values ( '29-JUL-2015', 'WD');
INSERT into tbday_req values ( '30-JUL-2015', 'WD');
INSERT into tbday_req values ( '31-JUL-2015', 'WD');
INSERT into tbday_req values ( '01-AUG-2015', 'WE');
INSERT into tbday_req values ( '02-AUG-2015', 'WE');
INSERT into tbday_req values ( '03-AUG-2015', 'WD');
INSERT into tbday_req values ( '04-AUG-2015', 'WD');
INSERT into tbday_req values ( '05-AUG-2015', 'WD');
INSERT into tbday_req values ( '06-AUG-2015', 'WD');
INSERT into tbday_req values ( '07-AUG-2015', 'WD');
INSERT into tbday_req values ( '08-AUG-2015', 'WE');
INSERT into tbday_req values ( '09-AUG-2015', 'WE');
INSERT into tbday_req values ( '10-AUG-2015', 'WD');
INSERT into tbday_req values ( '11-AUG-2015', 'WD');
INSERT into tbday_req values ( '12-AUG-2015', 'WD');
INSERT into tbday_req values ( '13-AUG-2015', 'WD');
INSERT into tbday_req values ( '14-AUG-2015', 'WD');
INSERT into tbday_req values ( '15-AUG-2015', 'WE');
INSERT into tbday_req values ( '16-AUG-2015', 'WE');
INSERT into tbday_req values ( '17-AUG-2015', 'WD');
INSERT into tbday_req values ( '18-AUG-2015', 'WD');
INSERT into tbday_req values ( '19-AUG-2015', 'WD');
INSERT into tbday_req values ( '20-AUG-2015', 'WD');
INSERT into tbday_req values ( '21-AUG-2015', 'WD');
INSERT into tbday_req values ( '22-AUG-2015', 'WE');
INSERT into tbday_req values ( '23-AUG-2015', 'WE');
INSERT into tbday_req values ( '24-AUG-2015', 'WD');
INSERT into tbday_req values ( '25-AUG-2015', 'WD');
INSERT into tbday_req values ( '26-AUG-2015', 'WD');
INSERT into tbday_req values ( '27-AUG-2015', 'WD');
INSERT into tbday_req values ( '28-AUG-2015', 'WD');
INSERT into tbday_req values ( '29-AUG-2015', 'WE');
INSERT into tbday_req values ( '30-AUG-2015', 'WE');
INSERT into tbday_req values ( '31-AUG-2015', 'WD');
INSERT into tbday_req values ( '01-SEP-2015', 'WD');
INSERT into tbday_req values ( '02-SEP-2015', 'WD');
INSERT into tbday_req values ( '03-SEP-2015', 'WD');
INSERT into tbday_req values ( '04-SEP-2015', 'WD');
INSERT into tbday_req values ( '05-SEP-2015', 'WE');
INSERT into tbday_req values ( '06-SEP-2015', 'WE');
INSERT into tbday_req values ( '07-SEP-2015', 'HD');
INSERT into tbday_req values ( '08-SEP-2015', 'WD');
INSERT into tbday_req values ( '09-SEP-2015', 'WD');
INSERT into tbday_req values ( '10-SEP-2015', 'WD');
INSERT into tbday_req values ( '11-SEP-2015', 'WD');
INSERT into tbday_req values ( '12-SEP-2015', 'WE');
INSERT into tbday_req values ( '13-SEP-2015', 'WE');
INSERT into tbday_req values ( '14-SEP-2015', 'WD');
INSERT into tbday_req values ( '15-SEP-2015', 'WD');
INSERT into tbday_req values ( '16-SEP-2015', 'WD');
INSERT into tbday_req values ( '17-SEP-2015', 'WD');
INSERT into tbday_req values ( '18-SEP-2015', 'WD');
INSERT into tbday_req values ( '19-SEP-2015', 'WE');
INSERT into tbday_req values ( '20-SEP-2015', 'WE');
INSERT into tbday_req values ( '21-SEP-2015', 'WD');
INSERT into tbday_req values ( '22-SEP-2015', 'WD');
INSERT into tbday_req values ( '23-SEP-2015', 'WD');
INSERT into tbday_req values ( '24-SEP-2015', 'WD');
INSERT into tbday_req values ( '25-SEP-2015', 'WD');
INSERT into tbday_req values ( '26-SEP-2015', 'WE');
INSERT into tbday_req values ( '27-SEP-2015', 'WE');
INSERT into tbday_req values ( '28-SEP-2015', 'WD');
INSERT into tbday_req values ( '29-SEP-2015', 'WD');
INSERT into tbday_req values ( '30-SEP-2015', 'WD');
INSERT into tbday_req values ( '01-OCT-2015', 'WD');
INSERT into tbday_req values ( '02-OCT-2015', 'WD');
INSERT into tbday_req values ( '03-OCT-2015', 'WE');
INSERT into tbday_req values ( '04-OCT-2015', 'WE');
INSERT into tbday_req values ( '05-OCT-2015', 'WD');
INSERT into tbday_req values ( '06-OCT-2015', 'WD');
INSERT into tbday_req values ( '07-OCT-2015', 'WD');
INSERT into tbday_req values ( '08-OCT-2015', 'WD');
INSERT into tbday_req values ( '09-OCT-2015', 'WD');
INSERT into tbday_req values ( '10-OCT-2015', 'WE');
INSERT into tbday_req values ( '11-OCT-2015', 'WE');
INSERT into tbday_req values ( '12-OCT-2015', 'WD');
INSERT into tbday_req values ( '13-OCT-2015', 'WD');
INSERT into tbday_req values ( '14-OCT-2015', 'WD');
INSERT into tbday_req values ( '15-OCT-2015', 'WD');
INSERT into tbday_req values ( '16-OCT-2015', 'WD');
INSERT into tbday_req values ( '17-OCT-2015', 'WE');
INSERT into tbday_req values ( '18-OCT-2015', 'WE');
INSERT into tbday_req values ( '19-OCT-2015', 'WD');
INSERT into tbday_req values ( '20-OCT-2015', 'WD');
INSERT into tbday_req values ( '21-OCT-2015', 'WD');
INSERT into tbday_req values ( '22-OCT-2015', 'WD');
INSERT into tbday_req values ( '23-OCT-2015', 'WD');
INSERT into tbday_req values ( '24-OCT-2015', 'WE');
INSERT into tbday_req values ( '25-OCT-2015', 'WE');
INSERT into tbday_req values ( '26-OCT-2015', 'WD');
INSERT into tbday_req values ( '27-OCT-2015', 'WD');
INSERT into tbday_req values ( '28-OCT-2015', 'WD');
INSERT into tbday_req values ( '29-OCT-2015', 'WD');
INSERT into tbday_req values ( '30-OCT-2015', 'WD');
INSERT into tbday_req values ( '31-OCT-2015', 'WE');
INSERT into tbday_req values ( '01-NOV-2015', 'WE');
INSERT into tbday_req values ( '02-NOV-2015', 'WD');
INSERT into tbday_req values ( '03-NOV-2015', 'WD');
INSERT into tbday_req values ( '04-NOV-2015', 'WD');
INSERT into tbday_req values ( '05-NOV-2015', 'WD');
INSERT into tbday_req values ( '06-NOV-2015', 'WD');
INSERT into tbday_req values ( '07-NOV-2015', 'WE');
INSERT into tbday_req values ( '08-NOV-2015', 'WE');
INSERT into tbday_req values ( '09-NOV-2015', 'WD');
INSERT into tbday_req values ( '10-NOV-2015', 'WD');
INSERT into tbday_req values ( '11-NOV-2015', 'WD');
INSERT into tbday_req values ( '12-NOV-2015', 'WD');
INSERT into tbday_req values ( '13-NOV-2015', 'WD');
INSERT into tbday_req values ( '14-NOV-2015', 'WE');
INSERT into tbday_req values ( '15-NOV-2015', 'WE');
INSERT into tbday_req values ( '16-NOV-2015', 'WD');
INSERT into tbday_req values ( '17-NOV-2015', 'WD');
INSERT into tbday_req values ( '18-NOV-2015', 'WD');
INSERT into tbday_req values ( '19-NOV-2015', 'WD');
INSERT into tbday_req values ( '20-NOV-2015', 'WD');
INSERT into tbday_req values ( '21-NOV-2015', 'WE');
INSERT into tbday_req values ( '22-NOV-2015', 'WE');
INSERT into tbday_req values ( '23-NOV-2015', 'WD');
INSERT into tbday_req values ( '24-NOV-2015', 'WD');
INSERT into tbday_req values ( '25-NOV-2015', 'WD');
INSERT into tbday_req values ( '26-NOV-2015', 'HD');
INSERT into tbday_req values ( '27-NOV-2015', 'WD');
INSERT into tbday_req values ( '28-NOV-2015', 'WE');
INSERT into tbday_req values ( '29-NOV-2015', 'WE');
INSERT into tbday_req values ( '30-NOV-2015', 'WD');
INSERT into tbday_req values ( '01-DEC-2015', 'WD');
INSERT into tbday_req values ( '02-DEC-2015', 'WD');
INSERT into tbday_req values ( '03-DEC-2015', 'WD');
INSERT into tbday_req values ( '04-DEC-2015', 'WD');
INSERT into tbday_req values ( '05-DEC-2015', 'WE');
INSERT into tbday_req values ( '06-DEC-2015', 'WE');
INSERT into tbday_req values ( '07-DEC-2015', 'WD');
INSERT into tbday_req values ( '08-DEC-2015', 'WD');
INSERT into tbday_req values ( '09-DEC-2015', 'WD');
INSERT into tbday_req values ( '10-DEC-2015', 'WD');
INSERT into tbday_req values ( '11-DEC-2015', 'WD');
INSERT into tbday_req values ( '12-DEC-2015', 'WE');
INSERT into tbday_req values ( '13-DEC-2015', 'WE');
INSERT into tbday_req values ( '14-DEC-2015', 'WD');
INSERT into tbday_req values ( '15-DEC-2015', 'WD');
INSERT into tbday_req values ( '16-DEC-2015', 'WD');
INSERT into tbday_req values ( '17-DEC-2015', 'WD');
INSERT into tbday_req values ( '18-DEC-2015', 'WD');
INSERT into tbday_req values ( '19-DEC-2015', 'WE');
INSERT into tbday_req values ( '20-DEC-2015', 'WE');
INSERT into tbday_req values ( '21-DEC-2015', 'WD');
INSERT into tbday_req values ( '22-DEC-2015', 'WD');
INSERT into tbday_req values ( '23-DEC-2015', 'WD');
INSERT into tbday_req values ( '24-DEC-2015', 'WD');
INSERT into tbday_req values ( '25-DEC-2015', 'HD');
INSERT into tbday_req values ( '26-DEC-2015', 'WE');
INSERT into tbday_req values ( '27-DEC-2015', 'WE');
INSERT into tbday_req values ( '28-DEC-2015', 'WD');
INSERT into tbday_req values ( '29-DEC-2015', 'WD');
INSERT into tbday_req values ( '30-DEC-2015', 'WD');
INSERT into tbday_req values ( '31-DEC-2015', 'WD');

/* tbdept_shift */

INSERT into tbdept_shift values ( 'ADMIN', '1', 1);
INSERT into tbdept_shift values ( 'ADMIN', '2', 1);
INSERT into tbdept_shift values ( 'ADMIN', '3', 1);
INSERT into tbdept_shift values ( 'HR', '1', 1);
INSERT into tbdept_shift values ( 'HR', '2', 1);
INSERT into tbdept_shift values ( 'HR', '3', 1);
INSERT into tbdept_shift values ( 'IT', '1', 1);
INSERT into tbdept_shift values ( 'IT', '2', 1);
INSERT into tbdept_shift values ( 'IT', '3', 1);
INSERT into tbdept_shift values ( 'PCK', '1', 2);
INSERT into tbdept_shift values ( 'PCK', '2', 4);
INSERT into tbdept_shift values ( 'PCK', '3', 2);
INSERT into tbdept_shift values ( 'REC', '1', 4);
INSERT into tbdept_shift values ( 'REC', '2', 2);
INSERT into tbdept_shift values ( 'REC', '3', 1);
INSERT into tbdept_shift values ( 'SHP', '1', 3);
INSERT into tbdept_shift values ( 'SHP', '2', 2);
INSERT into tbdept_shift values ( 'SHP', '3', 1);
INSERT into tbdept_shift values ( 'STK', '1', 5);
INSERT into tbdept_shift values ( 'STK', '2', 3);
INSERT into tbdept_shift values ( 'STK', '3', 2);

/* tbemp */

INSERT into tbemp values ( 11, 'PCK', '1','EMP','John','Smith',20,'jsmith@pharmchain.com','jsmith1');
INSERT into tbemp values ( 20, 'REC', '3','EMP','Mary','Willliams',15,'mwilliams@pharmchain.com','mwilliams1');
INSERT into tbemp values ( 31, 'IT', '1','EMP','Jane','Jones',5,'jjones@pharmchain.com','jjones1');
INSERT into tbemp values ( 42, 'PCK', '1','MGR','Miranda','Tyler',10,'mtyler@pharmchain.com','mtyler1');
INSERT into tbemp values ( 56, 'HR', '1','HR','Steven','Johnson',20,'sjohnson@pharmchain.com','sjohnson1');
INSERT into tbemp values ( 64, 'PCK', '1','EMP','Lisa','Hennessy',20,'lhennessy@pharmchain.com','lhennessy1');
INSERT into tbemp values ( 79, 'PCK', '1','EMP','Anthony','Dwyer',10,'adwyer@pharmchain.com','adwyer1');
INSERT into tbemp values ( 106, 'PCK', '1','EMP','Corie','McHugh',15,'cmchugh@pharmchain.com','cmchugh1');

/* tbemp_day_req */

INSERT into tbemp_day_req values (11,'12-JAN-2015');
INSERT into tbemp_day_req values (11,'13-JAN-2015');
INSERT into tbemp_day_req values (11,'14-JAN-2015');
INSERT into tbemp_day_req values (11,'15-JAN-2015');
INSERT into tbemp_day_req values (11,'16-JAN-2015');
INSERT into tbemp_day_req values (20,'12-JAN-2015');
INSERT into tbemp_day_req values (20,'13-JAN-2015');
INSERT into tbemp_day_req values (20,'14-JAN-2015');
INSERT into tbemp_day_req values (20,'15-JAN-2015');
INSERT into tbemp_day_req values (20,'16-JAN-2015');
INSERT into tbemp_day_req values (31,'19-JAN-2015');
INSERT into tbemp_day_req values (31,'20-JAN-2015');
INSERT into tbemp_day_req values (31,'21-JAN-2015');
INSERT into tbemp_day_req values (31,'22-JAN-2015');
INSERT into tbemp_day_req values (31,'23-JAN-2015');
INSERT into tbemp_day_req values (42,'16-FEB-2015');
INSERT into tbemp_day_req values (42,'17-FEB-2015');
INSERT into tbemp_day_req values (42,'18-FEB-2015');
INSERT into tbemp_day_req values (42,'19-FEB-2015');
INSERT into tbemp_day_req values (42,'20-FEB-2015');
INSERT into tbemp_day_req values (56,'22-MAY-2015');
INSERT into tbemp_day_req values (56,'26-MAY-2015');
INSERT into tbemp_day_req values (56,'27-MAY-2015');
INSERT into tbemp_day_req values (56,'28-MAY-2015');
INSERT into tbemp_day_req values (56,'29-MAY-2015');


-- ******************************************************
--    VIEW TABLES
-- ******************************************************

SELECT * FROM tbday_type;
SELECT * FROM tbdept;
SELECT * FROM tbshift;
SELECT * FROM tbemp_type;
SELECT * FROM tbday_req;
SELECT * FROM tbdept_shift;
SELECT * FROM tbemp;
SELECT * FROM tbemp_day_req;


-- ******************************************************
--    END SESSION
--             
-- ******************************************************

spool off


