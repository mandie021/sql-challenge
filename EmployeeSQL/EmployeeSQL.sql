--DATA ENGINEERING--

--creating deparments table for csv
CREATE TABLE departments (
 	dept_no VARCHAR(5),
	dept_name VARCHAR(35)
);

-- verify feilds are there and imported
SELECT *
from departments;

--creating dept_emp table for csv
CREATE TABLE dept_emp (
 	emp_no INT,
	dept_no VARCHAR(5)
);

-- verify feilds are there and imported
SELECT *
from dept_emp;

--creating dept_manager table for csv
CREATE TABLE dept_manager (
	dept_no VARCHAR(5),
	emp_no INT
);

-- verify feilds are there and imported
SELECT *
from dept_manager;

--creating employees table for csv
CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR(20),
	last_name VARCHAR(30),
	sex VARCHAR(5),
	hire_date DATE
);

-- verify feilds are there and imported
SELECT *
from employees;


--creating salaries table for csv
CREATE TABLE salaries (
	emp_no INT,
	salary INT
);

-- verify feilds are there and imported
SELECT *
from salaries;


--creating titles table for csv
CREATE TABLE titles (
	title_id VARCHAR(5),
	title VARCHAR (35)
);

-- verify feilds are there and imported
SELECT *
from titles;

--DATA ANALYSIS--

--List the following details of each employee: employee number, last name, first name, sex, and salary.
--use tables employees and salaries
SELECT emp.emp_no, 
	emp.last_name, 
	emp.first_name, 
	emp.sex, 
	sal.salary
from employees AS emp
INNER JOIN salaries AS sal ON
emp.emp_no = sal.emp_no;


--List first name, last name, and hire date for employees who were hired in 1986.
--use tables employees and between syntax for date for hire date
SELECT emp.first_name,
	emp.last_name,
	emp.hire_date
FROM employees AS emp
WHERE emp.hire_date BETWEEN '1985-12-31' and '1987-01-01';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
--use tables departments, dept_emp, dep_manager, and employees
SELECT d.dept_no AS "Department Number",
	d.dept_name AS "Department Name",
	dman.emp_no AS "Managers Employee Number",
	emp.last_name AS "Employee Last Name",
	emp.first_name AS "Employee First Name"
FROM employees AS emp
	JOIN dept_emp AS demp
	ON (emp.emp_no = demp.emp_no)
		JOIN dept_manager AS dman
		ON (demp.emp_no = dman.emp_no)
			JOIN departments AS d
			ON (dman.dept_no = d.dept_no);
			

--List the department of each employee with the following information: employee number, last name, first name, and department name.
--use tables employees and dept_emp, and departments

SELECT emp.emp_no AS "Employee Number",
	emp.last_name AS "Last Name",
	emp.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM employees AS emp
	JOIN dept_emp AS demp
	ON (emp.emp_no = demp.emp_no)
		JOIN departments AS d
		ON (demp.dept_no = d.dept_no);


--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
--use tables employees, where first name is = 'Hercules' AND last name LIKE '%B'

SELECT emp.first_name AS "First Name",
	emp.last_name AS "Last Name",
	emp.sex AS "Sex"
FROM employees as emp
WHERE emp.first_name = 'Hercules'
AND emp.last_name LIKE 'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name.
--use tables employees, dept_emp, departments

SELECT emp.emp_no AS "Employee Number",
	emp.last_name AS "Last Name",
	emp.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM employees AS emp
	JOIN dept_emp AS demp
	ON (emp.emp_no = demp.emp_no)
		JOIN departments AS d
		ON (demp.dept_no = d.dept_no)
		WHERE d.dept_name = 'Sales';
		

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp.emp_no AS "Employee Number",
	emp.last_name AS "Last Name",
	emp.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM employees AS emp
	JOIN dept_emp AS demp
	ON (emp.emp_no = demp.emp_no)
		JOIN departments AS d
		ON (demp.dept_no = d.dept_no)
		WHERE d.dept_name = 'Sales'
		OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
--use table employees

SELECT last_name as "Last Name", COUNT(last_name) AS "Count of Last Name"
FROM employees
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;


