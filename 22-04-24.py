import mysql.connector

# Connect to MySQL server
conn = mysql.connector.connect(user='root',
                               host='localhost',
                               passwd='Sridhar@79',
                               database='dbmslab0304',
                               auth_plugin='mysql_native_password')

# Create a cursor object
cursor = conn.cursor()

order_by_salary_query = "SELECT * FROM instructor ORDER BY salary"
cursor.execute(order_by_salary_query)
salary_ordered_results = cursor.fetchall()
print("1. Tuples in the instructors relation ordered by salary:")
for row in salary_ordered_results:
    print(row)

courses_fall_spring_query = "SELECT * FROM TEACHES WHERE semester IN ('Fall', 'Spring') AND year IN (2017, 2018)"
cursor.execute(courses_fall_spring_query)
fall_spring_results = cursor.fetchall()
print("\n2. Courses that ran in Fall 2017 or in Spring 2018:")
for row in fall_spring_results:
    print(row)

courses_fall_spring_2017_2018_query = "SELECT * FROM TEACHES WHERE semester = 'Fall' AND year = 2017 \
                                        AND Course_id IN (SELECT Course_id FROM TEACHES WHERE semester = 'Spring' AND year = 2018)"
cursor.execute(courses_fall_spring_2017_2018_query)
fall_spring_2017_2018_results = cursor.fetchall()
print("\n3. Courses that ran in Fall 2017 and in Spring 2018:")
for row in fall_spring_2017_2018_results:
    print(row)

courses_fall_not_spring_2018_query = "SELECT * FROM TEACHES WHERE semester = 'Fall' AND year = 2017 \
                                      AND Course_id NOT IN (SELECT Course_id FROM TEACHES WHERE semester = 'Spring' AND year = 2018)"
cursor.execute(courses_fall_not_spring_2018_query)
fall_not_spring_2018_results = cursor.fetchall()
print("\n4. Courses that ran in Fall 2017 but not in Spring 2018:")
for row in fall_not_spring_2018_results:
    print(row)

insert_instructor_additional_query = """
INSERT INTO instructor (ID, name, dept_name, salary) 
VALUES ('10287', 'steve', 'Chemistry', 69000), 
       ('10254', 'Tom', 'Biology', 0)
"""
cursor.execute(insert_instructor_additional_query)
conn.commit()

null_salary_instructors_query = "SELECT * FROM instructor WHERE salary IS NULL"
cursor.execute(null_salary_instructors_query)
null_salary_results = cursor.fetchall()
print("\n6. Instructors whose salary is null:")
for row in null_salary_results:
    print(row)

avg_salary_cs_query = "SELECT AVG(salary) FROM instructor WHERE dept_name = 'Comp. Sci.'"
cursor.execute(avg_salary_cs_query)
avg_salary_cs_result = cursor.fetchone()
print("\n7. Average salary of instructors in the Computer Science department:", avg_salary_cs_result[0])

total_instructors_spring_2018_query = "SELECT COUNT(DISTINCT ID) FROM TEACHES WHERE semester = 'Spring' AND year = 2018"
cursor.execute(total_instructors_spring_2018_query)
total_instructors_spring_2018_result = cursor.fetchone()
print("\n8. Total number of instructors who teach a course in the Spring 2018 semester:", total_instructors_spring_2018_result[0])

teaches_tuples_count_query = "SELECT COUNT(*) FROM TEACHES"
cursor.execute(teaches_tuples_count_query)
teaches_tuples_count_result = cursor.fetchone()
print("\n9. Number of tuples in the TEACHES relation:", teaches_tuples_count_result[0])


avg_salary_dept_query = "SELECT dept_name, AVG(salary) FROM instructor GROUP BY dept_name"
cursor.execute(avg_salary_dept_query)
avg_salary_dept_results = cursor.fetchall()
print("\n10. Average salary of instructors in each department:")
for row in avg_salary_dept_results:
    print(row)

avg_salary_greater_than_42000_query = "SELECT dept_name, AVG(salary) FROM instructor GROUP BY dept_name HAVING AVG(salary) > 42000"
cursor.execute(avg_salary_greater_than_42000_query)
avg_salary_greater_than_42000_results = cursor.fetchall()
print("\n11. Departments with average salary greater than 42000:")
for row in avg_salary_greater_than_42000_results:
    print(row)

instructors_not_mozart_einstein_query = "SELECT * FROM instructor WHERE name NOT IN ('Mozart', 'Einstein')"
cursor.execute(instructors_not_mozart_einstein_query)
not_mozart_einstein_results = cursor.fetchall()
print("\n12. Instructors whose name is neither 'Mozart' nor 'Einstein':")
for row in not_mozart_einstein_results:
    print(row)

instructors_higher_salary_biology_query = "SELECT name FROM instructor WHERE salary > (SELECT MAX(salary) FROM instructor WHERE dept_name = 'Biology')"
cursor.execute(instructors_higher_salary_biology_query)
higher_salary_biology_results = cursor.fetchall()
print("\n13. Instructors with salary greater than some instructor in the Biology department:")
for row in higher_salary_biology_results:
    print(row)

instructors_higher_salary_all_biology_query = "SELECT name FROM instructor WHERE salary > ALL (SELECT salary FROM instructor WHERE dept_name = 'Biology')"
cursor.execute(instructors_higher_salary_all_biology_query)
higher_salary_all_biology_results = cursor.fetchall()
print("\n14. Instructors with salary greater than all instructors in the Biology department:")
for row in higher_salary_all_biology_results:
    print(row)

avg_salary_gt_42000_dept_query = "SELECT dept_name, AVG(salary) FROM instructor GROUP BY dept_name HAVING AVG(salary) > 42000"
cursor.execute(avg_salary_gt_42000_dept_query)
avg_salary_gt_42000_dept_results = cursor.fetchall()
print("\n15. Average instructors’ salaries of departments where average salary is greater than 42,000:")
for row in avg_salary_gt_42000_dept_results:
    print(row)

dept_total_salary_gt_avg_query = "SELECT dept_name FROM instructor GROUP BY dept_name HAVING SUM(salary) > (SELECT AVG(total_salary) FROM (SELECT SUM(salary) AS total_salary FROM instructor GROUP BY dept_name) AS subquery)"
cursor.execute(dept_total_salary_gt_avg_query)
dept_total_salary_gt_avg_results = cursor.fetchall()
print("\n16. Departments where total salary is greater than average of total salary at all departments:")
for row in dept_total_salary_gt_avg_results:
    print(row)

instructors_courses_taught_query = "SELECT instructor.name, TEACHES.Course_id FROM instructor JOIN TEACHES ON instructor.ID = TEACHES.ID"
cursor.execute(instructors_courses_taught_query)
instructors_courses_taught_results = cursor.fetchall()
print("\n17. Names of instructors along with course ID of the courses they taught:")
for row in instructors_courses_taught_results:
    print(row)

instructors_courses_taught_null_query = "SELECT instructor.name, IFNULL(TEACHES.Course_id, 'NULL') FROM instructor LEFT JOIN TEACHES ON instructor.ID = TEACHES.ID"
cursor.execute(instructors_courses_taught_null_query)
instructors_courses_taught_null_results = cursor.fetchall()
print("\n18. Names of instructors along with course ID of the courses they taught (NULL if no courses taught):")
for row in instructors_courses_taught_null_results:
    print(row)
    
# Close cursor and connection
cursor.close()
conn.close()


#output

# ❯ python 22-04-24.py
# 1. Tuples in the instructors relation ordered by salary:
# (10212, 'Tom', 'Biology', 0)
# (15151, 'Mozart', 'Music', 40000)
# (32343, 'El Said', 'History', 60000)
# (58583, 'Califieri', 'History', 62000)
# (10101, 'Srinivasan', 'Comp. Sci.', 65000)
# (10211, 'Smith', 'Biology', 66000)
# (76766, 'Crick', 'Biology', 72000)
# (45565, 'Katz', 'Comp. Sci.', 75000)
# (98345, 'Kim', 'Elec. Eng.', 80000)
# (76543, 'Singh', 'Finance', 80000)
# (33456, 'Gold', 'Physics', 87000)
# (12121, 'Wu', 'Finance', 90000)
# (83821, 'Brandt', 'Comp. Sci.', 92000)
# (22222, 'Einstein', 'Physics', 95000)

# 2. Courses that ran in Fall 2017 or in Spring 2018:
# (10101, 'CS-101', '1', 'Fall', 2017)
# (10101, 'CS-315', '1', 'Spring', 2018)
# (10101, 'CS-347', '1', 'Fall', 2017)
# (12121, 'FIN-201', '1', 'Spring', 2018)
# (15151, 'MU-199', '1', 'Spring', 2018)
# (22222, 'PHY-101', '1', 'Fall', 2017)
# (32343, 'HIS-351', '1', 'Spring', 2018)
# (45565, 'CS-101', '1', 'Spring', 2018)
# (45565, 'CS-319', '1', 'Spring', 2018)
# (83821, 'CS-190', '2', 'Spring', 2017)
# (83821, 'CS-319', '2', 'Spring', 2018)
# (98345, 'EE-181', '1', 'Spring', 2017)

# 3. Courses that ran in Fall 2017 and in Spring 2018:
# (10101, 'CS-101', '1', 'Fall', 2017)

# 4. Courses that ran in Fall 2017 but not in Spring 2018:
# (10101, 'CS-347', '1', 'Fall', 2017)
# (22222, 'PHY-101', '1', 'Fall', 2017)

# 6. Instructors whose salary is null:

# 7. Average salary of instructors in the Computer Science department: 77333.3333

# 8. Total number of instructors who teach a course in the Spring 2018 semester: 6

# 9. Number of tuples in the TEACHES relation: 14

# 10. Average salary of instructors in each department:
# ('Biology', Decimal('34500.0000'))
# ('Chemistry', Decimal('69000.0000'))
# ('Comp. Sci.', Decimal('77333.3333'))
# ('Elec. Eng.', Decimal('80000.0000'))
# ('Finance', Decimal('85000.0000'))
# ('History', Decimal('61000.0000'))
# ('Music', Decimal('40000.0000'))
# ('Physics', Decimal('91000.0000'))

# 11. Departments with average salary greater than 42000:
# ('Chemistry', Decimal('69000.0000'))
# ('Comp. Sci.', Decimal('77333.3333'))
# ('Elec. Eng.', Decimal('80000.0000'))
# ('Finance', Decimal('85000.0000'))
# ('History', Decimal('61000.0000'))
# ('Physics', Decimal('91000.0000'))

# 12. Instructors whose name is neither 'Mozart' nor 'Einstein':
# (10101, 'Srinivasan', 'Comp. Sci.', 65000)
# (10211, 'Smith', 'Biology', 66000)
# (10212, 'Tom', 'Biology', 0)
# (10254, 'Tom', 'Biology', 0)
# (10287, 'steve', 'Chemistry', 69000)
# (12121, 'Wu', 'Finance', 90000)
# (32343, 'El Said', 'History', 60000)
# (33456, 'Gold', 'Physics', 87000)
# (45565, 'Katz', 'Comp. Sci.', 75000)
# (58583, 'Califieri', 'History', 62000)
# (76543, 'Singh', 'Finance', 80000)
# (76766, 'Crick', 'Biology', 72000)
# (83821, 'Brandt', 'Comp. Sci.', 92000)
# (98345, 'Kim', 'Elec. Eng.', 80000)

# 13. Instructors with salary greater than some instructor in the Biology department:
# ('Wu',)
# ('Einstein',)
# ('Gold',)
# ('Katz',)
# ('Singh',)
# ('Brandt',)
# ('Kim',)

# 14. Instructors with salary greater than all instructors in the Biology department:
# ('Wu',)
# ('Einstein',)
# ('Gold',)
# ('Katz',)
# ('Singh',)
# ('Brandt',)
# ('Kim',)

# 15. Average instructors’ salaries of departments where average salary is greater than 42,000:
# ('Chemistry', Decimal('69000.0000'))
# ('Comp. Sci.', Decimal('77333.3333'))
# ('Elec. Eng.', Decimal('80000.0000'))
# ('Finance', Decimal('85000.0000'))
# ('History', Decimal('61000.0000'))
# ('Physics', Decimal('91000.0000'))

# 16. Departments where total salary is greater than average of total salary at all departments:
# ('Biology',)
# ('Comp. Sci.',)
# ('Finance',)
# ('Physics',)

# 17. Names of instructors along with course ID of the courses they taught:
# ('Srinivasan', 'CS-101')
# ('Srinivasan', 'CS-315')
# ('Srinivasan', 'CS-347')
# ('Wu', 'FIN-201')
# ('Mozart', 'MU-199')
# ('Einstein', 'PHY-101')
# ('El Said', 'HIS-351')
# ('Katz', 'CS-101')
# ('Katz', 'CS-319')
# ('Crick', 'BIO-101')
# ('Crick', 'BIO-301')
# ('Brandt', 'CS-190')
# ('Brandt', 'CS-319')
# ('Kim', 'EE-181')

# 18. Names of instructors along with course ID of the courses they taught (NULL if no courses taught):
# ('Srinivasan', 'CS-101')
# ('Srinivasan', 'CS-315')
# ('Srinivasan', 'CS-347')
# ('Smith', 'NULL')
# ('Tom', 'NULL')
# ('Tom', 'NULL')
# ('steve', 'NULL')
# ('Wu', 'FIN-201')
# ('Mozart', 'MU-199')
# ('Einstein', 'PHY-101')
# ('El Said', 'HIS-351')
# ('Gold', 'NULL')
# ('Katz', 'CS-101')
# ('Katz', 'CS-319')
# ('Califieri', 'NULL')
# ('Singh', 'NULL')
# ('Crick', 'BIO-101')
# ('Crick', 'BIO-301')
# ('Brandt', 'CS-190')
# ('Brandt', 'CS-319')
# ('Kim', 'EE-181')