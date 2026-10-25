# SQL Querying Data: Employee Database

A collection of MySQL queries demonstrating data insertion, filtering, sorting, aggregation, grouping and joins on a relational employee database.

This project is **Assignment 2** and builds on the schema created in Assignment 1 (DDL).

---

## Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Sample Data](#sample-data)
- [Concepts Covered](#concepts-covered)
- [Query Reference](#query-reference)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Tech Stack](#tech-stack)

---

## Overview

The script populates three related tables (`Departments`, `Location`, `Employees`) with sample data and then runs a series of queries that answer common analytical questions, such as:

- Which employees earn above a threshold and were hired before a given date?
- What is the total salary spent on a particular department?
- Which locations have the highest salary, and where is the average age of female employees below 30?
- How many employees does each department have, including departments with none?

## Database Schema

Database name: `employee`

| Table | Columns | Description |
|---|---|---|
| `Departments` | `department_id`, `department_name` | Company departments |
| `Location` | `location_id`, `location_name` | Office locations |
| `Employees` | `employee_id`, `employee_name`, `gender`, `age`, `hire_date`, `designation`, `department_id`, `location_id`, `salary` | Employee records |

**Relationships**

- `Employees.department_id` references `Departments.department_id`
- `Employees.location_id` references `Location.location_id`

> The tables are created in Assignment 1 (DDL). Run that script first so the `employee` database and its tables exist.

## Sample Data

| Table | Records | Notes |
|---|---|---|
| `Departments` | 5 | Finance, IT, HR, Marketing, Research |
| `Location` | 5 | Kozhikode, Kochi, Kannur, Thalassery, Trissur |
| `Employees` | 10 | Salaries from 40,000 to 75,000; hire dates from 2015 to 2022 |

One employee (ID 126) is inserted with a `NULL` designation on purpose, to demonstrate `IS NULL` filtering and the `UPDATE` statement that corrects it.

## Concepts Covered

| Category | Concepts |
|---|---|
| Data manipulation | `INSERT`, `UPDATE` |
| Retrieval | `SELECT`, `DISTINCT`, column aliases |
| Filtering | `WHERE`, `AND`, `LIKE`, `IS NULL`, comparison operators |
| Sorting and limiting | `ORDER BY` (multi-column), `LIMIT` |
| Aggregation | `SUM`, `MIN`, `MAX`, `AVG`, `COUNT` |
| Grouping | `GROUP BY`, `HAVING` |
| Joins | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` |

## Query Reference

### 1. Inserting Data
Populates `Departments`, `Location` and `Employees`, then verifies each table with `SELECT *`.

### 2. DISTINCT
Lists the unique salary values.
```sql
SELECT DISTINCT salary FROM Employees;
```

### 3. Aliases
Renames columns in the output for readability.
```sql
SELECT age AS Employee_age, salary AS Employee_salary FROM Employees;
```

### 4. WHERE Clause and Operators
Employees earning more than 50,000 who were hired before 2016.
```sql
SELECT * FROM Employees
WHERE salary > 50000 AND hire_date < '2016-01-01';
```

Finds employees with a missing designation, then fixes the record.
```sql
SELECT * FROM Employees WHERE designation IS NULL;
UPDATE Employees SET designation = 'Data Scientist' WHERE employee_id = 126;
```

### 5. ORDER BY
Sorts by department (ascending), then by salary (highest first) within each department.
```sql
SELECT * FROM Employees ORDER BY department_id ASC, salary DESC;
```

### 6. LIMIT
The first five employees hired during 2018, in hiring order.
```sql
SELECT * FROM Employees
WHERE hire_date >= '2018-01-01' AND hire_date < '2019-01-01'
ORDER BY hire_date ASC
LIMIT 5;
```

### 7. Aggregate Functions
Total salary of the Finance department, and the youngest employee's age.
```sql
SELECT SUM(e.salary) AS Total_finance_salary
FROM Employees e
INNER JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

SELECT MIN(age) AS minimum_age FROM Employees;
```

### 8. GROUP BY
Highest salary per location, and average salary for each analyst role.
```sql
SELECT location_id, MAX(salary) AS maximum_salary
FROM Employees
GROUP BY location_id;

SELECT designation, AVG(salary) AS average_salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;
```

### 9. HAVING
Departments with fewer than three employees, and locations where the average age of female employees is under 30.
```sql
SELECT department_id, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY department_id
HAVING COUNT(*) < 3;

SELECT location_id, AVG(age) AS Average_Age
FROM Employees
WHERE gender = 'F'
GROUP BY location_id
HAVING AVG(age) < 30;
```

### 10. Joins
**Inner join:** each employee with their department name.
```sql
SELECT e.employee_name, e.designation, d.department_name
FROM Employees AS e
INNER JOIN Departments AS d ON e.department_id = d.department_id;
```

**Left join:** every department with its employee count, including departments with no employees.
```sql
SELECT d.department_name, COUNT(e.employee_id) AS Total_Employees
FROM Departments AS d
LEFT JOIN Employees AS e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
```

**Right join:** every location with the employees based there, including locations with none.
```sql
SELECT l.location_name, e.employee_name
FROM Employees AS e
RIGHT JOIN Location AS l ON e.location_id = l.location_id;
```

## Tech Stack

- **Database:** MySQL
- **Language:** SQL

## Author

**Dhinsha**
