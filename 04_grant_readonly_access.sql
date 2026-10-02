-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 04_grant_readonly_access.sql
--
-- Purpose:
-- Grant read-only access on APP_OWNER.CUSTOMERS
-- to APP_READONLY_ROLE.
--
-- Run this script as APP_OWNER inside XEPDB1.
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
ON customers
TO app_readonly_role;