use dbmslab0304;
-- 1
SELECT dept_name from INSTRUCTOR where salary > 74153.8462;

-- 2
select name, COURSE_ID from INSTRUCTOR inner join TEACHES on INSTRUCTOR.ID=TEACHES.ID;

-- 3
select name, COURSE_ID from INSTRUCTOR inner join TEACHES on INSTRUCTOR.ID=TEACHES.ID;

MariaDB [dbmslab0304]> CREATE VIEW faculty AS  SELECT ID,name, dept_name FROM EMPLOYEE;
Query OK, 0 rows affected (0.009 sec)

MariaDB [dbmslab0304]> SELECT * FROM faculty;
+-------+------------+------------+
| ID    | name       | dept_name  |
+-------+------------+------------+
| 10101 | Srinivasan | Comp. Sci. |
| 10211 | Smith      | Biology    |
| 12121 | Wu         | Finance    |
| 15151 | Mozart     | Music      |
| 22222 | Einstein   | Physics    |
| 32343 | El Said    | History    |
| 33456 | Gold       | Physics    |
| 45565 | Katz       | Comp. Sci. |
| 58583 | Cali       | History    |
| 76543 | Singh      | Finance    |
| 76766 | Crick      | Biology    |
| 83821 | Brandt     | Comp. Sci. |
| 98345 | Kim        | Elec. Eng. |
+-------+------------+------------+
13 rows in set (0.001 sec)

MariaDB [dbmslab0304]> CREATE VIEW department_salary_totals AS
    -> SELECT dept_name, SUM(salary) AS total_salary
    -> FROM EMPLOYEE
    -> GROUP BY dept_name;
Query OK, 0 rows affected (0.006 sec)

MariaDB [dbmslab0304]> select * from department_salary_totals
    -> ;
+------------+--------------+
| dept_name  | total_salary |
+------------+--------------+
| Biology    |       138000 |
| Comp. Sci. |       232000 |
| Elec. Eng. |        80000 |
| Finance    |       170000 |
| History    |       120000 |
| Music      |        40000 |
| Physics    |       182000 |
+------------+--------------+
7 rows in set (0.001 sec)

MariaDB [dbmslab0304]> CREATE ROLE student;
Query OK, 0 rows affected (0.005 sec)

MariaDB [dbmslab0304]> GRANT SELECT ON faculty TO student;
Query OK, 0 rows affected (0.002 sec)

MariaDB [dbmslab0304]> CREATE USER new_user IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.002 sec)

MariaDB [dbmslab0304]> GRANT student TO new_user;
Query OK, 0 rows affected (0.001 sec)

MariaDB [dbmslab0304]> -- Login as new_user (steps depend on the database system)
MariaDB [dbmslab0304]> SELECT * FROM faculty WHERE dept_name = 'Biology';
+-------+-------+-----------+
| ID    | name  | dept_name |
+-------+-------+-----------+
| 10211 | Smith | Biology   |
| 76766 | Crick | Biology   |
+-------+-------+-----------+
2 rows in set (0.001 sec)

MariaDB [dbmslab0304]> REVOKE student FROM new_user;
Query OK, 0 rows affected (0.001 sec)

MariaDB [dbmslab0304]> DROP ROLE student;
Query OK, 0 rows affected (0.002 sec)

MariaDB [dbmslab0304]> GRANT SELECT ON faculty TO new_user;
Query OK, 0 rows affected (0.002 sec)

MariaDB [dbmslab0304]> -- Login as new_user (steps depend on the database system)
MariaDB [dbmslab0304]> SELECT * FROM faculty WHERE dept_name = 'Finance';
+-------+-------+-----------+
| ID    | name  | dept_name |
+-------+-------+-----------+
| 12121 | Wu    | Finance   |
| 76543 | Singh | Finance   |
+-------+-------+-----------+
2 rows in set (0.001 sec)

MariaDB [dbmslab0304]> CREATE TABLE TEACHES2 (
    ->   ID INTEGER NOT NULL,
    ->   COURSE_ID VARCHAR(50) NOT NULL,
    ->   SEC_ID TEXT NOT NULL,
    ->   SEMESTER CHAR(50) NOT NULL CHECK (SEMESTER IN ('Fall', 'Winter', 'Spring', 'Summer')),
    ->   YEAR INT NOT NULL,
    ->   FOREIGN KEY (ID) REFERENCES EMPLOYEE(ID)
    -> );
Query OK, 0 rows affected (0.014 sec)

MariaDB [dbmslab0304]> select * from TEACHES2;
Empty set (0.001 sec)

MariaDB [dbmslab0304]> CREATE INDEX teaches_id_index ON TEACHES (ID);
Query OK, 0 rows affected (0.022 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [dbmslab0304]> DROP INDEX teaches_id_index;
