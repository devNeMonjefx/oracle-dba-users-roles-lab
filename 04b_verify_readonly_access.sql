-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 04b_verify_readonly_access.sql
--
-- Purpose:
-- Verify the role assignment and object privileges
-- configured for APP_READER.
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
-- 3. Verify role assignment to APP_READER
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role,
    default_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
ORDER BY granted_role;


-- ------------------------------------------------------------
-- 4. Verify object privileges assigned to the role
-- ------------------------------------------------------------

SELECT
    grantee,
    owner,
    table_name,
    privilege,
    grantable
FROM dba_tab_privs
WHERE grantee = 'APP_READONLY_ROLE'
ORDER BY owner, table_name, privilege;


-- ------------------------------------------------------------
-- 5. Verify APP_READER receives APP_READONLY_ROLE
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
AND granted_role = 'APP_READONLY_ROLE';