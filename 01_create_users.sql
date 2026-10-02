-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 01_create_users.sql
--
-- Purpose:
-- Create two application users for the laboratory:
--
-- APP_OWNER
--   Owns application objects such as tables and views.
--
-- APP_READER
--   Read-only application user that will receive access
--   through a custom role later in the lab.
--
-- Run this script as LAB_DBA inside XEPDB1.
-- ============================================================


-- ------------------------------------------------------------
-- 1. Verify current user
-- ------------------------------------------------------------

SELECT USER
FROM dual;


-- ------------------------------------------------------------
-- 2. Verify current container
-- ------------------------------------------------------------

SHOW CON_NAME;


-- ------------------------------------------------------------
-- 3. Create APP_OWNER
-- ------------------------------------------------------------

CREATE USER app_owner
IDENTIFIED BY YourAppOwnerPasswordHere;


-- ------------------------------------------------------------
-- 4. Create APP_READER
-- ------------------------------------------------------------

CREATE USER app_reader
IDENTIFIED BY YourAppReaderPasswordHere;


-- ------------------------------------------------------------
-- 5. Allow both users to connect
-- ------------------------------------------------------------

GRANT CREATE SESSION TO app_owner;

GRANT CREATE SESSION TO app_reader;


-- ------------------------------------------------------------
-- 6. Grant object creation privileges to APP_OWNER
-- ------------------------------------------------------------

GRANT CREATE TABLE TO app_owner;

GRANT CREATE VIEW TO app_owner;

GRANT CREATE SEQUENCE TO app_owner;


-- ------------------------------------------------------------
-- 7. Assign storage quota to APP_OWNER
-- ------------------------------------------------------------

ALTER USER app_owner
QUOTA 50M ON USERS;


-- ------------------------------------------------------------
-- 8. Verify created users
-- ------------------------------------------------------------

SELECT
    username,
    account_status,
    default_tablespace,
    temporary_tablespace
FROM dba_users
WHERE username IN (
    'APP_OWNER',
    'APP_READER'
)
ORDER BY username;


-- ------------------------------------------------------------
-- 9. Verify system privileges
-- ------------------------------------------------------------

SELECT
    grantee,
    privilege
FROM dba_sys_privs
WHERE grantee IN (
    'APP_OWNER',
    'APP_READER'
)
ORDER BY grantee, privilege;


-- ------------------------------------------------------------
-- 10. Verify APP_OWNER quota
-- ------------------------------------------------------------

SELECT
    username,
    tablespace_name,
    bytes,
    max_bytes
FROM dba_ts_quotas
WHERE username = 'APP_OWNER';