-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 04_grant_readonly_access.sql
--
-- Purpose:
-- Grant read-only access on APP_OWNER.CUSTOMERS to the custom
-- APP_READONLY_ROLE and verify the role configuration.
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
-- 3. Grant SELECT privilege to the custom role
-- ------------------------------------------------------------

GRANT SELECT
ON app_owner.customers
TO app_readonly_role;


-- ------------------------------------------------------------
-- 4. Verify role assignment to APP_READER
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role,
    default_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
ORDER BY granted_role;


-- ------------------------------------------------------------
-- 5. Verify object privileges assigned to the role
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
-- 6. Verify APP_READER effective role
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
AND granted_role = 'APP_READONLY_ROLE';