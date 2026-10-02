# Oracle DBA Lab — Users, Roles & Privileges

Hands-on Oracle Database administration laboratory focused on user management, role-based access control, system privileges, object privileges and account administration.

This lab was created to practice core Junior DBA tasks using Oracle Database 21c XE.

---

## Objectives

The main goals of this laboratory are:

- Create and manage Oracle database users.
- Create custom roles.
- Assign system privileges.
- Assign object privileges.
- Implement role-based access control.
- Test allowed and denied operations.
- Lock and unlock database accounts.
- Audit users, roles and privileges using DBA catalog views.
- Practice separation of responsibilities between administrative and application accounts.

---

## Environment

- Oracle Database 21c XE
- Pluggable Database: `XEPDB1`
- SQL
- Oracle DBA catalog views

---

## Architecture

The laboratory uses four main security identities:

```text
SYSTEM
   │
   │ Initial provisioning only
   ▼
LAB_DBA
   │
   ├── Manages users
   ├── Manages roles
   ├── Audits privileges
   └── Manages account status
          │
          ├───────────────┐
          ▼               ▼
     APP_OWNER       APP_READER
          │               │
          │               │ receives
          │               ▼
          │        APP_READONLY_ROLE
          │               ▲
          │               │
          └── SELECT ─────┘
              on
       APP_OWNER.CUSTOMERS