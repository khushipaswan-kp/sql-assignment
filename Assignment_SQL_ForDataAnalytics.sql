CREATE DATABASE ContactManagement;
USE ContactManagement;
CREATE TABLE Company(
	CompanyID INT PRIMARY KEY,
    CompanyName Varchar(45),
    Street Varchar(45),
    City Varchar(45),
    State Varchar(2),
    Zip Varchar(10));
    
#1. Statement to create the Contact table 
CREATE TABLE Contact(
	ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName Varchar(45),
    LatName Varchar(45),
    Street Varchar(45),
    City Varchar(45),
    State Varchar(2),
    Zip Varchar(10),
    IsMain Boolean,
    Email Varchar(45),
    Phone Varchar(12),
    FOREIGN KEY(CompanyID) REFERENCES Company(CompanyID));

#2. Statement to create the Employee table
CREATE TABLE Employee(
	EmployeeID INT PRIMARY KEY,
    FirstName Varchar(45),
    LatName Varchar(45),
    Salary Decimal(10,2),
    HireDate DATE,
    JobTitle Varchar(25),
    Email Varchar(45),
    Phone Varchar(12));

#3. Statement to create the ContactEmployee table
CREATE TABLE ContactEmployee(
	ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY(ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID));
    
#4. In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800
UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley'
AND LastName = 'Bland';

#5. In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyID = 1004 AND CompanyName = 'Urban Outfitters, Inc.';

/* 6. In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement). 
HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove. */

/* 7. Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL 
SELECT query in MySQL Workbench. Copy the results below as well. */

# 8. What is the significance of “%” and “_” operators in the LIKE statement?
/*
In SQL, the LIKE operator is used for pattern matching in SQL queries. The symbols % and _ are called wildcards, and they help you search 
for flexible patterns in text.
1. % (Percent wildcard)
	-Represents zero, one, or multiple characters
	-It is used when you don’t know (or don’t care) how many characters are in that position
Examples:
SELECT * FROM customers
WHERE name LIKE 'A%';
	Finds names starting with A (e.g., Asha, Amit, Alex)

SELECT * FROM customers
WHERE name LIKE '%n';
	Finds names ending with n (e.g., Karan, John)
    
SELECT * FROM customers
WHERE name LIKE '%ar%';
	Finds names containing "ar" anywhere (e.g., Karan, Harsh)
    
2. _ (Underscore wildcard)
	-Represents exactly one character
	-Used when you know the number of characters but not the exact letters
Examples:
SELECT * FROM customers
WHERE name LIKE '_a%';
	Second letter must be a (e.g., Raj, Sam, Manish)

SELECT * FROM customers
WHERE name LIKE 'R__';
	Exactly 3-letter names starting with R (e.g., Ram, Ron)

Key Difference
Wildcard	Meaning
%			Any number of characters (0 or more)
_			Exactly one character
*/

# 9. Explain normalization in the context of databases.
/*
Normalization in databases is the process of organizing data into tables properly so that:
	-data redundancy (duplicate data) is reduced
	-data inconsistency is avoided
	-storage is used efficiently
	-updating data becomes easier and safer

It is mainly used in **Relational Database Management Systems (RDBMS)** such as MySQL, PostgreSQL, and Oracle Database.

# Why Do We Need Normalization?
Suppose we have a table like this:

| StudentID | StudentName | Course | Teacher |
| --------- | ----------- | ------ | ------- |
| 1         | Ravi        | SQL    | Mehta   |
| 1         | Ravi        | Python | Shah    |
| 2         | Anita       | SQL    | Mehta   |

Notice:
* Student name “Ravi” repeats
* Teacher “Mehta” repeats
* If Ravi’s name changes, we must update it everywhere
* If one row is deleted accidentally, important information may be lost

This causes:
* redundancy
* update anomalies
* insertion anomalies
* deletion anomalies

Normalization solves these problems.
---
# Main Idea of Normalization
Break large tables into smaller related tables using keys.

Example:
## Students Table

| StudentID | StudentName |
| --------- | ----------- |
| 1         | Ravi        |
| 2         | Anita       |

## Courses Table

| CourseID | Course |
| -------- | ------ |
| 101      | SQL    |
| 102      | Python |

## Enrollments Table

| StudentID | CourseID |
| --------- | -------- |
| 1         | 101      |
| 1         | 102      |
| 2         | 101      |

Now:
* student names are stored once
* courses are stored once
* data is cleaner and easier to maintain

# Types (Normal Forms)

Normalization is done in stages called **Normal Forms**.
# 1NF (First Normal Form)

A table is in 1NF if:
	* each column contains atomic (single) values
	* no multiple values in one cell

❌ Not in 1NF:

| Student | Subjects    |
| ------- | ----------- |
| Ravi    | SQL, Python |

✅ In 1NF:

| Student | Subject |
| ------- | ------- |
| Ravi    | SQL     |
| Ravi    | Python  |

# 2NF (Second Normal Form)

A table is in 2NF if:
	* it is already in 1NF
	* non-key columns depend on the whole primary key

Example:

| StudentID | CourseID | StudentName |
| --------- | -------- | ----------- |
| 1         | 101      | Ravi        |

Here `StudentName` depends only on `StudentID`, not on the full combination `(StudentID, CourseID)`.
So we separate it.

# 3NF (Third Normal Form)

A table is in 3NF if:
	* it is already in 2NF
	* non-key columns should not depend on other non-key columns

Example:

| EmpID | DeptID | DeptName |
| ----- | ------ | -------- |
| 1     | D1     | Sales    |

`DeptName` depends on `DeptID`, not directly on `EmpID`.

So create separate department table.

# Advantages of Normalization
	-Reduces duplicate data
	-Improves data consistency
	-Saves storage space
	-Easier updates and maintenance
	-Better database design

# Disadvantages
	-Too many tables can make queries complex
	-More joins may slightly reduce performance

Because of this, some systems intentionally use **denormalization** for faster reading.

# Summary
Normalization is the process of structuring database tables to minimize redundancy and improve data integrity by dividing data into 
related tables and defining relationships between them.

Most commonly used normal forms are:
* 1NF
* 2NF
* 3NF
*/

# 10. What does a join in MySQL mean? 
/*
A JOIN in MySQL is used to combine rows from two or more tables based on a related column between them.
It helps retrieve related data stored in different tables.

# Why Do We Need JOIN?
In normalized databases, data is stored in separate tables.

Example:

## Students Table

| student_id | student_name |
| ---------- | ------------ |
| 1          | Ravi         |
| 2          | Anita        |

## Courses Table

| course_id | course_name |
| --------- | ----------- |
| 101       | SQL         |
| 102       | Python      |

## Enrollments Table

| student_id | course_id |
| ---------- | --------- |
| 1          | 101       |
| 1          | 102       |
| 2          | 101       |

If we want:
> “Which student enrolled in which course?”
the information is spread across multiple tables.
JOIN combines them.

# Example of JOIN

SELECT students.student_name, courses.course_name
FROM enrollments
JOIN students
ON enrollments.student_id = students.student_id
JOIN courses
ON enrollments.course_id = courses.course_id;

# Output

| student_name | course_name |
| ------------ | ----------- |
| Ravi         | SQL         |
| Ravi         | Python      |
| Anita        | SQL         |

# Meaning of JOIN

JOIN table_name
ON condition

* `JOIN` → combine tables
* `ON` → specifies matching condition

# Types of JOINs in MySQL

1. INNER JOIN
	Returns only matching rows from both tables.

## Example

SELECT *
FROM students
INNER JOIN enrollments
ON students.student_id = enrollments.student_id;

Only students having enrollment records are shown.

2. LEFT JOIN (LEFT OUTER JOIN)
	Returns:
		-all rows from left table
		-matching rows from right table

If no match exists → NULL values appear.

## Example

SELECT *
FROM students
LEFT JOIN enrollments
ON students.student_id = enrollments.student_id;

Even students with no enrollments will appear.

3. RIGHT JOIN
	Returns:
		-all rows from right table
		-matching rows from left table

4. FULL JOIN
	Returns all rows from both tables.

MySQL does not directly support FULL JOIN.
It is usually simulated using:

LEFT JOIN + UNION + RIGHT JOIN

5. SELF JOIN
	A table joins with itself.
	Useful when rows in same table are related.

Example:
	employee and manager relationship

SELECT e.firstName AS Employee,
       m.firstName AS Manager
FROM employees e
JOIN employees m
ON e.reportsTo = m.employeeNumber;

# Visual Understanding

Suppose:

## Table A

| id |
| -- |
| 1  |
| 2  |
| 3  |

## Table B

| id |
| -- |
| 2  |
| 3  |
| 4  |

### INNER JOIN

Common values only:

* 2
* 3

### LEFT JOIN

All from A:

* 1
* 2
* 3

### RIGHT JOIN

All from B:

* 2
* 3
* 4

---

# Real-Life Analogy

Imagine:

* one table stores students
* another stores marks

JOIN is like matching students with their marks using student ID.

---

# Summary

A JOIN in MySQL is used to combine related data from multiple tables using a common column.

Most commonly used joins:
* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* SELF JOIN

JOINs are extremely important because relational databases usually store data across multiple tables.
*/

# 11. What do you understand about DDL, DCL, and DML in MySQL? 
/*
In MySQL, SQL commands are divided into categories based on what they do.

Three important categories are:
	1. DDL → Data Definition Language
	2. DML → Data Manipulation Language
	3. DCL → Data Control Language

1. DDL (Data Definition Language)
DDL commands are used to define or change the structure of database objects such as:
	* databases
	* tables
	* columns

## Common DDL Commands

| Command    | Purpose                    |
| ---------- | -------------------------- |
| `CREATE`   | Create database/table      |
| `ALTER`    | Modify table structure     |
| `DROP`     | Delete database/table      |
| `TRUNCATE` | Remove all rows from table |
| `RENAME`   | Rename object              |

## Example: CREATE TABLE

CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    age INT
);
Creates a table named `students`.

## Example: ALTER TABLE

ALTER TABLE students
ADD email VARCHAR(100);
Adds a new column.

## Example: DROP TABLE

DROP TABLE students;
Deletes the entire table permanently.

# Important Point About DDL
	DDL changes the structure/schema of the database.
	Most DDL commands are **auto-committed**, meaning changes are saved immediately.

2. DML (Data Manipulation Language)
DML commands are used to work with the actual data inside tables.

## Common DML Commands

| Command  | Purpose                                                  |
| -------- | -------------------------------------------------------- |
| `INSERT` | Add new rows                                             |
| `UPDATE` | Modify existing rows                                     |
| `DELETE` | Remove rows                                              |
| `SELECT` | Retrieve data *(sometimes classified separately as DQL)* |

## Example: INSERT

INSERT INTO students
VALUES (1, 'Ravi', 20);
Adds a new record.

## Example: UPDATE

UPDATE students
SET age = 21
WHERE id = 1;
Updates Ravi’s age.

## Example: DELETE

DELETE FROM students
WHERE id = 1;
Deletes the row.

# Important Point About DML
	DML changes data, not structure.
	DML operations can usually be:
		* committed
		* rolled back
			using:
				COMMIT;
				ROLLBACK;

3. DCL (Data Control Language)
DCL commands are used to control:
	* permissions
	* access rights
	* security

## Common DCL Commands

| Command  | Purpose            |
| -------- | ------------------ |
| `GRANT`  | Give permissions   |
| `REVOKE` | Remove permissions |

## Example: GRANT

GRANT SELECT, INSERT
ON school.students
TO 'user1'@'localhost';
Allows user to read and insert data.

## Example: REVOKE

REVOKE INSERT
ON school.students
FROM 'user1'@'localhost';
Removes insert permission.

# Quick Comparison

| Feature  | DDL           | DML            | DCL            |
| -------- | ------------- | -------------- | -------------- |
| Works on | Structure     | Data           | Permissions    |
| Examples | CREATE, ALTER | INSERT, UPDATE | GRANT, REVOKE  |
| Purpose  | Define schema | Manage records | Control access |

# Summary

* **DDL** → defines database structure
* **DML** → manipulates table data
* **DCL** → controls user permissions

These categories help organize SQL operations logically in MySQL.
*/

# 12. What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?
/*
In MySQL, the **JOIN clause** is used to combine data from two or more tables based on a related column between them.
It allows you to retrieve related information that is stored separately in normalized tables.

The main role of a JOIN is to:
	* connect related tables
	* retrieve combined data
	* avoid duplicate storage of data
	* make relational databases useful

Without JOINs, you would need separate queries for each table.

# Example Scenario

Suppose we have two tables:

## Students Table

| student_id | student_name |
| ---------- | ------------ |
| 1          | Ravi         |
| 2          | Anita        |

## Marks Table

| student_id | marks |
| ---------- | ----- |
| 1          | 85    |
| 2          | 90    |

If we want:

> “Show student names with their marks”

we use JOIN.

# Example Query

SELECT students.student_name, marks.marks
FROM students
JOIN marks
ON students.student_id = marks.student_id;

# Output

| student_name | marks |
| ------------ | ----- |
| Ravi         | 85    |
| Anita        | 90    |

The JOIN matched rows where:

students.student_id = marks.student_id

# Syntax of JOIN

SELECT columns
FROM table1
JOIN table2
ON table1.common_column = table2.common_column;

# Common Types of JOINs

1. INNER JOIN
	Returns only matching rows from both tables.
	Most commonly used join.

## Example

SELECT *
FROM students
INNER JOIN marks
ON students.student_id = marks.student_id;

Only records which matches in both tables appear.

2. LEFT JOIN (LEFT OUTER JOIN)
	Returns:
		* all rows from left table
		* matching rows from right table
If no match exists, NULL is returned.

## Example

SELECT *
FROM students
LEFT JOIN marks
ON students.student_id = marks.student_id;

Even students without marks will appear.

3. RIGHT JOIN
	Returns:
		* all rows from right table
		* matching rows from left table

## Example

SELECT *
FROM students
RIGHT JOIN marks
ON students.student_id = marks.student_id;

All rows from `marks` table appear.

4. FULL JOIN
	Returns:
		* all matching rows
		* plus non-matching rows from both tables

Note: MySQL does not directly support FULL JOIN.

It is usually simulated using:

LEFT JOIN + UNION + RIGHT JOIN

5. SELF JOIN
	A table joins with itself.
	Useful when rows inside the same table are related.

Example:
* employee-manager relationship

SELECT e.firstName AS Employee,
       m.firstName AS Manager
FROM employees e
JOIN employees m
ON e.reportsTo = m.employeeNumber;

# Visual Understanding

Suppose:
## Table A

| id |
| -- |
| 1  |
| 2  |
| 3  |

## Table B

| id |
| -- |
| 2  |
| 3  |
| 4  |

## INNER JOIN

Common values only:

* 2
* 3

## LEFT JOIN

All rows from A:

* 1
* 2
* 3

## RIGHT JOIN

All rows from B:

* 2
* 3
* 4

# Why JOINs Are Important

JOINs help:

* connect normalized tables
* reduce data redundancy
* fetch meaningful combined information
* build complex reports and queries

They are one of the most important concepts in SQL and relational databases.

# Summary
	The MySQL JOIN clause is used to combine related data from multiple tables using a common column.
	Common joins include:
		* INNER JOIN
		* LEFT JOIN
		* RIGHT JOIN
		* FULL JOIN
		* SELF JOIN

JOINs are essential in relational databases because data is often distributed across multiple related tables.

*/