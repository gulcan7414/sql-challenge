DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Create a Customer table
create table employees(
         emp_no int not null,
	     emp_title_id varchar not null,
	     birth_date date not null,
	     first_name varchar not null,
	     last_name varchar not null,
	     sex varchar not null,
	     hire_date date not null,
	     primary key(emp_no),
	     FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

select *from employees;

-- Create a Customer table
create table departments(
         dept_no varchar not null,
         dept_name varchar not null,
	     primary key(dept_no)
);

select *from departments;

-- Create a Customer table
create table dept_emp(
         emp_no int not null,
         dept_no varchar not null,
	     foreign key(emp_no) references employees(emp_no),
	     foreign key(dept_no) references departments(dept_no),
	     PRIMARY KEY (emp_no, dept_no)
);

select *from dept_emp;

-- Create a Customer table
create table dept_manager(
         dept_no varchar not null,
         emp_no int not null;,
	     PRIMARY KEY (emp_no, dept_no),
	     foreign key(dept_no) references departments(dept_no),
	     foreign key(emp_no) references employees(emp_no)
);

select *from dept_manager;


-- Create a Customer table
create table salaries(
         emp_no int not null,
         salary int not null,
	     primary key(emp_no),
	     foreign key(emp_no) references employees(emp_no)
);

select *from salaries;

-- Create a Customer table
create table titles(
         title_id varchar not null,
         title varchar not null,
	     primary key (title_id)     
);

select *from titles;


--1.List the employee number, last name, first name, sex, and salary of each employee.

select employees.emp_no, employees.first_name, employees.last_name, employees.sex,
salaries.salary
from employees
join salaries 
on employees.emp_no= salaries.emp_no;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.

select employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date < '1987-01-01'
      and hire_date>='1986-01-01';
	  
--3.List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

select departments.dept_no, departments.dept_name, employees.emp_no, 
employees.first_name, employees.last_name
from employees
inner join dept_emp
       on employees.emp_no=dept_emp.emp_no
inner join departments
      on departments.dept_no=dept_emp.dept_no
order by emp_no;

--4.List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name.

select  departments.dept_name, employees.emp_no, employees.first_name, employees.last_name
from employees
inner join dept_emp
       on employees.emp_no=dept_emp.emp_no
inner join departments
      on departments.dept_no=dept_emp.dept_no
order by emp_no;

--5.List the first name, last name, and sex of each employee whose 
--first name is Hercules and whose last name begins with the letter B.
    
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

--6.List each employee in the Sales department, including their employee number,
--last name, and first name

select  employees.emp_no, employees.first_name, employees.last_name
from employees
inner join dept_emp
       on employees.emp_no=dept_emp.emp_no
inner join departments
      on departments.dept_no=dept_emp.dept_no
where dept_name= 'Sales';

--7.List each employee in the Sales and Development departments,
--including their employee number,last name, first name, and department name.

select departments.dept_name, employees.emp_no, employees.first_name, employees.last_name
from employees
inner join dept_emp
       on employees.emp_no=dept_emp.emp_no
inner join departments
      on departments.dept_no=dept_emp.dept_no
where dept_name= 'Sales' or dept_name= 'Development';

--8.List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).

select last_name, count(last_name) as "Total Last Name" 
from employees
where last_name is not null
group by last_name
order by last_name desc;

