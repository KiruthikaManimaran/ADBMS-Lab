-- create
CREATE TABLE salesman (
  Salesman_id INTEGER PRIMARY KEY,
  Name TEXT NOT NULL,
  City TEXT NOT NULL,
  Commission FLOAT NOT NULL
);

-- insert
INSERT INTO salesman VALUES (5001, 'James Hoog', 'New York', '0.15'),
(5002, 'Nail Knite', 'Paris', '0.13'),
(5005, 'Pit Alex', 'London', '0.11'),
(5006, 'Mc Lyon', 'Paris', '0.14'),
(5003, 'Lauson Hen', '', '0.12'),
(5007, 'Paul Adam', 'Rome', '0.13');

-- create
CREATE TABLE customer (
  Customer_id INTEGER PRIMARY KEY,
  Customer_name TEXT NOT NULL,
  City TEXT NOT NULL,
  Grade INTEGER,
  Salesman_id INTEGER
);

INSERT INTO customer VALUES (3002, 'Nick Rimando', 'New York', '100', '5001'),
(3005, 'Graham Zusi', 'California', '200', '5002'),
(3001, 'Brad Guzan', 'London', NULL, NULL),
(3004, 'Fabian Johns', 'Paris', '300', '5006'),
(3007, 'Brad Davis', 'New York', '200', '5001'),
(3009, 'Geoff Camero', 'Berlin', '100', NULL),
(3008, 'Julian Green', 'London', '300', '5002'),
(3003, 'Jozy Altidor', 'Moncow', '200', '5007');


-- create
CREATE TABLE orders (
  Order_no INTEGER PRIMARY KEY,
  Purch_amt FLOAT NOT NULL,
  Order_date DATE NOT NULL,
  Customer_id INTEGER,
  Salesman_id INTEGER
);

INSERT INTO orders VALUES (70001, '150.5', '2016-10-05', '3005', '5002'),
(70009, '270.65', '2016-09-10', '3001', NULL),
(70002, '65.26', '2016-10-05', '3002', '5001'),
(70004, '110.5', '2016-08-17', '3009', NULL),
(70007, '948.5', '2016-09-10', '3005', '5002'),
(70005, '2400.6', '2016-07-27', '3007', '5001' ),
(70008, '5760', '2016-09-10', '3002', '5001'),
(70010, '1983.43', '2016-10-10', '3004', '5006'),
(70003, '2480.4', '2016-10-10', '3009', NULL),
(70012, '250.45', '2016-06-27', '3008', '5002'),
(70011, '75.29', '2016-08-17', '3003', '5007');

-- fetch 
SELECT Name, Commission FROM `salesman`;
SELECT DISTINCT Salesman_id FROM orders;
SELECT Name, City FROM `salesman` where City = "Paris";
SELECT * FROM customer where Grade = "200";
SELECT Order_no, Order_date, Purch_amt FROM orders where Salesman_id = "5001";

-- create
CREATE TABLE nobel_win (
  Year INTEGER,
  Subject TEXT NOT NULL,
  Winner TEXT NOT NULL,
  Country TEXT NOT NULL,
  Category TEXT NOT NULL
);

INSERT INTO nobel_win VALUES (1994, 'Literature', 'Kenzaburo Oe', 'Japan', 'Linguist'),
(1994, 'Economics', 'Reinhard Selten', 'Germany', 'Economist'),
(1987, 'Chemistry', 'Donald J. Cram', 'USA', 'Scientist'),
(1987, 'Chemistry', 'Jean-Marie Lehn', 'France', 'Scientist'),
(1987, 'Literature', 'Joseph Brodsky', 'Russia', 'Linguist'),
(1987, 'Economics', 'Robert Solow', 'USA', 'Economist' ),
(1971, 'Chemistry', 'Gerhard Herzberg', 'Germany', 'Scientist'),
(1971, 'Literature', 'Pablo Neruda', 'Chile', 'Linguist'),
(1971, 'Economics', 'Simon Kuznets', 'Russia', 'Economist'),
(1970, 'Literature', 'Aleksandr Solzhentisyn', 'Russia', 'Linguist'),
(1970, 'Chemistry', 'Louis Federico Leloir', 'France', 'Scientist'),
(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
(1970, 'Physics', 'Louis Neel', 'France', 'Scientist'),
(1970, 'Physics', 'Hannes Alfvwn', 'Sweden', 'Scientist');


-- fetch 
SELECT Name, Commission FROM `salesman`;
SELECT DISTINCT Salesman_id FROM orders;
SELECT Name, City FROM `salesman` where City = "Paris";
SELECT * FROM customer where Grade = "200";
SELECT Order_no, Order_date, Purch_amt FROM orders where Salesman_id = "5001";
SELECT Winner FROM nobel_win where Year = 1971 AND Subject = "Literature";
SELECT * FROM nobel_win where Winner LIKE "Louis%";
SELECT * FROM nobel_win where (Subject = "Physics" AND Year = 1970) UNION 
SELECT * FROM nobel_win where (Subject = "Economics" AND Year = 1971);
SELECT * FROM nobel_win where Year = 1970 AND Subject NOT IN ("Physiology", "Economics");
SELECT * FROM nobel_win where Subject NOT LIKE 'P%' Order by Year DESC, Winner;

Output:

+------------+------------+
| Name       | Commission |
+------------+------------+
| James Hoog |       0.15 |
| Nail Knite |       0.13 |
| Lauson Hen |       0.12 |
| Pit Alex   |       0.11 |
| Mc Lyon    |       0.14 |
| Paul Adam  |       0.13 |
+------------+------------+
+-------------+
| Salesman_id |
+-------------+
|        5002 |
|        5001 |
|        NULL |
|        5006 |
|        5007 |
+-------------+
+------------+-------+
| Name       | City  |
+------------+-------+
| Nail Knite | Paris |
| Mc Lyon    | Paris |
+------------+-------+
+-------------+---------------+------------+-------+-------------+
| Customer_id | Customer_name | City       | Grade | Salesman_id |
+-------------+---------------+------------+-------+-------------+
|        3003 | Jozy Altidor  | Moncow     |   200 |        5007 |
|        3005 | Graham Zusi   | California |   200 |        5002 |
|        3007 | Brad Davis    | New York   |   200 |        5001 |
+-------------+---------------+------------+-------+-------------+
+----------+------------+-----------+
| Order_no | Order_date | Purch_amt |
+----------+------------+-----------+
|    70002 | 2016-10-05 |     65.26 |
|    70005 | 2016-07-27 |    2400.6 |
|    70008 | 2016-09-10 |      5760 |
+----------+------------+-----------+
+------------+------------+
| Name       | Commission |
+------------+------------+
| James Hoog |       0.15 |
| Nail Knite |       0.13 |
| Lauson Hen |       0.12 |
| Pit Alex   |       0.11 |
| Mc Lyon    |       0.14 |
| Paul Adam  |       0.13 |
+------------+------------+
+-------------+
| Salesman_id |
+-------------+
|        5002 |
|        5001 |
|        NULL |
|        5006 |
|        5007 |
+-------------+
+------------+-------+
| Name       | City  |
+------------+-------+
| Nail Knite | Paris |
| Mc Lyon    | Paris |
+------------+-------+
+-------------+---------------+------------+-------+-------------+
| Customer_id | Customer_name | City       | Grade | Salesman_id |
+-------------+---------------+------------+-------+-------------+
|        3003 | Jozy Altidor  | Moncow     |   200 |        5007 |
|        3005 | Graham Zusi   | California |   200 |        5002 |
|        3007 | Brad Davis    | New York   |   200 |        5001 |
+-------------+---------------+------------+-------+-------------+
+----------+------------+-----------+
| Order_no | Order_date | Purch_amt |
+----------+------------+-----------+
|    70002 | 2016-10-05 |     65.26 |
|    70005 | 2016-07-27 |    2400.6 |
|    70008 | 2016-09-10 |      5760 |
+----------+------------+-----------+
+--------------+
| Winner       |
+--------------+
| Pablo Neruda |
+--------------+
+------+-----------+-----------------------+---------+-----------+
| Year | Subject   | Winner                | Country | Category  |
+------+-----------+-----------------------+---------+-----------+
| 1970 | Chemistry | Louis Federico Leloir | France  | Scientist |
| 1970 | Physics   | Louis Neel            | France  | Scientist |
+------+-----------+-----------------------+---------+-----------+
+------+-----------+---------------+---------+-----------+
| Year | Subject   | Winner        | Country | Category  |
+------+-----------+---------------+---------+-----------+
| 1970 | Physics   | Louis Neel    | France  | Scientist |
| 1970 | Physics   | Hannes Alfvwn | Sweden  | Scientist |
| 1971 | Economics | Simon Kuznets | Russia  | Economist |
+------+-----------+---------------+---------+-----------+
+------+------------+------------------------+---------+-----------+
| Year | Subject    | Winner                 | Country | Category  |
+------+------------+------------------------+---------+-----------+
| 1970 | Literature | Aleksandr Solzhentisyn | Russia  | Linguist  |
| 1970 | Chemistry  | Louis Federico Leloir  | France  | Scientist |
| 1970 | Physics    | Louis Neel             | France  | Scientist |
| 1970 | Physics    | Hannes Alfvwn          | Sweden  | Scientist |
+------+------------+------------------------+---------+-----------+
+------+------------+------------------------+---------+-----------+
| Year | Subject    | Winner                 | Country | Category  |
+------+------------+------------------------+---------+-----------+
| 1994 | Literature | Kenzaburo Oe           | Japan   | Linguist  |
| 1994 | Economics  | Reinhard Selten        | Germany | Economist |
| 1987 | Chemistry  | Donald J. Cram         | USA     | Scientist |
| 1987 | Chemistry  | Jean-Marie Lehn        | France  | Scientist |
| 1987 | Literature | Joseph Brodsky         | Russia  | Linguist  |
| 1987 | Economics  | Robert Solow           | USA     | Economist |
| 1971 | Chemistry  | Gerhard Herzberg       | Germany | Scientist |
| 1971 | Literature | Pablo Neruda           | Chile   | Linguist  |
| 1971 | Economics  | Simon Kuznets          | Russia  | Economist |
| 1970 | Literature | Aleksandr Solzhentisyn | Russia  | Linguist  |
| 1970 | Chemistry  | Louis Federico Leloir  | France  | Scientist |
| 1970 | Economics  | Paul Samuelson         | USA     | Economist |
+------+------------+------------------------+---------+-----------+
