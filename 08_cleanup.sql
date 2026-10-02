-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 08_cleanup.sql
--
-- Purpose:
-- Remove the users and role created specifically for this lab.
--
-- Run this script as LAB_DBA inside XEPDB1.
--
-- NOTE:
-- LAB_DBA is intentionally NOT removed here because it can be
-- reused for future Oracle DBA labs.
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
-- 3. Verify objects before cleanup
-- ------------------------------------------------------------

SELECT
    username,
    account_status
FROM dba_users
WHERE username IN (
    'APP_OWNER',
    'APP_READER'
)
ORDER BY username;


SELECT
    role
FROM dba_roles
WHERE role = 'APP_READONLY_ROLE';


-- ------------------------------------------------------------
-- 4. Drop APP_READER
-- ------------------------------------------------------------

DROP USER app_reader CASCADE;


-- ------------------------------------------------------------
-- 5. Drop APP_OWNER
-- ------------------------------------------------------------

DROP USER app_owner CASCADE;


-- ------------------------------------------------------------
-- 6. Drop custom role
-- ------------------------------------------------------------

DROP ROLE app_readonly_role;


-- ------------------------------------------------------------
-- 7. Verify cleanup
-- ------------------------------------------------------------

SELECT
    username
FROM dba_users
WHERE username IN (
    'APP_OWNER',
    'APP_READER'
);


SELECT
    role
FROM dba_roles
WHERE role = 'APP_READONLY_ROLE';