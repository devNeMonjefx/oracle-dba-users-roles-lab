-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 07_audit_user_privileges.sql
--
-- Purpose:
-- Audit APP_READER privileges, roles and object access.
--
-- This script verifies:
--   - User account status
--   - Directly granted roles
--   - Direct system privileges
--   - Object privileges granted through APP_READONLY_ROLE
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
-- 3. Verify APP_READER account status
-- ------------------------------------------------------------

SELECT
    username,
    account_status,
    default_tablespace,
    temporary_tablespace
FROM dba_users
WHERE username = 'APP_READER';


-- ------------------------------------------------------------
-- 4. Verify roles assigned directly to APP_READER
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role,
    admin_option,
    default_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
ORDER BY granted_role;


-- ------------------------------------------------------------
-- 5. Verify direct system privileges
-- ------------------------------------------------------------

SELECT
    grantee,
    privilege,
    admin_option
FROM dba_sys_privs
WHERE grantee = 'APP_READER'
ORDER BY privilege;


-- ------------------------------------------------------------
-- 6. Verify object privileges assigned to APP_READER directly
-- ------------------------------------------------------------

SELECT
    grantee,
    owner,
    table_name,
    privilege,
    grantable
FROM dba_tab_privs
WHERE grantee = 'APP_READER'
ORDER BY owner, table_name, privilege;


-- ------------------------------------------------------------
-- 7. Verify privileges assigned to APP_READONLY_ROLE
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
-- 8. Verify that APP_READER receives APP_READONLY_ROLE
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role,
    default_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
AND granted_role = 'APP_READONLY_ROLE';


-- ------------------------------------------------------------
-- 9. Audit summary
-- ------------------------------------------------------------

SELECT
    'APP_READER' AS username,
    'CREATE SESSION' AS access_type,
    'DIRECT SYSTEM PRIVILEGE' AS source
FROM dual

UNION ALL

SELECT
    'APP_READER',
    granted_role,
    'ROLE'
FROM dba_role_privs
WHERE grantee = 'APP_READER'

UNION ALL

SELECT
    'APP_READER',
    privilege || ' ON ' || owner || '.' || table_name,
    'THROUGH APP_READONLY_ROLE'
FROM dba_tab_privs
WHERE grantee = 'APP_READONLY_ROLE';