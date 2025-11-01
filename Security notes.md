

# 🔐 Security Notes

## 🧩 Overview

This document outlines the *security structure* and *access control policies* implemented in the *School Management Database*.  
The database includes three core tables:

- Students
- Courses
- Enrollment

It follows the *principle of least privilege*, ensuring that users only have access to the data and operations they need.

---

## 👥 User Roles

The database defines two main roles for managing data access:

| Role | Description | Permissions |
|------|--------------|--------------|
| *Admin* | Full system access | Can insert, update, delete, and view all records |
| *Student* | Limited access | Can view their own records and enrolled courses only |

---

## 🔑 Role Permissions

### *Admin Role*
Admins are responsible for maintaining the integrity of the database and managing data consistency.

*Permissions:*
- Create, update, or delete student records  
- Create or delete courses  
- Manage enrollments  
- Run maintenance queries (e.g., backups, audits)  
- View all tables in the database  

*SQL Example:*
```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA School TO admin;


⸻

Student Role

Students have restricted privileges to ensure data privacy and prevent unauthorized changes.

Permissions:
	•	View their own profile in the Students table
	•	View all available courses in the Courses table
	•	View only their enrollments in the Enrollment table
	•	Cannot insert, update, or delete any data

SQL Example:

GRANT SELECT ON School.Courses TO student;
GRANT SELECT ON School.Students TO student;
GRANT SELECT ON School.Enrollment TO student;


⸻

🧱 Row-Level Security (RLS)

To further restrict data visibility for students, Row-Level Security (RLS) can be enabled on the Enrollment table.
This ensures each student only sees their own enrollment records.

Enable RLS

ALTER TABLE School.Enrollment ENABLE ROW LEVEL SECURITY;

Create Policy

CREATE POLICY student_enrollment_policy
ON School.Enrollment
FOR SELECT
USING (student_id = current_setting('app.current_student_id')::INT);

🔸 This policy filters rows dynamically based on the logged-in student’s ID.

⸻

🧮 Example Scenario

User	Action	Allowed?	Reason
Admin	View all students	✅	Has full access
Admin	Add a new course	✅	Can insert records
Student (ID 3)	View their enrollments	✅	Matches their student ID
Student (ID 3)	View enrollments of another student	❌	Blocked by RLS
Student (ID 3)	Add a new course	❌	No INSERT privilege


⸻

🧰 Audit Recommendations

For additional security and traceability:
	•	Enable query logging to track changes and failed access attempts
	•	Create an audit log table for admin-level modifications
	•	Regularly back up the database and test restore procedures
	•	Review user roles periodically to prevent privilege creep

Example audit trigger:

CREATE TABLE School.audit_log (
  log_id SERIAL PRIMARY KEY,
  table_name TEXT,
  operation TEXT,
  changed_by TEXT,
  changed_at TIMESTAMP DEFAULT NOW()
);


⸻

⚙ Future Security Enhancements
	•	Implement hashed student passwords (if authentication is added)
	•	Add two-factor authentication for admin logins
	•	Enforce data validation rules through stored procedures
	•	Implement view-based access for students instead of direct table queries

⸻

✅ Summary

Area	Implemented	Description
User roles	✅	Admin & Student
Row-level security	✅	Active on Enrollment table
Data isolation	✅	Students see only their own data
Privilege control	✅	Restricted access for non-admins
Audit mechanism	⚙ Planned	For future updates



Author:
👩‍💻 Yvonne Muli


