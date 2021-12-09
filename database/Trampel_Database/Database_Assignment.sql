CREATE DATABASE IF NOT EXISTS workplace;

USE workplace;

DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department(
	department_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    budget DOUBLE NOT NULL
)ENGINE InnoDB;
DROP TABLE IF EXISTS project;
CREATE TABLE IF NOT EXISTS project(
	project_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    project_name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
	status VARCHAR(30) NOT NULL,
    department_ID INT NOT NULL,
    FOREIGN KEY (department_id)
	REFERENCES department(department_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)ENGINE InnoDB;
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee(
	employee_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    hire_date DATE NOT NULL,
    salary DOUBLE NOT NULL,
    department_ID INT NOT NULL,
    FOREIGN KEY (department_id) 
    REFERENCES department(department_id)
)ENGINE InnoDB;
DROP TABLE IF EXISTS employee_project_conjunction;
CREATE TABLE IF NOT EXISTS employee_project_conjunction(
  employee_project_pk INT PRIMARY KEY NOT NULL,
  employee_id INT NOT NULL,
  project_id INT NOT NULL,
  FOREIGN KEY (employee_id) 
  REFERENCES employee(employee_id),
  FOREIGN KEY (project_id) 
  REFERENCES project(project_id)
)ENGINE InnoDB;


INSERT INTO department(department_id, department_name, budget)
VALUES (1, 'Marketing', 100000.00);

INSERT INTO department(department_id, department_name, budget)
VALUES (2, 'Sales', 2000000.00);

INSERT INTO department(department_id, department_name, budget)
VALUES (3, 'Finance', 50000.00);

INSERT INTO employee(employee_id, first_name, last_name, hire_date, salary, department_ID)
VALUES (1, 'John', 'Smith', '2020-08-01', 25000.00, 2);

INSERT INTO employee(employee_id, first_name, last_name, hire_date, salary, department_ID)
VALUES (2, 'Kara', 'Jones', '2013-11-29', 40000.00, 3);

INSERT INTO employee(employee_id, first_name, last_name, hire_date, salary, department_ID)
VALUES (3, 'Thomas', 'Goldstein', '2016-06-13', 36000.00, 1);

INSERT INTO project(project_id, project_name, start_date, status, department_ID)
VALUES (107, 'Sales Reports', '2021-10-17', 'Active', 2);

INSERT INTO project(project_id, project_name, start_date, status, department_ID)
VALUES (98, 'New Product Marketing Plan', '2020-06-04', 'Inactive', 1);

INSERT INTO project(project_id, project_name, start_date, status, department_ID)
VALUES (102, 'Budgeting Revisions', '2021-02-26', 'Active', 3);

INSERT INTO employee_project_conjunction(employee_project_pk, employee_id, project_id)
VALUES (1, 1, 107);

INSERT INTO employee_project_conjunction(employee_project_pk, employee_id, project_id)
VALUES (2, 3, 98);

INSERT INTO employee_project_conjunction(employee_project_pk, employee_id, project_id)
VALUES (3, 2, 102);

-- Q1: List all of the employees.
SELECT first_name as FirstName, last_name as LastName
FROM employee;

-- Q2: Find a particular employee by name.
SELECT first_name as FirstName, last_name as LastName FROM employee 
WHERE first_name = 'John' AND last_name = 'Smith';

-- Q3: List the departments that have budgets greater than $50,000.
SELECT department_name AS DepartmentName, budget as Budget FROM department 
WHERE Budget > 50000;

-- Q4: List the projects ordered by Start Date.
SELECT project_name AS ProjectName, start_date as StartDate FROM project 
ORDER BY StartDate ASC;

-- Q5: List all projects that are no longer active.
SELECT project_name AS ProjectName, status AS Status FROM project
WHERE Status = 'Inactive';
