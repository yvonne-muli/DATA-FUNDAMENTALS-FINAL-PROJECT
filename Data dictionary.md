# Data Dictionary

## Project Overview
This project represents a simple school management system that tracks students, the courses they take, and their enrollments.  
The database includes three main tables: *Students, **Courses, and **Enrollment*, each with sample data to demonstrate relationships.

---

## Table: Students
*Description:* Stores information about all students in the school.

| Column Name | Data Type | Description | Example |
|--------------|------------|--------------|----------|
| student_id | INT (PK) | Unique identifier for each student | 1 |
| first_name | VARCHAR | Student’s first name | Yvonne |
| last_name | VARCHAR | Student’s last name | Muli |
| email | VARCHAR | Student’s email address | muliyvonne@gmail.com |
| gender | VARCHAR | Student’s gender | Female |

---

## Table: Courses
*Description:* Stores information about courses offered in the school.

| Column Name | Data Type | Description | Example |
|--------------|------------|--------------|----------|
| course_id | INT (PK) | Unique identifier for each course | 1 |
| course_name | VARCHAR | Name of the course | Mathematics |
| credits | INT | Number of credit hours for the course | 3 |

---

## Table: Enrollment
*Description:* Records which students are enrolled in which courses.

| Column Name | Data Type | Description | Example |
|--------------|------------|--------------|----------|
| enrollment_id | INT (PK) | Unique enrollment record ID | 1 |
| student_id | INT (FK) | References the student enrolled | 1 |
| course_id | INT (FK) | References the course enrolled in | 2 |

---

## Relationships
- Each *student* can be enrolled in *many courses*.  
- Each *course* can have *many students* enrolled.  
- student_id in Enrollment references Students.student_id  
- course_id in Enrollment references Courses.course_id

---

### Notes
- The database follows a *many-to-many* relationship between Students and Courses, implemented through the Enrollment table.  
- This structure makes it easy to track which students are taking which courses.
