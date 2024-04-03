CREATE TABLE CUSTOMERS 
(
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);

INSERT INTO CUSTOMERS VALUES 
(
  1, 
  'Ramesh', 
  32, 
  'Ahmedabad', 
  2000.00 
);
INSERT INTO CUSTOMERS VALUES
(
  2, 
  'Khilan', 
  25, 
  'Delhi', 
  1500.00 
);
INSERT INTO CUSTOMERS VALUES
(
  3, 
  'Kaushik', 
  23, 
  'Kota', 
  2000.00 
);
INSERT INTO CUSTOMERS VALUES 
(
  4, 
  'Chaitali', 
  25, 
  'Mumbai', 
  6500.00 
);

SELECT * FROM CUSTOMERS;

CREATE TABLE CUSTOMERS_BACKUP 
(
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   PRIMARY KEY (ID)
);

DELIMITER //
CREATE PROCEDURE FetchCustomers()
BEGIN
   DECLARE done INT DEFAULT FALSE;
   DECLARE customer_id INT;
   DECLARE customer_name VARCHAR(255);
   DECLARE auto_id INT; 

   -- Declare cursor
   DECLARE MY_CURSOR CURSOR FOR
   SELECT id, name FROM CUSTOMERS;

   -- Declare exit handler
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

   -- Open cursor
   OPEN MY_CURSOR;

   -- Fetch and insert rows
   read_loop: LOOP
      FETCH MY_CURSOR INTO customer_id, customer_name;
      IF done = 1 THEN
         LEAVE read_loop;
      END IF;

      -- Insert the fetched data into the backup table
      INSERT INTO customers_backup VALUES
      (
        customer_id, 
        customer_name
      );
		        
      -- Get the last auto-generated ID used in the insertion
      SET auto_id = LAST_INSERT_ID();

   END LOOP;
	
    -- Close cursor
    CLOSE MY_CURSOR;
END //
DELIMITER ;

CALL FetchCustomers();

SELECT * FROM CUSTOMERS_BACKUP;

create table employees(
emp_id int primary key,
first_name varchar(20),
hourly_pay int,
job varchar(20)
);

insert into employees values(1,"xxx",100,"manager");
insert into employees values(2,"yyy",90,"cashier");
insert into employees values(3,"zzz",80,"cook");
insert into employees values(4,"eee",750,"teacher");
select * from employees;

alter table employees
add column salary decimal(10,2) after hourly_pay;
select * from employees;

update employees
set salary = hourly_pay * 2080;
select * from employees;

create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = (new.hourly_pay * 2080);
select * from employees;

show trigger;

 update employees
    -> set hourly_pay = 50
    -> where emp_id = 1;

update employees
    -> set hourly_pay = hourly_pay +1;

delete from employees
    -> where emp_id = 4;

 create trigger before_hourly_pay_insert
    -> before insert on employees
    -> for each row
    -> set new.salary = (new.hourly_pay * 2080);

insert into employees
    -> values(4, "aaa",290,null,"teacher")


select * from employees;


mysql> create table expenses(
    -> expense_id int primary key,
    -> expense_name varchar(50),
    -> expense_total decimal(10,2));

 insert into expenses
    -> values (1,"salaries",0),
    -> values (2,"supplies",0),
    -> values (3,"taxes", 0);


 update expenses
    -> set expense_total = (select sum(salary) from employees)
    -> where expense_name = "salaries";

select * from expenses;


 create trigger after_salary_delete
    -> after delete on employees
    -> for each row
    -> update expenses
    -> set expense_total = expense_total - old.salary
    -> where expense_name = "salaries";

 delete from employees where emp_id = 3;

 select * from expenses;


create trigger after_salary_insert
    -> after insert on employees
    -> for each row
    -> update expenses
    -> set expense_total = expense_total + new.salary
    -> where expense_name = "salaries";

insert into employees values( 3, "jjj",180,null,"doctor");

 select * from expenses;

Output:

+----+----------+-----+-----------+---------+
| ID | NAME     | AGE | ADDRESS   | SALARY  |
+----+----------+-----+-----------+---------+
|  1 | Ramesh   |  32 | Ahmedabad | 2000.00 |
|  2 | Khilan   |  25 | Delhi     | 1500.00 |
|  3 | Kaushik  |  23 | Kota      | 2000.00 |
|  4 | Chaitali |  25 | Mumbai    | 6500.00 |
+----+----------+-----+-----------+---------+
+----+----------+
| ID | NAME     |
+----+----------+
|  1 | Ramesh   |
|  2 | Khilan   |
|  3 | Kaushik  |
|  4 | Chaitali |
+----+----------+
+--------+------------+------------+---------+
| emp_id | first_name | hourly_pay | job     |
+--------+------------+------------+---------+
|      1 | *****      |        100 | manager |
|      2 | yyy        |         90 | cashier |
|      3 | zzz        |         80 | cook    |
|      4 | eee        |        750 | teacher |
+--------+------------+------------+---------+
+--------+------------+------------+--------+---------+
| emp_id | first_name | hourly_pay | salary | job     |
+--------+------------+------------+--------+---------+
|      1 | *****      |        100 |   NULL | manager |
|      2 | yyy        |         90 |   NULL | cashier |
|      3 | zzz        |         80 |   NULL | cook    |
|      4 | eee        |        750 |   NULL | teacher |
+--------+------------+------------+--------+---------+
+--------+------------+------------+------------+---------+
| emp_id | first_name | hourly_pay | salary     | job     |
+--------+------------+------------+------------+---------+
|      1 | *****      |        100 |  208000.00 | manager |
|      2 | yyy        |         90 |  187200.00 | cashier |
|      3 | zzz        |         80 |  166400.00 | cook    |
|      4 | eee        |        750 | 1560000.00 | teacher |
+--------+------------+------------+------------+---------+
