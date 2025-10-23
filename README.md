
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
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [❓ FAQ](#faq)
- [📝 License](#license)

---

# 📖 School Database Project <a name="about-project"></a>

The *School Database Project* is a simple relational database designed to manage student information, courses, and enrollments.  
It demonstrates the use of SQL fundamentals including table creation, foreign key relationships, and data integrity using Supabase (PostgreSQL).

This project was developed as part of the *Data Fundamentals Final Project*, showcasing a practical understanding of database design and management.

---

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Backend as a Service</summary>
  <ul>
    <li><a href="https://supabase.com/">Supabase</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL 15+</a></li>
  </ul>
</details>

---

### Key Features <a name="key-features"></a>

- *📚 Student Management:* Store and manage student details  
- *🎓 Course Catalog:* Maintain course names and credits  
- *🧾 Enrollment Tracking:* Link students to the courses they’re enrolled in  
- *🔗 Foreign Key Relationships:* Demonstrates real-world relational modeling  
- *💾 Supabase Implementation:* Built and tested using Supabase’s SQL editor  

---

## 💻 Getting Started <a name="getting-started"></a>

This project is designed to be deployed and tested on *Supabase*.

### Prerequisites

- A [Supabase account](https://supabase.com/) (free tier is fine)  
- Basic SQL knowledge  
- Internet connection

---

### Setup

1. *Create a Supabase Project*
   - Go to [Supabase Dashboard](https://app.supabase.com/)
   - Click *New Project*
   - Name it *School*
   - Open the *SQL Editor*

2. *Copy and Paste the Schema*
   - Run the contents of your schema.sql file in the SQL editor

---

### Install

No installation required. The SQL commands can be executed directly in the Supabase SQL editor.

---

### Usage

Once your tables are created and sample data inserted, you can run basic SQL queries such as:

sql
-- View all students
SELECT * FROM Students;

-- View all courses
SELECT * FROM Courses;

-- View all enrollments
SELECT * FROM Enrollment;

-- Join students with the courses they are enrolled in
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;


⸻

📊 Database Structure 

🧍 Students Table

Column	Type	Description
student_id	SERIAL PRIMARY KEY	Unique student identifier
first_name	TEXT	Student’s first name
last_name	TEXT	Student’s last name
email	VARCHAR	Student email address
gender	TEXT	Gender of the student


⸻

📘 Courses Table

Column	Type	Description
course_id	INT PRIMARY KEY	Unique course identifier
course_name	VARCHAR(100)	Name of the course
credits	INT	Number of credit hours (must be > 0)


⸻

🧾 Enrollment Table

Column	Type	Description
enrollment_id	SERIAL PRIMARY KEY	Unique enrollment ID
student_id	INT	Linked to Students table
course_id	INT	Linked to Courses table


⸻

🔐 Security Implementation 
	•	Primary Keys ensure every record is unique.
	•	Foreign Keys maintain referential integrity between tables.
	•	CHECK Constraints (e.g., credits > 0) enforce valid data entry.
	•	Supabase Policies (optional): Can be added to restrict access by role or user.

⸻

👥 Authors 

👤 Yvonne Muli
	•	GitHub: @yvonne-muli

⸻

🔭 Future Features 

Planned improvements include:
	•	Adding a Teachers table to manage instructors
	•	Adding Grades for enrolled courses
	•	Adding Attendance Tracking
	•	Implementing Row Level Security (RLS) for user access control

⸻

🤝 Contributing 

Contributions, issues, and feature requests are welcome!
Feel free to fork the project or open an issue for discussion.

⸻

⭐ Show your support 

If you found this project helpful in understanding basic database relationships, please give it a ⭐ on GitHub!

⸻

🙏 Acknowledgements 
	•	Thanks to the Supabase team for their user-friendly SQL interface
	•	PostgreSQL community for excellent documentation
	•	Data Fundamentals instructors for guiding this project

⸻

❓ FAQ 

Q: Why do I need foreign keys?
A: They link related tables and prevent orphaned records in relational databases.

Q: Can I add more sample data?
A: Yes, you can use INSERT INTO statements to add more students, courses, or enrollments.

Q: How do I view students with their courses?
A: Run a SQL JOIN query combining the Students, Courses, and Enrollment tables (see example above).

⸻

📝 License 

This project is open source and available under the MIT License




⸻

Would you like me to also generate the matching data_dictionary.md next — formatted the same way (with a table for Students, Courses, and Enrollment)? It will go in your /docs/ folder to complete your submission.
