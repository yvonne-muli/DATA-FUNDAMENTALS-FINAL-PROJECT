
# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Database Structure](#database-structure)
- [🔐 Security Implementation](#security)
  - [User Roles](#user-roles)
  - [Row Level Security Policies](#row-level-security-policies)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [❓ FAQ](#faq)
- [📝 License](#license)

---

# 📖 School Database Project <a name="about-project"></a>

The *School Database Project* is a relational database designed to manage student information, courses, and enrollments. It demonstrates SQL fundamentals including table creation, relationships, and Row Level Security (RLS) using *Supabase* (PostgreSQL).  

This project is part of the *Data Fundamentals* course, showcasing database design, data population, and secure data access using Admin/User roles.

---

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Database Platform</summary>
  <ul>
    <li><a href="https://supabase.com/">Supabase (PostgreSQL)</a></li>
  </ul>
</details>

<details>
  <summary>Security</summary>
  <ul>
    <li>Row Level Security (RLS)</li>
    <li>Role-Based Access Control (RBAC)</li>
  </ul>
</details>

### Key Features <a name="key-features"></a>

- 📘 *Three-Table Schema*: Students, Courses, and Enrollments  
- 🔗 *Foreign Key Relationships*: Students linked to their enrollments and courses  
- 🔐 *Role-Based Access*: Admin and User roles with specific permissions  
- 🛡 *Row Level Security*: Data isolation based on user roles  
- 💾 *Sample Data*: Includes 5+ sample rows per table  

---

## 💻 Getting Started <a name="getting-started"></a>

This project is designed to run on *Supabase*, a PostgreSQL-based backend as a service.

### Prerequisites

You need:  
- A [Supabase](https://supabase.com/) account (free tier works)  
- Basic knowledge of SQL  
- Access to the Supabase SQL Editor  

### Setup

1. Go to [Supabase Dashboard](https://app.supabase.com/)  
2. Create a *new project*  
3. Open the *SQL Editor* tab  

### Install

1. Copy the contents of [schema.sql](./schema.sql)  
2. Paste it in Supabase SQL Editor and run it  
3. Verify that the following tables are created:  
   - Students  
   - Courses  
   - Enrollment  
   - Users  

### Usage

Once the database is created, you can:  
- Query all tables using SQL  
- View existing relationships between students and courses  
- Test RLS by creating users with different roles (Admin/User)  

Example query:
```sql
SELECT s.first_name, s.last_name, c.course_name
FROM School.Students s
JOIN School.Enrollment e ON s.student_id = e.student_id
JOIN School.Courses c ON c.course_id = e.course_id;


⸻

🗄 Database Structure 

Students Table

Column	Type	Description
student_id	SERIAL	Primary key
first_name	TEXT	Student’s first name
last_name	TEXT	Student’s last name
email	VARCHAR	Email address
gender	TEXT	Student’s gender

Courses Table

Column	Type	Description
course_id	SERIAL	Primary key
course_name	VARCHAR(100)	Name of the course
credits	INT	Number of credits (must be > 0)

Enrollment Table

Column	Type	Description
enrollment_id	SERIAL	Primary key
student_id	INT	Foreign key referencing Students
course_id	INT	Foreign key referencing Courses

Users Table

Column	Type	Description
id	UUID	Primary key
email	TEXT	User email
role	TEXT	Either ‘admin’ or ‘user’
created_at	TIMESTAMP	Record creation timestamp


⸻

🔐 Security Implementation 

This project includes Role-Based Access Control (RBAC) and Row Level Security (RLS) to restrict access depending on the user’s role.

User Roles 

👩‍💼 Admin Role
	•	Full access: can read, insert, update, and delete all records
	•	Can manage students, courses, enrollments, and users

👩‍🎓 User Role
	•	Restricted access: can read and insert only their own data
	•	Cannot modify or view other users’ data

These roles are defined in the Users table and can be enforced through Supabase RLS.

⸻

🔒 Row Level Security Policies 

RLS ensures each user can only access the data they own.

-- Enable Row Level Security
ALTER TABLE School.Enrollment ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their own enrollments
CREATE POLICY "Users can view their own enrollments"
ON School.Enrollment
FOR SELECT
USING (
  auth.uid() = (
    SELECT id FROM School.Users WHERE email = auth.email() AND role = 'user'
  )
);

-- Policy: Users can insert their own enrollments
CREATE POLICY "Users can insert their own enrollments"
ON School.Enrollment
FOR INSERT
WITH CHECK (
  auth.uid() = (
    SELECT id FROM School.Users WHERE email = auth.email() AND role = 'user'
  )
);

-- Policy: Admins have full access to enrollments
CREATE POLICY "Admins have full access to enrollments"
ON School.Enrollment
FOR ALL
USING (
  EXISTS (
    SELECT 1 FROM School.Users WHERE id = auth.uid() AND role = 'admin'
  )
);


⸻

👥 Authors 

👤 Yvonne Muli
	•	GitHub: @yvonne-muli

⸻

🔭 Future Features 
	•	Add a Grades table to store student marks
	•	Build Supabase authentication for sign-up/login
	•	Create admin dashboards to visualize enrollments
	•	Add audit logging for data changes

⸻

🤝 Contributing 

Contributions, issues, and feature requests are welcome!
Feel free to open an issue or a pull request.

⸻

⭐ Show your support 

If you found this project useful for learning database fundamentals or RLS, please give it a ⭐ on GitHub!

⸻

🙏 Acknowledgements 
	•	Thanks to the Supabase team for great RLS documentation
	•	PostgreSQL community for robust data integrity features
	•	Data Fundamentals instructors 
