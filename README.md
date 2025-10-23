# DATA-FUNDAMENTALS-FINAL-PROJECT
# 📘 Data Fundamentals Final Project

## 1. Project Overview
This project  demonstrates how to design a relational database, implement user roles, apply security policies, and create admin functions using *Supabase*.

The project includes three main tables that are linked together through relationships to represent real-world data interactions.

---

## 2. Database Structure

### Tables
- *Students* – stores information about students  
- *Courses* – stores information about available courses  
- *Enrollments* – links students to the courses they are enrolled in

### Relationships
- A student can enroll in many courses  
- A course can have many students  
- The Enrollments table connects both using foreign keys

### ERD Diagram
Below is the Entity Relationship Diagram (ERD) that shows how the tables are related:

<img width="373" height="456" alt="image" src="https://github.com/user-attachments/assets/a041a1d8-9607-468f-aef6-eda8045129c7" />


---

## 3. Roles and Permissions

Two database roles were created to manage access control:

| Role | Description | Permissions |
|------|--------------|-------------|
| *Admin* | Has full access to all tables | SELECT, INSERT, UPDATE, DELETE |
| *App_user* | Limited user role for general users | SELECT only |

SQL used:
```sql
CREATE ROLE admin;
CREATE ROLE app_user;

GRANT USAGE ON SCHEMA public TO admin, app_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO app_user;



 Row-Level Security (RLS) and Policies

Row-Level Security (RLS) was enabled to control which rows a user can access in each table.

Example: Enabling RLS
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;

EXANPLE POLICIES
-- Allow all users to view data
CREATE POLICY "Allow read access to all users"
ON students
FOR SELECT
USING (true);

-- Allow admins full control
CREATE POLICY "Admin full access"
ON students
FOR ALL
USING (auth.role() = 'admin');

EXPLANATION;
.App user can only view data (SELECT)
.Admin can view,insert,update and delete records


Custom Admin Function

A custom SQL function was created to perform admin-only tasks such as deleting or updating records securely.

Example Function

CREATE OR REPLACE FUNCTION delete_student(student_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM students WHERE id = student_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

Note
SECURITY DEFINER ensures that only admins can execute this function even if normal users can see it

Sample Data

Example records inserted into the tables for testing:

-- Students
INSERT INTO students (id, name, email) VALUES
(1, 'Yvonne Muli', 'yvonne@example.com'),
(2, 'Joy Smith', 'joy@example.com');

-- Courses
INSERT INTO courses (id, course_name, instructor) VALUES
(1, 'Database Fundamentals', 'Dr. Joy'),
(2, 'Data Visualization', 'Prof. Atieno');

-- Enrollments
INSERT INTO enrollments (id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2);

How to set up the project
1.Clone this repository
git clone https://github.com/<yvonne-muli>/<data-fundamentals-final-project>.git

2.Open your supabase project
3.Go to the SQL Editor
4.Run the SQL code from schema.sql to create the database
5.Upload the ERD image inside / docs /erd_diag
6.Check that roles,RLS,and functions work correctly

Security Notes
	•	RLS Enabled: All tables have row-level security turned on
	•	Policies: Define access control for different roles
	•	Admin Function: Restricted to users with the admin role
	•	Public Schema: Access limited to admin and app_user roles only

Author

Name: Yvonne Muli











