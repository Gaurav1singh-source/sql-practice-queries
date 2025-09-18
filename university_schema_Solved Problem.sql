-- Create Tables
CREATE TABLE classroom (
    building VARCHAR(15),
    room_number VARCHAR(7) PRIMARY KEY,
    capacity NUMERIC(4,0)
);

CREATE TABLE department (
    dept_name VARCHAR(20) PRIMARY KEY,
    building VARCHAR(15),
    budget NUMERIC(12,2) CHECK (budget > 0)
);

CREATE TABLE course (
    course_id VARCHAR(8) PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2,0) CHECK (credits > 0),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);

CREATE TABLE instructor (
    ID VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8,2) CHECK (salary > 29000),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);

CREATE TABLE time_slot (
    id INT PRIMARY KEY,
    time_slot_id VARCHAR(4),
    day VARCHAR(1),
    start_hr NUMERIC(2) CHECK (start_hr >= 0 AND start_hr < 24),
    start_min NUMERIC(2) CHECK (start_min >= 0 AND start_min < 60),
    end_hr NUMERIC(2) CHECK (end_hr >= 0 AND end_hr < 24),
    end_min NUMERIC(2) CHECK (end_min >= 0 AND end_min < 60)
);

CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
    year NUMERIC(4,0) CHECK (year > 1701 AND year < 2100),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    id INT,
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (room_number) REFERENCES classroom(room_number) ON DELETE SET NULL,
    FOREIGN KEY (id) REFERENCES time_slot(id) ON DELETE SET NULL
);

CREATE TABLE teaches (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES instructor(ID) ON DELETE CASCADE
);

CREATE TABLE student (
    ID VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3,0) CHECK (tot_cred >= 0),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);

CREATE TABLE takes (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (ID) REFERENCES student(ID) ON DELETE CASCADE
);

CREATE TABLE advisor (
    s_ID VARCHAR(5) PRIMARY KEY,
    i_ID VARCHAR(5),
    FOREIGN KEY (i_ID) REFERENCES instructor(ID) ON DELETE SET NULL,
    FOREIGN KEY (s_ID) REFERENCES student(ID) ON DELETE CASCADE
);

CREATE TABLE prereq (
    course_id VARCHAR(8),
    prereq_id VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);

-- Insert Values
-- Classroom data
INSERT INTO classroom VALUES ('Packard', '101', '500');
INSERT INTO classroom VALUES ('Painter', '514', '10');
INSERT INTO classroom VALUES ('Taylor', '3128', '70');
INSERT INTO classroom VALUES ('Watson', '100', '30');
INSERT INTO classroom VALUES ('Watson', '120', '50');
INSERT INTO classroom VALUES ('Taylor', '112', '30');
INSERT INTO classroom VALUES ('Painter', '234', '50');
INSERT INTO classroom VALUES ('Packard', '303', '56');

-- Department data
INSERT INTO department VALUES ('Biology', 'Watson', '90000');
INSERT INTO department VALUES ('Comp. Sci.', 'Taylor', '100000');
INSERT INTO department VALUES ('Elec. Eng.', 'Taylor', '85000');
INSERT INTO department VALUES ('Finance', 'Painter', '120000');
INSERT INTO department VALUES ('History', 'Painter', '50000');
INSERT INTO department VALUES ('Music', 'Packard', '80000');
INSERT INTO department VALUES ('Physics', 'Watson', '70000');

-- Course data
INSERT INTO course VALUES ('BIO-101', 'Intro. to Biology', 'Biology', '4');
INSERT INTO course VALUES ('BIO-301', 'Genetics', 'Biology', '4');
INSERT INTO course VALUES ('BIO-399', 'Computational Biology', 'Biology', '3');
INSERT INTO course VALUES ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
INSERT INTO course VALUES ('CS-190', 'Game Design', 'Comp. Sci.', '4');
INSERT INTO course VALUES ('CS-315', 'Robotics', 'Comp. Sci.', '3');
INSERT INTO course VALUES ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
INSERT INTO course VALUES ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
INSERT INTO course VALUES ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
INSERT INTO course VALUES ('FIN-201', 'Investment Banking', 'Finance', '3');
INSERT INTO course VALUES ('HIS-351', 'World History', 'History', '3');
INSERT INTO course VALUES ('MU-199', 'Music Video Production', 'Music', '3');
INSERT INTO course VALUES ('PHY-101', 'Physical Principles', 'Physics', '4');

-- Instructor data
INSERT INTO instructor VALUES ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
INSERT INTO instructor VALUES ('12121', 'Wu', 'Finance', '90000');
INSERT INTO instructor VALUES ('15151', 'Mozart', 'Music', '40000');
INSERT INTO instructor VALUES ('22222', 'Einstein', 'Physics', '95000');
INSERT INTO instructor VALUES ('32343', 'El Said', 'History', '60000');
INSERT INTO instructor VALUES ('33456', 'Gold', 'Physics', '87000');
INSERT INTO instructor VALUES ('45565', 'Katz', 'Comp. Sci.', '75000');
INSERT INTO instructor VALUES ('58583', 'Califieri', 'History', '62000');
INSERT INTO instructor VALUES ('76543', 'Singh', 'Finance', '80000');
INSERT INTO instructor VALUES ('76766', 'Crick', 'Biology', '72000');
INSERT INTO instructor VALUES ('83821', 'Brandt', 'Comp. Sci.', '92000');
INSERT INTO instructor VALUES ('98345', 'Kim', 'Elec. Eng.', '80000');

-- Time slot data
INSERT INTO time_slot VALUES (1,'A', 'M', '8', '0', '8', '50');
INSERT INTO time_slot VALUES (2,'A', 'W', '8', '0', '8', '50');
INSERT INTO time_slot VALUES (3,'A', 'F', '8', '0', '8', '50');
INSERT INTO time_slot VALUES (4,'B', 'M', '9', '0', '9', '50');
INSERT INTO time_slot VALUES (5,'B', 'W', '9', '0', '9', '50');
INSERT INTO time_slot VALUES (6,'B', 'F', '9', '0', '9', '50');
INSERT INTO time_slot VALUES (7,'C', 'M', '11', '0', '11', '50');
INSERT INTO time_slot VALUES (8,'C', 'W', '11', '0', '11', '50');
INSERT INTO time_slot VALUES (9,'C', 'F', '11', '0', '11', '50');
INSERT INTO time_slot VALUES (10,'D', 'M', '13', '0', '13', '50');
INSERT INTO time_slot VALUES (11,'D', 'W', '13', '0', '13', '50');
INSERT INTO time_slot VALUES (12,'D', 'F', '13', '0', '13', '50');
INSERT INTO time_slot VALUES (13,'E', 'T', '10', '30', '11', '45');
INSERT INTO time_slot VALUES (14,'E', 'R', '10', '30', '11', '45');
INSERT INTO time_slot VALUES (15,'F', 'T', '14', '30', '15', '45');
INSERT INTO time_slot VALUES (16,'F', 'R', '14', '30', '15', '45');
INSERT INTO time_slot VALUES (17,'G', 'M', '16', '0', '16', '50');
INSERT INTO time_slot VALUES (18,'G', 'W', '16', '0', '16', '50');
INSERT INTO time_slot VALUES (19,'G', 'F', '16', '0', '16', '50');
INSERT INTO time_slot VALUES (20,'H', 'W', '10', '0', '12', '30');

-- Section data
INSERT INTO section VALUES ('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B', 1);
INSERT INTO section VALUES ('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A', 2);
INSERT INTO section VALUES ('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H', 3);
INSERT INTO section VALUES ('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F', 4);
INSERT INTO section VALUES ('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E', 5);
INSERT INTO section VALUES ('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A', 6);
INSERT INTO section VALUES ('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D', 7);
INSERT INTO section VALUES ('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B', 8);
INSERT INTO section VALUES ('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C', 9);
INSERT INTO section VALUES ('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A', 10);
INSERT INTO section VALUES ('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C', 11);
INSERT INTO section VALUES ('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B', 12);
INSERT INTO section VALUES ('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C', 13);
INSERT INTO section VALUES ('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D', 14);
INSERT INTO section VALUES ('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A', 15);

-- Teaches data
INSERT INTO teaches VALUES ('10101', 'CS-101', '1', 'Fall', '2017');
INSERT INTO teaches VALUES ('10101', 'CS-315', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('10101', 'CS-347', '1', 'Fall', '2017');
INSERT INTO teaches VALUES ('12121', 'FIN-201', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('15151', 'MU-199', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('22222', 'PHY-101', '1', 'Fall', '2017');
INSERT INTO teaches VALUES ('32343', 'HIS-351', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('45565', 'CS-101', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('45565', 'CS-319', '1', 'Spring', '2018');
INSERT INTO teaches VALUES ('76766', 'BIO-101', '1', 'Summer', '2017');
INSERT INTO teaches VALUES ('76766', 'BIO-301', '1', 'Summer', '2018');
INSERT INTO teaches VALUES ('83821', 'CS-190', '1', 'Spring', '2017');
INSERT INTO teaches VALUES ('83821', 'CS-190', '2', 'Spring', '2017');
INSERT INTO teaches VALUES ('83821', 'CS-319', '2', 'Spring', '2018');
INSERT INTO teaches VALUES ('98345', 'EE-181', '1', 'Spring', '2017');

-- Student data
INSERT INTO student VALUES ('00128', 'Zhang', 'Comp. Sci.', '102');
INSERT INTO student VALUES ('12345', 'Shankar', 'Comp. Sci.', '32');
INSERT INTO student VALUES ('19991', 'Brandt', 'History', '80');
INSERT INTO student VALUES ('23121', 'Chavez', 'Finance', '110');
INSERT INTO student VALUES ('44553', 'Peltier', 'Physics', '56');
INSERT INTO student VALUES ('45678', 'Levy', 'Physics', '46');
INSERT INTO student VALUES ('54321', 'Williams', 'Comp. Sci.', '54');
INSERT INTO student VALUES ('55739', 'Sanchez', 'Music', '38');
INSERT INTO student VALUES ('70557', 'Snow', 'Physics', '0');
INSERT INTO student VALUES ('76543', 'Brown', 'Comp. Sci.', '58');
INSERT INTO student VALUES ('76653', 'Aoi', 'Elec. Eng.', '60');
INSERT INTO student VALUES ('98765', 'Bourikas', 'Elec. Eng.', '98');
INSERT INTO student VALUES ('98988', 'Tanaka', 'Biology', '120');

-- Takes data
INSERT INTO takes VALUES ('00128', 'CS-101', '1', 'Fall', '2017', 'A');
INSERT INTO takes VALUES ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');
INSERT INTO takes VALUES ('12345', 'CS-101', '1', 'Fall', '2017', 'C');
INSERT INTO takes VALUES ('12345', 'CS-190', '2', 'Spring', '2017', 'A');
INSERT INTO takes VALUES ('12345', 'CS-315', '1', 'Spring', '2018', 'A');
INSERT INTO takes VALUES ('12345', 'CS-347', '1', 'Fall', '2017', 'A');
INSERT INTO takes VALUES ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');
INSERT INTO takes VALUES ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');
INSERT INTO takes VALUES ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');
INSERT INTO takes VALUES ('45678', 'CS-101', '1', 'Fall', '2017', 'F');
INSERT INTO takes VALUES ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');
INSERT INTO takes VALUES ('45678', 'CS-319', '1', 'Spring', '2018', 'B');
INSERT INTO takes VALUES ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');
INSERT INTO takes VALUES ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');
INSERT INTO takes VALUES ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');
INSERT INTO takes VALUES ('76543', 'CS-101', '1', 'Fall', '2017', 'A');
INSERT INTO takes VALUES ('76543', 'CS-319', '2', 'Spring', '2018', 'A');
INSERT INTO takes VALUES ('76653', 'EE-181', '1', 'Spring', '2017', 'C');
INSERT INTO takes VALUES ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');
INSERT INTO takes VALUES ('98765', 'CS-315', '1', 'Spring', '2018', 'B');
INSERT INTO takes VALUES ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');
INSERT INTO takes VALUES ('98988', 'BIO-301', '1', 'Summer', '2018', NULL);

-- Advisor data
INSERT INTO advisor VALUES ('00128', '45565');
INSERT INTO advisor VALUES ('12345', '10101');
INSERT INTO advisor VALUES ('23121', '76543');
INSERT INTO advisor VALUES ('44553', '22222');
INSERT INTO advisor VALUES ('45678', '22222');
INSERT INTO advisor VALUES ('76543', '45565');
INSERT INTO advisor VALUES ('76653', '98345');
INSERT INTO advisor VALUES ('98765', '98345');
INSERT INTO advisor VALUES ('98988', '76766');

-- Prereq data
INSERT INTO prereq VALUES ('BIO-301', 'BIO-101');
INSERT INTO prereq VALUES ('BIO-399', 'BIO-101');
INSERT INTO prereq VALUES ('CS-190', 'CS-101');
INSERT INTO prereq VALUES ('CS-315', 'CS-101');
INSERT INTO prereq VALUES ('CS-319', 'CS-101');
INSERT INTO prereq VALUES ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');

--Assignment Questions


--1. Display average salary given by each department.

SELECT dept_name, ROUND(AVG(salary), 2) as average_salary
FROM instructor
GROUP BY dept_name
ORDER BY dept_name;

--2. Display the name of students and their corresponding course IDs.


SELECT s.name, t.course_id
FROM student s
JOIN takes t ON s.ID = t.ID
ORDER BY s.name, t.course_id;

--3. Display number of courses taken by each student.


SELECT s.name, COUNT(t.course_id) as number_of_courses
FROM student s
JOIN takes t ON s.ID = t.ID
GROUP BY s.name
ORDER BY s.name;

--4. Get the prerequisites courses for courses in the Spring semester.

SELECT DISTINCT s.semester, s.course_id, p.prereq_id
FROM section s
JOIN prereq p ON s.course_id = p.course_id
WHERE s.semester = 'Spring';

--5. Display the instructor name who teaches student with highest 5 credits.

SELECT s.name as student_name, i.name as instructor_name, s.tot_cred
FROM student s
JOIN advisor a ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
ORDER BY s.tot_cred DESC
LIMIT 5;

--6. Which semester and department offers maximum number of courses.

SELECT s.semester, c.dept_name, COUNT(*) as max_courses
FROM section s
JOIN course c ON s.course_id = c.course_id
GROUP BY semester, dept_name
ORDER BY max_courses DESC
LIMIT 1;

--7. Display course and department whose time starts at 8.

SELECT DISTINCT s.course_id, ts.start_hr
FROM section s
JOIN time_slot ts ON s.id = ts.id
WHERE ts.start_hr = 8
ORDER BY s.course_id;

--8. Display the salary of instructors from Watson building.

SELECT i.name, i.salary, i.dept_name
FROM instructor i
JOIN department d ON i.dept_name = d.dept_name
WHERE d.building = 'Watson'
ORDER BY i.salary DESC;

--9. Show the title of courses available on Monday.

SELECT DISTINCT c.title, ts.day
FROM course c
JOIN section s ON c.course_id = s.course_id
JOIN time_slot ts ON s.id = ts.id
WHERE ts.day = 'M'
ORDER BY c.title;

--10. Find the number of courses that start at 8 and end at 8.

SELECT start_hr, end_hr, COUNT(*) as number_of_courses
FROM time_slot
WHERE start_hr = 8 AND end_hr = 8
GROUP BY start_hr, end_hr;

--11. Find instructors having salary more than 90000.

SELECT name
FROM instructor
WHERE salary > 90000
ORDER BY name;

--12. Find student records taking courses before 2018.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE year < 2018
ORDER BY year, semester, ID;

--13. Find student records taking courses in the fall semester and coming under first section.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE semester = 'Fall' AND sec_id = '1'
ORDER BY ID;

--14. Find student records taking courses in the fall semester and coming under second section.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE semester = 'Fall' AND sec_id = '2'
ORDER BY ID;

--15. Find student records taking courses in the summer semester, coming under first section in the year 2017.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE semester = 'Summer' AND sec_id = '1' AND year = 2017;

--16. Find student records taking courses in the fall semester and having A grade.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE semester = 'Fall' AND grade = 'A'
ORDER BY ID;

--17. Find student records taking courses in the summer semester and having A grade.

SELECT ID, course_id, sec_id, semester, year, grade
FROM takes
WHERE semester = 'Summer' AND grade LIKE 'A%'

--18. Display section details with B time slot, room number 514 and in the Painter building.

SELECT course_id, sec_id, semester, year, building, room_number, time_slot_id
FROM section
WHERE time_slot_id = 'B' AND room_number = '514' AND building = 'Painter';

--19. Find all course titles which have a string "Intro.".

SELECT title
FROM course
WHERE title LIKE '%Intro.%'
ORDER BY title;

--20. Find the titles of courses in the Computer Science department that have 3 credits.

SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits = 3
ORDER BY title;

--21. Find IDs and titles of all the courses which were taught by an instructor named Einstein. Make sure there are no duplicates in the result.

SELECT DISTINCT c.course_id, c.title
FROM course c
JOIN teaches t ON c.course_id = t.course_id
JOIN instructor i ON t.ID = i.ID
WHERE i.name = 'Einstein'
ORDER BY c.course_id;

--22. Find all course IDs which start with CS

SELECT course_id
FROM course
WHERE course_id LIKE 'CS-%'
ORDER BY course_id;

--23. For each department, find the maximum salary of instructors in that department.

SELECT dept_name, MAX(salary) as maximum_salary
FROM instructor
GROUP BY dept_name
ORDER BY dept_name;

--24. Find the enrollment (number of students) of each section that was offered in Fall 2017.

SELECT sec_id, COUNT(*) as number_of_students, semester, year
FROM takes
WHERE semester = 'Fall' AND year = 2017
GROUP BY sec_id, semester, year
ORDER BY sec_id;

--25. Increase(update) the salary of each instructor by 10% if their current salary is between 0 and 90000.

UPDATE instructor
SET salary = salary * 1.10
WHERE salary BETWEEN 0 AND 90000;

select name, salary from instructor;

--26. Find the names of instructors from Biology department having salary more than 50000.

SELECT name, salary
FROM instructor
WHERE dept_name = 'Biology' AND salary > 50000 ;

--27. Find the IDs and titles of all courses taken by a student named Shankar.

SELECT s.name, t.course_id, c.title
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE s.name = 'Shankar' ;

--28. For each department, find the total credit hours of courses in that department.

SELECT dept_name, SUM(credits) as total_credits
FROM course
GROUP BY dept_name
ORDER BY dept_name;

--Question 29: Find the number of courses having A grade in each building.

SELECT s.building, COUNT(*) as number_of_courses, t.grade
FROM takes t
JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id 
                 AND t.semester = s.semester AND t.year = s.year
WHERE t.grade LIKE 'A%'
GROUP BY s.building, t.grade
ORDER BY s.building;

--Question 30: Display number of students in each department having total credits divisible by course credits.

SELECT d.dept_name, COUNT(DISTINCT s.ID) as number_of_students
FROM student s
JOIN department d ON s.dept_name = d.dept_name
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE s.tot_cred % c.credits = 0
GROUP BY d.dept_name
ORDER BY d.dept_name;

--Question 31: Display number of courses available in each building.

SELECT building, COUNT(DISTINCT course_id) as number_of_courses
FROM section
GROUP BY building
ORDER BY building;

--Question 32: Find number of instructors in each department having 'a' and 'e' in their name.

SELECT dept_name, COUNT(*) as number_of_instructors
FROM instructor
WHERE name ILIKE '%a%' AND name ILIKE '%e%'
GROUP BY dept_name
ORDER BY dept_name;

--Question 33: Display number of courses being taught in classroom having capacity more than 20.

SELECT c.room_number, c.capacity, COUNT(DISTINCT s.course_id) as number_of_courses
FROM section s
JOIN classroom c ON s.room_number = c.room_number
WHERE c.capacity > 20
GROUP BY c.room_number, c.capacity
ORDER BY c.room_number;


--Question 34: Update the budget of each department by Rs. 1000.


UPDATE department
SET budget = budget + 1000;


--Question 35: Find number of students in each room.

SELECT s.room_number, COUNT(DISTINCT t.ID) as number_of_students
FROM section s
JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id 
               AND s.semester = t.semester AND s.year = t.year
GROUP BY s.room_number
ORDER BY s.room_number;

--Question 36: Give the prerequisite course for each student.

SELECT DISTINCT s.name, p.prereq_id
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN prereq p ON t.course_id = p.course_id
ORDER BY s.name, p.prereq_id;

--Question 37: Display number of students attending classes on Wednesday.

SELECT ts.day, COUNT(DISTINCT t.ID) as number_of_students
FROM takes t
JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id 
                 AND t.semester = s.semester AND t.year = s.year
JOIN time_slot ts ON s.id = ts.id
WHERE ts.day = 'W'
GROUP BY ts.day;

--Question 38: Display number of students and instructors in each department.

SELECT dept_name, 'student' as type, COUNT(*) as count
FROM student
GROUP BY dept_name
UNION ALL
SELECT dept_name, 'instructor' as type, COUNT(*) as count
FROM instructor
GROUP BY dept_name
ORDER BY dept_name, type;

--Question 39: Display number of students in each semester and their sum of credits.

SELECT t.semester, COUNT(DISTINCT t.ID) as number_of_students, 
       SUM(s.tot_cred) as sum_of_credits
FROM takes t
JOIN student s ON t.ID = s.ID
GROUP BY t.semester
ORDER BY t.semester;

--40. Give number of instructors in each building.

SELECT d.building, COUNT(DISTINCT i.ID) as number_of_instructors
FROM instructor i
JOIN department d ON i.dept_name = d.dept_name
GROUP BY d.building
ORDER BY d.building;

--Question 41: Display advisor IDs for instructors in Painter building.

SELECT d.building, i.name, a.s_ID
FROM instructor i
JOIN department d ON i.dept_name = d.dept_name
JOIN advisor a ON i.ID = a.i_ID
WHERE d.building = 'Painter'
ORDER BY i.name;

--Question 42: Find total credits earned by students coming at 9am.

SELECT s.name, ts.start_hr, s.tot_cred
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id 
                   AND t.semester = sec.semester AND t.year = sec.year
JOIN time_slot ts ON sec.id = ts.id
WHERE ts.start_hr = 9
ORDER BY s.name;

---

SELECT s.name, ts.start_hr, s.tot_cred
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id 
JOIN time_slot ts ON sec.id = ts.id
WHERE ts.start_hr = 9
ORDER BY s.name;

--

SELECT s.name, ts.start_hr, s.tot_cred
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON  t.semester = sec.semester
JOIN time_slot ts ON sec.id = ts.id
WHERE ts.start_hr = 9
ORDER BY s.name;

--Question 43: Display student names ordered by room number.

SELECT DISTINCT s.name, sec.room_number
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id 
                   AND t.semester = sec.semester AND t.year = sec.year
ORDER BY sec.room_number, s.name;

--Question 44: Find the number of capacity left after occupying all the students.

SELECT c.room_number, 
       (c.capacity - COUNT(DISTINCT t.ID)) as remaining_capacity
FROM classroom c
JOIN section s ON c.room_number = s.room_number
JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id 
               AND s.semester = t.semester AND s.year = t.year
GROUP BY c.room_number, c.capacity
ORDER BY c.room_number;

--Question 45: Find the duration for which each student has to attend each lecture.

SELECT s.name, t.course_id,
       (ts.end_hr - ts.start_hr) as duration_hours,
       ((ts.end_hr - ts.start_hr) * 60 + (ts.end_min - ts.start_min)) as duration_minutes
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id 
                   AND t.semester = sec.semester AND t.year = sec.year
JOIN time_slot ts ON sec.id = ts.id
ORDER BY s.name, t.course_id;

--Question 46: Create a timetable for the university.

SELECT ts.day, s.building, s.room_number, s.course_id
FROM section s
JOIN time_slot ts ON s.id = ts.id
ORDER BY ts.day, s.building, s.room_number, s.course_id;

--Question 47: Find the average salary that's distributed to teachers for each course.

SELECT c.title as course_name, ROUND(AVG(i.salary), 2) as avg_salary
FROM course c
JOIN teaches t ON c.course_id = t.course_id
JOIN instructor i ON t.ID = i.ID
GROUP BY c.course_id, c.title
ORDER BY avg_salary DESC;

--Question 48: Find the average duration of classes for each course id.

SELECT s.course_id, 
       ROUND(AVG((ts.end_hr - ts.start_hr) * 60 + (ts.end_min - ts.start_min)), 2) as duration_minutes
FROM section s
JOIN time_slot ts ON s.id = ts.id
GROUP BY s.course_id
ORDER BY s.course_id;

--Question 49: Get the name of the instructor with highest salary from each department.

SELECT i.dept_name, i.name, i.salary as highest_salary
FROM instructor i
JOIN (
    SELECT dept_name, MAX(salary) as max_salary
    FROM instructor
    GROUP BY dept_name
) max_sal ON i.dept_name = max_sal.dept_name AND i.salary = max_sal.max_salary
ORDER BY i.dept_name;

--50. Get the sum of the total credits of students that is dealt by the instructors along with their names

SELECT i.name, SUM(s.tot_cred) as sum_of_credits
FROM instructor i
JOIN advisor a ON i.ID = a.i_ID
JOIN student s ON a.s_ID = s.ID
GROUP BY i.ID, i.name
ORDER BY i.name;

--Question 51: Perform division between student credits and department total credits.

SELECT s.ID, s.name, s.tot_cred as student_credits,
       d.total_dept_credits,
       ROUND(s.tot_cred::numeric / d.total_dept_credits, 2) as ratio
FROM student s
JOIN (
    SELECT dept_name, SUM(credits) as total_dept_credits
    FROM course
    GROUP BY dept_name
) d ON s.dept_name = d.dept_name
ORDER BY s.name;

--Question 52: If the department budget was to be distributed among the buildings, how much amount can be allocated to each room in a building.

SELECT d.building, d.dept_name, d.budget,
       COUNT(c.room_number) as total_rooms,
       ROUND(d.budget::numeric / COUNT(c.room_number), 2) as amount_per_room
FROM department d
JOIN classroom c ON d.building = c.building
GROUP BY d.building, d.dept_name, d.budget
ORDER BY d.building;