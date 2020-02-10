DROP TABLE dept; 

CREATE TABLE dept(
	dept_no VARCHAR, 
	dept_name VARCHAR,
	PRIMARY KEY(dept_no)
); 

DROP TABLE dept_manager;
CREATE TABLE dept_manager(
	id SERIAL, 
	emp_no INT, 
	dept_no VARCHAR(30) NOT NULL, 
	from_date date,
	to_date date,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES dept(dept_no)
); 

DROP TABLE dept_employees; 
CREATE TABLE dept_employees(
	emp_no INT, 
	dept_no VARCHAR, 
	from_date date, 
	to_date date, 
	FOREIGN KEY (dept_no) REFERENCES dept(dept_no)
); 

DROP TABLE salaries; 
CREATE TABLE salaries(
	emp_no INT, 
	salary money, 
	from_date date, 
	to_date date,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
); 

DROP TABLE titles; 
CREATE TABLE titles (
	emp_no INT, 
	title VARCHAR, 
	from_date date, 
	to_date date,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

DROP TABLE employees;
CREATE TABLE employees(
	emp_no INT, 
	birth_date date, 
	first_name VARCHAR, 
	last_name VARCHAR, 
	gender VARCHAR,
	hire_date date, 
	PRIMARY KEY (emp_no)
); 

----

--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

Select emp_no, last_name, first_name, gender
FROM employees; 

--List employees who were hired in 1986
Select emp_no, last_name, first_name 
FROM employees 
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'; 

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name, 
--and start and end employment dates.

Select dept_manager.dept_no, dept_manager.emp_no, dept_manager.from_date, 
dept_manager.to_date, employees.first_name, employees.last_name, dept.dept_name
FROM employees JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
				JOIN dept ON dept_manager.dept_no = dept.dept_no; 
				
--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

Select employees.emp_no, employees.last_name, employees.first_name, dept.dept_name
FROM employees JOIN dept_employees ON employees.emp_no = dept_employees.emp_no
				JOIN dept ON dept_employees.dept_no = dept.dept_no; 


--List all employees whose first name is "Hercules" and last names begin with "B."

Select employees.first_name, employees.last_name, employees.emp_no 
FROM employees 
WHERE first_name = 'Hercules' and last_name LIKE 'B%'; 

--List all employees in the Sales department, including their employee number
--, last name, first name, and department name.

Select employees.emp_no, employees.last_name, employees.first_name, dept.dept_name
FROM employees JOIN dept_employees ON employees.emp_no = dept_employees.emp_no
				JOIN dept ON dept_employees.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales'; 

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
Select employees.emp_no, employees.last_name, employees.first_name, dept.dept_name
FROM employees JOIN dept_employees ON employees.emp_no = dept_employees.emp_no
				JOIN dept ON dept_employees.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales' 
OR dept.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
Select last_name, count(*)
FROM employees
GROUP By last_name 
ORDER BY count desc; 



