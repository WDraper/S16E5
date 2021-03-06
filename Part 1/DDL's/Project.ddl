-- Generated by Oracle SQL Developer Data Modeler 4.1.3.901
--   at:        2016-04-22 10:28:06 CDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




DROP TABLE P_Department CASCADE CONSTRAINTS ;

DROP TABLE P_Manager_Employee CASCADE CONSTRAINTS ;

DROP TABLE P_Parent_Child CASCADE CONSTRAINTS ;

DROP TABLE P_Person CASCADE CONSTRAINTS ;

DROP TABLE P_Project CASCADE CONSTRAINTS ;

DROP TABLE P_Projects CASCADE CONSTRAINTS ;

CREATE TABLE P_Department
  (
    dept_id   INTEGER NOT NULL ,
    dept_name VARCHAR2 (200)
  ) ;
ALTER TABLE P_Department ADD CONSTRAINT P_Department_PK PRIMARY KEY ( dept_id ) ;


CREATE TABLE P_Manager_Employee
  (
    me_id       INTEGER NOT NULL ,
    manager_id  INTEGER ,
    employee_id INTEGER
  ) ;
ALTER TABLE P_Manager_Employee ADD CONSTRAINT Manager_Employee_PK PRIMARY KEY ( me_id ) ;


CREATE TABLE P_Parent_Child
  (
    parent_child_id INTEGER NOT NULL ,
    parent_id       INTEGER ,
    child_id        INTEGER
  ) ;
ALTER TABLE P_Parent_Child ADD CONSTRAINT P_Parent_Child_PK PRIMARY KEY ( parent_child_id ) ;


CREATE TABLE P_Person
  (
    person_id        INTEGER NOT NULL ,
    person_type      VARCHAR2 (200) ,
    first_name       VARCHAR2 (200) ,
    last_name        VARCHAR2 (200) ,
    street_address   VARCHAR2 (200) ,
    city             VARCHAR2 (200) ,
    state            VARCHAR2 (200) ,
    zipcode          INTEGER ,
    phone            INTEGER ,
    salary           INTEGER ,
    bonus            INTEGER ,
    us_citizen       CHAR (1) ,
    salary_exception CHAR (1) ,
    fired            CHAR (1) ,
    quit             CHAR (1) ,
    dept_id          INTEGER ,
    spouse_id        INTEGER
  ) ;
CREATE UNIQUE INDEX P_Person__IDX ON P_Person
  (
    spouse_id ASC
  )
  ;
ALTER TABLE P_Person ADD CONSTRAINT P_Person_PK PRIMARY KEY ( person_id ) ;


CREATE TABLE P_Project
  (
    project_id       INTEGER NOT NULL ,
    project_title    VARCHAR2 (200) ,
    project_type     VARCHAR2 (200) ,
    project_active   CHAR (1) ,
    end_date         DATE ,
    est_person_hours INTEGER ,
    manager_id       INTEGER ,
    dept_id          INTEGER ,
    mp_id            INTEGER
  ) ;
ALTER TABLE P_Project ADD CONSTRAINT P_Project_PK PRIMARY KEY ( project_id ) ;


CREATE TABLE P_Projects
  (
    projects_id INTEGER NOT NULL ,
    person_id   INTEGER ,
    project_id  INTEGER
  ) ;
ALTER TABLE P_Projects ADD CONSTRAINT P_Projects_PK PRIMARY KEY ( projects_id ) ;


ALTER TABLE P_Manager_Employee ADD CONSTRAINT Manager_Employee_P_Person_FK FOREIGN KEY ( manager_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Manager_Employee ADD CONSTRAINT Manager_Employee_P_Person_FKv1 FOREIGN KEY ( employee_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Parent_Child ADD CONSTRAINT P_Parent_Child_P_Person_FK FOREIGN KEY ( parent_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Parent_Child ADD CONSTRAINT P_Parent_Child_P_Person_FKv1 FOREIGN KEY ( child_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Person ADD CONSTRAINT P_Person_P_Department_FK FOREIGN KEY ( dept_id ) REFERENCES P_Department ( dept_id ) ;

ALTER TABLE P_Person ADD CONSTRAINT P_Person_P_Person_FK FOREIGN KEY ( spouse_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Project ADD CONSTRAINT P_Project_P_Department_FK FOREIGN KEY ( dept_id ) REFERENCES P_Department ( dept_id ) ;

ALTER TABLE P_Project ADD CONSTRAINT P_Project_P_Person_FK FOREIGN KEY ( manager_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Project ADD CONSTRAINT P_Project_P_Project_FK FOREIGN KEY ( mp_id ) REFERENCES P_Project ( project_id ) ;

ALTER TABLE P_Projects ADD CONSTRAINT P_Projects_P_Person_FK FOREIGN KEY ( person_id ) REFERENCES P_Person ( person_id ) ;

ALTER TABLE P_Projects ADD CONSTRAINT P_Projects_P_Project_FK FOREIGN KEY ( project_id ) REFERENCES P_Project ( project_id ) ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
