CREATE DATABASE student_db;
USE student_db;
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(50)
);
INSERT INTO students (name, course) VALUES
('Alice', 'Computer Science'),
('Bob', 'Information Technology'),
('Charlie', 'Software Engineering');
