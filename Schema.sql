

-- Create schema
CREATE SCHEMA School;

-- ========================================
-- STUDENTS TABLE
-- ========================================
CREATE TABLE School.Students (
  student_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email VARCHAR(100),
  gender TEXT
);

INSERT INTO School.Students (student_id, first_name, last_name, email, gender)
VALUES
(1,'Yvonne','Muli','muliyvonne@gmail.com','Female'),
(2,'John','Nganga','ngangajohn@gmail.com','Female'),
(3,'George','Mbugua','mbuguageorge@gmail.com','Female'),
(4,'Cate','Mwende','mwendecate@gmail.com','Female'),
(5,'Ann','Mueni','mueniann@gmail.com','Female');

-- ========================================
-- COURSES TABLE
-- ========================================
CREATE TABLE School.Courses (
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  credits INT CHECK (credits > 0)
);

INSERT INTO School.Courses (course_id, course_name, credits)
VALUES
(1, 'Mathematics', 3),
(2, 'Physics', 4),
(3, 'Chemistry', 3),
(4, 'Biology', 2),
(5, 'Computer Science', 5);

-- ========================================
-- ENROLLMENT TABLE
-- ========================================
CREATE TABLE School.Enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES School.Students(student_id),
  course_id INT REFERENCES School.Courses(course_id)
);

INSERT INTO School.Enrollment (enrollment_id, student_id, course_id)
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3);

-- ========================================
-- USERS TABLE (for Role-Based Access Control)
-- ========================================
CREATE TABLE School.Users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  role TEXT CHECK (role IN ('admin', 'user')) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Sample Users
INSERT INTO School.Users (email, role) VALUES
('admin@school.com', 'admin'),
('user@school.com', 'user');

-- ========================================
-- ROLE DEFINITIONS
-- ========================================
-- Admin Role:
--  - Full access (READ, INSERT, UPDATE, DELETE) to all tables
--  - Can manage all records and perform admin-level operations
--
-- User Role:
--  - Restricted access
--  - Can only READ and INSERT their own data
--  - Cannot modify or view other users’ data

-- ========================================
-- ENABLE ROW LEVEL SECURITY (RLS)
-- ========================================
ALTER TABLE School.Enrollment ENABLE ROW LEVEL SECURITY;

-- ========================================
-- SUPABASE RLS POLICIES
-- ========================================

-- 🔹 Policy: Users can only view their own enrollments
CREATE POLICY "Users can view their own enrollments"
ON School.Enrollment
FOR SELECT
USING (
  auth.uid() = (
    SELECT id FROM School.Users WHERE email = auth.email() AND role = 'user'
  )
);

-- 🔹 Policy: Users can insert their own enrollments
CREATE POLICY "Users can insert their own enrollments"
ON School.Enrollment
FOR INSERT
WITH CHECK (
  auth.uid() = (
    SELECT id FROM School.Users WHERE email = auth.email() AND role = 'user'
  )
);

-- 🔹 Policy: Admins have full access to all enrollments
CREATE POLICY "Admins have full access to enrollments"
ON School.Enrollment
FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM School.Users WHERE id = auth.uid() AND role = 'admin'
  )
);

-- ========================================
-- 🔍 EXAMPLE POLICY SYNTAX REFERENCES
-- ========================================

-- Example policy: Users can only see their own tasks
-- (You can adapt this for any table, e.g. Enrollment)
-- create policy "Users can view their own tasks"
-- on tasks
-- for select
-- using (auth.uid() = user_id);

-- Example policy: Admins can manage all tasks
-- create policy "Admins have full access to tasks"
-- on tasks
-- for all
-- using (exists (
--   select 1 from users where id = auth.uid() and role = 'admin'
-- ));

-- ========================================
-- NOTES
-- ========================================
-- ✅ 'Users' table manages authentication roles
-- ✅ RLS enabled on Enrollment table
-- ✅ Supabase injects auth.uid() and auth.email() for logged-in users
-- ✅ Admins can perform all operations
-- ✅ Users limited to their own records only
