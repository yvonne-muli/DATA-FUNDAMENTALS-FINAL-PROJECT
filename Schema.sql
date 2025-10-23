

CREATE TABLE School.Students (
  student_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email VARCHAR,
  gender TEXT
);

INSERT INTO School.Students(student_id,first_name,last_name,email,gender)
values
(1,'Yvonne','Muli','muliyvonne@gmail.com','Female'),
(2,'John','Nganga','ngangajohn@gmail.com','Female'),
(3,'George','Mbugua','mbuguageorge@gmail.com','Female'),
(4,'Cate','Mwende','mwendecate@gmail.com','Female'),
(5,'Ann','Mueni','mueniann@gmail.com','Female');

CREATE TABLE School.Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0)
);
INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Mathematics', 3),
(2, 'Physics', 4),
(3, 'Chemistry', 3),
(4, 'Biology', 2),
(5, 'Computer Science', 5);


CREATE TABLE Enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT,
  course_id INT 
);

INSERT INTO Enrollment(enrollment_id,student_id,course_id)
VALUES 
(1,1,2),
(2,2,1),
(3,3,3)



