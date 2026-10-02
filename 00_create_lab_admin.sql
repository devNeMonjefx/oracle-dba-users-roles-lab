-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 00_create_lab_admin.sql
--
-- Purpose:
-- Create a dedicated administrative account for the lab.
-- This avoids using SYS for routine laboratory tasks.
--
-- Run this script as SYSTEM inside XEPDB1.
-- ============================================================


-- ------------------------------------------------------------
-- 1. Verify current container
-- ------------------------------------------------------------

SHOW CON_NAME;


-- ------------------------------------------------------------
-- 2. Create dedicated lab administrator
-- ------------------------------------------------------------

CREATE USER lab_dba
IDENTIFIED BY YourLabPasswordHere;


-- ------------------------------------------------------------
-- 3. Allow login
-- ------------------------------------------------------------

GRANT CREATE SESSION TO lab_dba;


-- ------------------------------------------------------------
-- 4. User administration privileges
-- ------------------------------------------------------------

GRANT CREATE USER TO lab_dba;
GRANT ALTER USER TO lab_dba;
GRANT DROP USER TO lab_dba;


-- ------------------------------------------------------------
-- 5. Role administration privileges
-- ------------------------------------------------------------

GRANT CREATE ROLE TO lab_dba;
GRANT DROP ANY ROLE TO lab_dba;
GRANT GRANT ANY ROLE TO lab_dba;


-- ------------------------------------------------------------
-- 6. Privilege administration
-- ------------------------------------------------------------

GRANT GRANT ANY PRIVILEGE TO lab_dba;


-- ------------------------------------------------------------
-- 7. Object creation privileges
-- ------------------------------------------------------------

GRANT CREATE TABLE TO lab_dba;
GRANT CREATE VIEW TO lab_dba;
GRANT CREATE SEQUENCE TO lab_dba;


-- ------------------------------------------------------------
-- 8. Access to DBA catalog views
-- ------------------------------------------------------------

GRANT SELECT_CATALOG_ROLE TO lab_dba;


-- ------------------------------------------------------------
-- 9. Verify created user
-- ------------------------------------------------------------

SELECT
    username,
    account_status,
    default_tablespace,
    temporary_tablespace
FROM dba_users
WHERE username = 'LAB_DBA';


-- ------------------------------------------------------------
-- 10. Verify system privileges
-- ------------------------------------------------------------

SELECT
    grantee,
    privilege
FROM dba_sys_privs
WHERE grantee = 'LAB_DBA'
ORDER BY privilege;


-- ------------------------------------------------------------
-- 11. Verify assigned roles
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role
FROM dba_role_privs
WHERE grantee = 'LAB_DBA'
ORDER BY granted_role;