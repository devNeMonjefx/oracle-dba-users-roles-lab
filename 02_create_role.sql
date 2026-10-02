-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 02_create_role.sql
--
-- Purpose:
-- Create a custom role that will be used to provide
-- read-only access to application objects.
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
-- 3. Create custom read-only role
-- ------------------------------------------------------------

CREATE ROLE app_readonly_role;


-- ------------------------------------------------------------
-- 4. Assign the role to APP_READER
-- ------------------------------------------------------------

GRANT app_readonly_role
TO app_reader;


-- ------------------------------------------------------------
-- 5. Verify role creation
-- ------------------------------------------------------------

SELECT
    role
FROM dba_roles
WHERE role = 'APP_READONLY_ROLE';


-- ------------------------------------------------------------
-- 6. Verify role assignment
-- ------------------------------------------------------------

SELECT
    grantee,
    granted_role,
    default_role
FROM dba_role_privs
WHERE grantee = 'APP_READER'
ORDER BY granted_role;