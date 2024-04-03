-- EXPERIMENT1
-- 1
-- create
CREATE TABLE INSTRUCTOR (
  ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dept_name TEXT NOT NULL,
  salary INT
);

-- insert
INSERT INTO INSTRUCTOR VALUES (10101, 'Srinivasan', 'Comp. Sci.', '65000');
INSERT INTO INSTRUCTOR VALUES (12121, 'Wu', 'Finance', '90000');
INSERT INTO INSTRUCTOR VALUES (15151, 'Mozart', 'Music', '40000');
INSERT INTO INSTRUCTOR VALUES (22222, 'Einstein', 'Physics', '95000');
INSERT INTO INSTRUCTOR VALUES (32343, 'El Said', 'History', '60000');
INSERT INTO INSTRUCTOR VALUES (33456, 'Gold', 'Physics', '87000');
INSERT INTO INSTRUCTOR VALUES (45565, 'Katz', 'Comp. Sci.', '75000');
INSERT INTO INSTRUCTOR VALUES (58583, 'Califieri', 'History', '62000');
INSERT INTO INSTRUCTOR VALUES (76543, 'Singh', 'Finance', '80000');
INSERT INTO INSTRUCTOR VALUES (76766, 'Crick', 'Biology', '72000');
INSERT INTO INSTRUCTOR VALUES (83821, 'Brandt', 'Comp. Sci.', '92000');
INSERT INTO INSTRUCTOR VALUES (98345, 'Kim', 'Elec. Eng.', '80000');

-- fetch 
SELECT * FROM INSTRUCTOR;

-- create
CREATE TABLE TEACHES (
  ID INTEGER NOT NULL,
  COURSE_ID VARCHAR(50) NOT NULL,
  SEC_ID TEXT NOT NULL,
  SEMESTER CHAR(50) NOT NULL,
  YEAR INT NOT NULL,
  FOREIGN KEY (ID) REFERENCES INSTRUCTOR(ID)
);

-- 2
-- insert
INSERT INTO TEACHES VALUES (10101, 'CS-101', '1', 'Fall', 2017);
INSERT INTO TEACHES VALUES (10101, 'CS-315', '1', 'Spring', 2018);
INSERT INTO TEACHES VALUES (10101, 'CS-347', '1', 'Fall', 2017);
INSERT INTO TEACHES VALUES (12121, 'FIN-201', '1', 'Spring', 2018);
INSERT INTO TEACHES VALUES (15151, 'MU-199', '1', 'Spring',2018);
INSERT INTO TEACHES VALUES (22222, 'PHY-101', '1', 'Fall', 2017);
INSERT INTO TEACHES VALUES (32343, 'HIS-351', '1', 'Spring', 2018);
INSERT INTO TEACHES VALUES (45565, 'CS-101', '1', 'Spring', 2018);
INSERT INTO TEACHES VALUES (45565, 'CS-319', '1', 'Spring', 2018);
INSERT INTO TEACHES VALUES (76766, 'BIO-101', '1', 'Summer', 2017);
INSERT INTO TEACHES VALUES (76766, 'BIO-301', '1', 'Summer', 2018);
INSERT INTO TEACHES VALUES (83821, 'CS-190', '2', 'Spring', 2017);
INSERT INTO TEACHES VALUES (83821, 'CS-319', '2', 'Spring', 2018);
INSERT INTO TEACHES VALUES (98345, 'EE-181', '1', 'Spring', 2017);

-- fetch 
SELECT * FROM TEACHES;

-- 3
INSERT INTO INSTRUCTOR(ID, name, dept_name, salary) VALUES('10211', 'Smith', 'Biology', 66000);
SELECT * FROM INSTRUCTOR;

-- 4
DELETE FROM INSTRUCTOR WHERE ID="10211";
SELECT * FROM INSTRUCTOR;

-- 5
SELECT * FROM INSTRUCTOR WHERE dept_name='History';

-- 6
SELECT * FROM INSTRUCTOR CROSS JOIN TEACHES;  

-- 7
SELECT name, COURSE_ID FROM INSTRUCTOR INNER JOIN TEACHES ON INSTRUCTOR.ID=TEACHES.ID;

-- 8
SELECT * From INSTRUCTOR WHERE name LIKE '%in%';

-- 9
SELECT * FROM INSTRUCTOR WHERE salary BETWEEN 90000 and 100000;


-- EXPERIMENT2
-- 1
SELECT * FROM INSTRUCTOR order by salary ASC;

-- 2
SELECT COURSE_ID FROM TEACHES where (SEMESTER = "Fall" and YEAR = "2017") or (SEMESTER = "Spring" and YEAR = "2018");

-- 3
SELECT COURSE_ID FROM TEACHES where (SEMESTER = "Fall" and YEAR = "2017") and (SEMESTER = "Spring" and YEAR = "2018");

-- 4
SELECT COURSE_ID FROM TEACHES where (SEMESTER = "Fall" and YEAR = "2017");

-- 5
INSERT INTO INSTRUCTOR(ID, name, dept_name, salary) 
VALUES('10211', 'Smith', 'Biology', 66000),
('10212', 'Tom', 'Biology', NULL);
SELECT * FROM INSTRUCTOR;

-- 6
SELECT * FROM INSTRUCTOR where salary = NULL;

-- 7
SELECT AVG(salary) FROM INSTRUCTOR;

-- EXPERIMENT3
-- 1
SELECT COUNT(DISTINCT ID) AS total_instructors_spring_2018 FROM TEACHES WHERE SEMESTER = 'Spring' AND YEAR = 2018;

-- 2
SELECT COUNT(*) AS number_of_tuples FROM TEACHES;

-- 3
SELECT dept_name, AVG(salary) AS avg_salary FROM INSTRUCTOR GROUP BY dept_name;

-- 4
SELECT dept_name, AVG(salary) AS avg_salary FROM INSTRUCTOR GROUP BY dept_name HAVING avg_salary > 42000;

-- 5
SELECT name FROM INSTRUCTOR WHERE name NOT IN ('Mozart', 'Einstein');

-- 6
SELECT e.name FROM INSTRUCTOR e WHERE e.salary > ANY (SELECT salary FROM INSTRUCTOR WHERE dept_name = 'Biology');

-- 7
SELECT e.name FROM INSTRUCTOR e WHERE e.salary > ALL (SELECT salary FROM INSTRUCTOR WHERE dept_name = 'Biology');

-- 8
SELECT dept_name, AVG(salary) AS avg_salary FROM INSTRUCTOR GROUP BY dept_name HAVING AVG(salary) > 42000;


Output:

+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 12121 | Wu         | Finance    |  90000 |
| 15151 | Mozart     | Music      |  40000 |
| 22222 | Einstein   | Physics    |  95000 |
| 32343 | El Said    | History    |  60000 |
| 33456 | Gold       | Physics    |  87000 |
| 45565 | Katz       | Comp. Sci. |  75000 |
| 58583 | Califieri  | History    |  62000 |
| 76543 | Singh      | Finance    |  80000 |
| 76766 | Crick      | Biology    |  72000 |
| 83821 | Brandt     | Comp. Sci. |  92000 |
| 98345 | Kim        | Elec. Eng. |  80000 |
+-------+------------+------------+--------+
+-------+-----------+--------+----------+------+
| ID    | COURSE_ID | SEC_ID | SEMESTER | YEAR |
+-------+-----------+--------+----------+------+
| 10101 | CS-101    | 1      | Fall     | 2017 |
| 10101 | CS-315    | 1      | Spring   | 2018 |
| 10101 | CS-347    | 1      | Fall     | 2017 |
| 12121 | FIN-201   | 1      | Spring   | 2018 |
| 15151 | MU-199    | 1      | Spring   | 2018 |
| 22222 | PHY-101   | 1      | Fall     | 2017 |
| 32343 | HIS-351   | 1      | Spring   | 2018 |
| 45565 | CS-101    | 1      | Spring   | 2018 |
| 45565 | CS-319    | 1      | Spring   | 2018 |
| 76766 | BIO-101   | 1      | Summer   | 2017 |
| 76766 | BIO-301   | 1      | Summer   | 2018 |
| 83821 | CS-190    | 2      | Spring   | 2017 |
| 83821 | CS-319    | 2      | Spring   | 2018 |
| 98345 | EE-181    | 1      | Spring   | 2017 |
+-------+-----------+--------+----------+------+
+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 10211 | Smith      | Biology    |  66000 |
| 12121 | Wu         | Finance    |  90000 |
| 15151 | Mozart     | Music      |  40000 |
| 22222 | Einstein   | Physics    |  95000 |
| 32343 | El Said    | History    |  60000 |
| 33456 | Gold       | Physics    |  87000 |
| 45565 | Katz       | Comp. Sci. |  75000 |
| 58583 | Califieri  | History    |  62000 |
| 76543 | Singh      | Finance    |  80000 |
| 76766 | Crick      | Biology    |  72000 |
| 83821 | Brandt     | Comp. Sci. |  92000 |
| 98345 | Kim        | Elec. Eng. |  80000 |
+-------+------------+------------+--------+
+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 12121 | Wu         | Finance    |  90000 |
| 15151 | Mozart     | Music      |  40000 |
| 22222 | Einstein   | Physics    |  95000 |
| 32343 | El Said    | History    |  60000 |
| 33456 | Gold       | Physics    |  87000 |
| 45565 | Katz       | Comp. Sci. |  75000 |
| 58583 | Califieri  | History    |  62000 |
| 76543 | Singh      | Finance    |  80000 |
| 76766 | Crick      | Biology    |  72000 |
| 83821 | Brandt     | Comp. Sci. |  92000 |
| 98345 | Kim        | Elec. Eng. |  80000 |
+-------+------------+------------+--------+
+-------+-----------+-----------+--------+
| ID    | name      | dept_name | salary |
+-------+-----------+-----------+--------+
| 32343 | El Said   | History   |  60000 |
| 58583 | Califieri | History   |  62000 |
+-------+-----------+-----------+--------+
+-------+------------+------------+--------+-------+-----------+--------+----------+------+
| ID    | name       | dept_name  | salary | ID    | COURSE_ID | SEC_ID | SEMESTER | YEAR |
+-------+------------+------------+--------+-------+-----------+--------+----------+------+
| 98345 | Kim        | Elec. Eng. |  80000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 76766 | Crick      | Biology    |  72000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 76543 | Singh      | Finance    |  80000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 58583 | Califieri  | History    |  62000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 33456 | Gold       | Physics    |  87000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 32343 | El Said    | History    |  60000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 15151 | Mozart     | Music      |  40000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 12121 | Wu         | Finance    |  90000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 10101 | CS-101    | 1      | Fall     | 2017 |
| 98345 | Kim        | Elec. Eng. |  80000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 10101 | CS-315    | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 76766 | Crick      | Biology    |  72000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 76543 | Singh      | Finance    |  80000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 58583 | Califieri  | History    |  62000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 33456 | Gold       | Physics    |  87000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 32343 | El Said    | History    |  60000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 15151 | Mozart     | Music      |  40000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 12121 | Wu         | Finance    |  90000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 10101 | CS-347    | 1      | Fall     | 2017 |
| 98345 | Kim        | Elec. Eng. |  80000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 12121 | FIN-201   | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 15151 | MU-199    | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 76766 | Crick      | Biology    |  72000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 76543 | Singh      | Finance    |  80000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 58583 | Califieri  | History    |  62000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 33456 | Gold       | Physics    |  87000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 32343 | El Said    | History    |  60000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 15151 | Mozart     | Music      |  40000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 12121 | Wu         | Finance    |  90000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 22222 | PHY-101   | 1      | Fall     | 2017 |
| 98345 | Kim        | Elec. Eng. |  80000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 32343 | HIS-351   | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 45565 | CS-101    | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 45565 | CS-319    | 1      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 76766 | Crick      | Biology    |  72000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 76543 | Singh      | Finance    |  80000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 58583 | Califieri  | History    |  62000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 33456 | Gold       | Physics    |  87000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 32343 | El Said    | History    |  60000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 15151 | Mozart     | Music      |  40000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 12121 | Wu         | Finance    |  90000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 76766 | BIO-101   | 1      | Summer   | 2017 |
| 98345 | Kim        | Elec. Eng. |  80000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 58583 | Califieri  | History    |  62000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 32343 | El Said    | History    |  60000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 76766 | BIO-301   | 1      | Summer   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 76766 | Crick      | Biology    |  72000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 76543 | Singh      | Finance    |  80000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 58583 | Califieri  | History    |  62000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 33456 | Gold       | Physics    |  87000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 32343 | El Said    | History    |  60000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 15151 | Mozart     | Music      |  40000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 12121 | Wu         | Finance    |  90000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 83821 | CS-190    | 2      | Spring   | 2017 |
| 98345 | Kim        | Elec. Eng. |  80000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 76766 | Crick      | Biology    |  72000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 76543 | Singh      | Finance    |  80000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 58583 | Califieri  | History    |  62000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 45565 | Katz       | Comp. Sci. |  75000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 33456 | Gold       | Physics    |  87000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 32343 | El Said    | History    |  60000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 22222 | Einstein   | Physics    |  95000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 15151 | Mozart     | Music      |  40000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 12121 | Wu         | Finance    |  90000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 83821 | CS-319    | 2      | Spring   | 2018 |
| 98345 | Kim        | Elec. Eng. |  80000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 83821 | Brandt     | Comp. Sci. |  92000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 76766 | Crick      | Biology    |  72000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 76543 | Singh      | Finance    |  80000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 58583 | Califieri  | History    |  62000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 45565 | Katz       | Comp. Sci. |  75000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 33456 | Gold       | Physics    |  87000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 32343 | El Said    | History    |  60000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 22222 | Einstein   | Physics    |  95000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 15151 | Mozart     | Music      |  40000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 12121 | Wu         | Finance    |  90000 | 98345 | EE-181    | 1      | Spring   | 2017 |
| 10101 | Srinivasan | Comp. Sci. |  65000 | 98345 | EE-181    | 1      | Spring   | 2017 |
+-------+------------+------------+--------+-------+-----------+--------+----------+------+
+------------+-----------+
| name       | COURSE_ID |
+------------+-----------+
| Srinivasan | CS-101    |
| Srinivasan | CS-315    |
| Srinivasan | CS-347    |
| Wu         | FIN-201   |
| Mozart     | MU-199    |
| Einstein   | PHY-101   |
| El Said    | HIS-351   |
| Katz       | CS-101    |
| Katz       | CS-319    |
| Crick      | BIO-101   |
| Crick      | BIO-301   |
| Brandt     | CS-190    |
| Brandt     | CS-319    |
| Kim        | EE-181    |
+------------+-----------+
+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 22222 | Einstein   | Physics    |  95000 |
| 76543 | Singh      | Finance    |  80000 |
+-------+------------+------------+--------+
+-------+----------+------------+--------+
| ID    | name     | dept_name  | salary |
+-------+----------+------------+--------+
| 12121 | Wu       | Finance    |  90000 |
| 22222 | Einstein | Physics    |  95000 |
| 83821 | Brandt   | Comp. Sci. |  92000 |
+-------+----------+------------+--------+
+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 15151 | Mozart     | Music      |  40000 |
| 32343 | El Said    | History    |  60000 |
| 58583 | Califieri  | History    |  62000 |
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 76766 | Crick      | Biology    |  72000 |
| 45565 | Katz       | Comp. Sci. |  75000 |
| 76543 | Singh      | Finance    |  80000 |
| 98345 | Kim        | Elec. Eng. |  80000 |
| 33456 | Gold       | Physics    |  87000 |
| 12121 | Wu         | Finance    |  90000 |
| 83821 | Brandt     | Comp. Sci. |  92000 |
| 22222 | Einstein   | Physics    |  95000 |
+-------+------------+------------+--------+
+-----------+
| COURSE_ID |
+-----------+
| CS-101    |
| CS-315    |
| CS-347    |
| FIN-201   |
| MU-199    |
| PHY-101   |
| HIS-351   |
| CS-101    |
| CS-319    |
| CS-319    |
+-----------+
+-----------+
| COURSE_ID |
+-----------+
| CS-101    |
| CS-347    |
| PHY-101   |
+-----------+
+-------+------------+------------+--------+
| ID    | name       | dept_name  | salary |
+-------+------------+------------+--------+
| 10101 | Srinivasan | Comp. Sci. |  65000 |
| 10211 | Smith      | Biology    |  66000 |
| 10212 | Tom        | Biology    |   NULL |
| 12121 | Wu         | Finance    |  90000 |
| 15151 | Mozart     | Music      |  40000 |
| 22222 | Einstein   | Physics    |  95000 |
| 32343 | El Said    | History    |  60000 |
| 33456 | Gold       | Physics    |  87000 |
| 45565 | Katz       | Comp. Sci. |  75000 |
| 58583 | Califieri  | History    |  62000 |
| 76543 | Singh      | Finance    |  80000 |
| 76766 | Crick      | Biology    |  72000 |
| 83821 | Brandt     | Comp. Sci. |  92000 |
| 98345 | Kim        | Elec. Eng. |  80000 |
+-------+------------+------------+--------+
+-------------+
| AVG(salary) |
+-------------+
|  74153.8462 |
+-------------+
+-------------------------------+
| total_instructors_spring_2018 |
+-------------------------------+
|                             6 |
+-------------------------------+
+------------------+
| number_of_tuples |
+------------------+
|               14 |
+------------------+
+------------+------------+
| dept_name  | avg_salary |
+------------+------------+
| Comp. Sci. | 77333.3333 |
| Biology    | 69000.0000 |
| Finance    | 85000.0000 |
| Music      | 40000.0000 |
| Physics    | 91000.0000 |
| History    | 61000.0000 |
| Elec. Eng. | 80000.0000 |
+------------+------------+
+------------+------------+
| dept_name  | avg_salary |
+------------+------------+
| Comp. Sci. | 77333.3333 |
| Biology    | 69000.0000 |
| Finance    | 85000.0000 |
| Physics    | 91000.0000 |
| History    | 61000.0000 |
| Elec. Eng. | 80000.0000 |
+------------+------------+
+------------+
| name       |
+------------+
| Srinivasan |
| Smith      |
| Tom        |
| Wu         |
| El Said    |
| Gold       |
| Katz       |
| Califieri  |
| Singh      |
| Crick      |
| Brandt     |
| Kim        |
+------------+
+----------+
| name     |
+----------+
| Wu       |
| Einstein |
| Gold     |
| Katz     |
| Singh    |
| Crick    |
| Brandt   |
| Kim      |
+----------+
+------------+------------+
| dept_name  | avg_salary |
+------------+------------+
| Comp. Sci. | 77333.3333 |
| Biology    | 69000.0000 |
| Finance    | 85000.0000 |
| Physics    | 91000.0000 |
| History    | 61000.0000 |
| Elec. Eng. | 80000.0000 |
+------------+------------+