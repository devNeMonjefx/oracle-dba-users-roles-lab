-- ============================================================
-- Oracle DBA Lab
-- Users, Roles & Privileges
--
-- File: 05_test_permissions.sql
--
-- Purpose:
-- Validate that APP_READER has read-only access to
-- APP_OWNER.CUSTOMERS through APP_READONLY_ROLE.
--
-- Run this script as APP_READER inside XEPDB1.
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
-- 3. Test SELECT privilege
-- Expected result: SUCCESS
-- ------------------------------------------------------------

SELECT
    customer_id,
    full_name,
    email,
    created_at
FROM app_owner.customers
ORDER BY customer_id;


-- ------------------------------------------------------------
-- 4. Test INSERT privilege
-- Expected result: FAILURE
-- APP_READER should not have INSERT permission.
-- ------------------------------------------------------------

INSERT INTO app_owner.customers (
    full_name,
    email
)
VALUES (
    'Reader Test',
    'reader.test@example.com'
);


-- ------------------------------------------------------------
-- 5. Test UPDATE privilege
-- Expected result: FAILURE
-- APP_READER should not have UPDATE permission.
-- ------------------------------------------------------------

UPDATE app_owner.customers
SET full_name = 'Modified By Reader'
WHERE customer_id = 1;


-- ------------------------------------------------------------
-- 6. Test DELETE privilege
-- Expected result: FAILURE
-- APP_READER should not have DELETE permission.
-- ------------------------------------------------------------

DELETE FROM app_owner.customers
WHERE customer_id = 1;