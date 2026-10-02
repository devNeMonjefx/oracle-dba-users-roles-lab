-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 06_manage_account_status.sql
--
-- Purpose:
-- Demonstrate user account administration by locking and
-- unlocking APP_READER and verifying its account status.
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
-- 3. Check initial APP_READER status
-- ------------------------------------------------------------

SELECT
    username,
    account_status
FROM dba_users
WHERE username = 'APP_READER';


-- ------------------------------------------------------------
-- 4. Lock APP_READER account
-- ------------------------------------------------------------

ALTER USER app_reader
ACCOUNT LOCK;


-- ------------------------------------------------------------
-- 5. Verify locked status
-- ------------------------------------------------------------

SELECT
    username,
    account_status
FROM dba_users
WHERE username = 'APP_READER';


-- ------------------------------------------------------------
-- 6. Unlock APP_READER account
-- ------------------------------------------------------------

ALTER USER app_reader
ACCOUNT UNLOCK;


-- ------------------------------------------------------------
-- 7. Verify unlocked status
-- ------------------------------------------------------------

SELECT
    username,
    account_status
FROM dba_users
WHERE username = 'APP_READER';