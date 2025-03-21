DROP TABLE IF EXISTS question CASCADE;
DROP TABLE IF EXISTS quiz CASCADE;
DROP TABLE IF EXISTS study_plan CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS leaderboard CASCADE;
DROP TABLE IF EXISTS user_studyplan_enrollment CASCADE;




-- ===============================
-- 1. USERS TABLE
-- ===============================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'user' 
        CHECK (role IN ('user', 'admin'))
);






-- ===============================
-- 2. STUDY PLAN TABLE
-- ===============================
CREATE TABLE study_plan (
    studyplan_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES users(user_id) 
        ON UPDATE CASCADE ON DELETE CASCADE
);






-- ===============================
-- 2.a USER STUDY PLAN ENROLLMENT TABLE
-- ===============================
CREATE TABLE user_studyplan_enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    studyplan_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (studyplan_id) REFERENCES study_plan(studyplan_id) 
        ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE(user_id, studyplan_id)
);






-- ===============================
-- 3. QUIZ TABLE (Renamed time_taken -> time_limit)
-- ===============================
CREATE TABLE quiz (
    quiz_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    time_limit INT NOT NULL, -- Renamed column
    created_by INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES users(user_id) 
        ON UPDATE CASCADE ON DELETE CASCADE
);






-- ===============================
-- 4. QUESTION TABLE
-- ===============================
CREATE TABLE question (
    question_id SERIAL PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_answer CHAR(1) NOT NULL 
        CHECK (correct_answer IN ('A', 'B', 'C', 'D')),
    FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id) 
        ON UPDATE CASCADE ON DELETE CASCADE
);






-- ===============================
-- 5. LEADERBOARD TABLE (Added time_taken column)
-- ===============================
CREATE TABLE leaderboard (
    leaderboard_id SERIAL PRIMARY KEY,
    participation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quiz_id INT NOT NULL,
    user_id INT NOT NULL,
    UNIQUE (quiz_id, user_id),
    score INT NOT NULL CHECK (score >= 0),
    time_taken INT NOT NULL, -- New column: actual time taken by user in minutes
    FOREIGN KEY (quiz_id) REFERENCES quiz(quiz_id) 
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
        ON UPDATE CASCADE ON DELETE CASCADE
);






-- ============================
-- 1. INSERT USERS
-- ============================
INSERT INTO users (username, email, password, role) VALUES 
('admin', 'admin@gmail.com', 'admin123', 'admin');

INSERT INTO users (username, email, password) VALUES 
('aaa', 'aaa@gmail.com', '123'),
('bbb', 'bbb@gmail.com', '123'),
('ccc', 'ccc@gmail.com', '123');






-- ============================
-- 2. INSERT STUDY PLANS
-- ============================
INSERT INTO study_plan (name, created_by) VALUES 
('C Programming Basics', 1),
('C++ Advanced Concepts', 1),
('Java Fundamentals', 1),
('Python for Beginners', 1),
('Data Structures in C', 1);






-- ============================
-- 3. USER ENROLLMENTS
-- ============================
INSERT INTO user_studyplan_enrollment (user_id, studyplan_id) VALUES 
(2, 1), (2, 2), (2, 3),
(3, 1), (3, 4);






-- ============================
-- 4. INSERT QUIZZES (Updated column name to time_limit)
-- ============================
INSERT INTO quiz (title, created_by, time_limit) VALUES 
('C Language Concepts Quiz', 1, 15),  -- 15 minutes
('Java OOPs Quiz', 1, 20);            -- 20 minutes






-- ============================
-- 5. INSERT QUESTIONS
-- ============================
INSERT INTO question (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer) VALUES
(1, 'What is the correct syntax to declare a pointer?', 'int *ptr;', 'int ptr*;', 'ptr int*;', 'int pointer;', 'A'),
(1, 'Which of the following is used to exit from a loop immediately?', 'continue', 'break', 'exit', 'return', 'B'),
(1, 'Which header file is required for printf() function?', '<stdio.h>', '<stdlib.h>', '<conio.h>', '<string.h>', 'A'),
(1, 'Find the error: int main() { int x = 5; if(x = 10) { printf("Yes"); } }', 'No error', 'Assignment instead of comparison', 'Missing semicolon', 'Incorrect printf syntax', 'B'),
(1, 'Size of int in 64-bit architecture is:', '2 bytes', '4 bytes', '8 bytes', 'Depends on compiler', 'C'),

(2, 'Which keyword is used to inherit a class in Java?', 'extends', 'implements', 'inherits', 'super', 'A'),
(2, 'What is the default value of a boolean variable in Java?', 'true', 'false', '0', 'null', 'B'),
(2, 'Which concept allows multiple forms of a method in Java?', 'Inheritance', 'Polymorphism', 'Encapsulation', 'Abstraction', 'B'),
(2, 'Find the error: class Test { void main(String args[]) { System.out.println("Hello"); } }', 'No error', 'main method must be static', 'Incorrect print syntax', 'Missing class keyword', 'B'),
(2, 'Which of the following is not an access modifier in Java?', 'public', 'private', 'protected', 'default', 'D');






-- ============================
-- 6. INSERT LEADERBOARD RECORDS (Added time_taken values)
-- ============================
INSERT INTO leaderboard (quiz_id, user_id, score, time_taken) VALUES
(1, 2, 80, 12),  -- User completed quiz in 12 minutes
(2, 2, 85, 18),
(1, 3, 95, 14);







-- ================================================
-- SELECT QUERIES
-- ================================================

-- 1. Get ALL Study Plans
SELECT studyplan_id, name, created_at 
FROM study_plan;






-- 2. Get Study Plans Enrolled by Specific User (User2)
SELECT sp.studyplan_id, sp.name, sp.created_at 
FROM study_plan sp
JOIN user_studyplan_enrollment use ON sp.studyplan_id = use.studyplan_id
WHERE use.user_id = 2;






-- 3. Get ALL Quizzes (Updated to show time_limit)
SELECT quiz_id, title, time_limit, created_at 
FROM quiz;






-- 4. Get Quizzes Given by Specific User (User3) with time_taken
SELECT q.quiz_id, q.title, q.time_limit, lb.score, lb.participation_date, lb.time_taken
FROM quiz q
JOIN leaderboard lb ON q.quiz_id = lb.quiz_id
WHERE lb.user_id = 3;






-- 5. Global Leaderboard (Ordered by score, date, time_taken)
SELECT u.username, q.title, lb.score, lb.participation_date, q.time_limit, lb.time_taken
FROM leaderboard lb
JOIN users u ON lb.user_id = u.user_id
JOIN quiz q ON lb.quiz_id = q.quiz_id
ORDER BY lb.score DESC, lb.participation_date ASC, lb.time_taken ASC;
