CREATE DATABASE IF NOT EXISTS attendance_db;
USE attendance_db;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    course VARCHAR(60) NOT NULL,
    semester INT NOT NULL,
    email VARCHAR(120),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT') NOT NULL,
    marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id)
        REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT uq_student_attendance_date UNIQUE (student_id, attendance_date)
);

-- Sample records so the application can be demonstrated immediately.
INSERT IGNORE INTO students (roll_no, name, course, semester, email) VALUES
('MCA001', 'Aarav Sharma', 'MCA', 1, 'aarav@example.com'),
('MCA002', 'Diya Verma', 'MCA', 1, 'diya@example.com'),
('MCA003', 'Rohan Mehta', 'MCA', 1, 'rohan@example.com'),
('MCA004', 'Ananya Kapoor', 'MCA', 1, 'ananya@example.com'),
('MCA005', 'Kabir Singh', 'MCA', 1, 'kabir@example.com');
