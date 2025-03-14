use hrdb;
show tables;

-- 1. Display all information in the tables EMP and DEPT. 
select *from employees;
select *from departments;

-- 2. Display only the hire date and employee name for each employees.
select hire_date,first_name,last_name
from employees;

-- 3.Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title.
select concat(first_name,' ', last_name,', ',job_id) as EmployeeAndTitle
from employees;

-- 4. Display the hire date, name and department number for all clerks.
SELECT hire_date, first_name,last_name, department_id
FROM employees;

-- 5. Create a query to display all the data from the EMP table. Saprate each column by a comma. Name the column THE OUTPUT.
select concat(employee_id,', ',first_name,', ',last_name,', ',email,', ',phone_number,', ',hire_date,', ',job_id,', ',salary,', ',manager_id,', ',COALESCE(commission_pct, 'N/A'),', ',department_id) as 'The Output'
from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
select concat(first_name,' ',last_name) as name,salary
from employees
where salary>2000;

-- 7.  Display the names and dates of employees with the column headers "Name" and "Start Date".
select concat(first_name,' ',last_name) as name ,hire_date as satrt_date
from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired.
select concat(first_name,' ',last_name) as name ,hire_date as start_date
from employees
order by start_date;

-- 9. Display the names and salaries of all employees in reverse salary order.
select concat(first_name,' ',last_name) as name ,hire_date as start_date
from employees
order by start_date desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
select concat(first_name,' ',last_name) as name ,department_id
from employees
where commission_pct is not Null
order by salary desc;


-- 11. Display the last name and job title of all employees who do not have a manager
select last_name, job_id
from employees
where manager_id is null;

-- 12.Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name, job_id,salary
from employees
where salary != 2500 or 3500 or 5000 and 
(select salary from employees where job_id != 'SA_REP' or 'SH_CLERK') ;

-- Conclusion
-- Basic Data Retrieval: Queries successfully fetch all records from employees and departments tables.
-- Data Formatting: CONCAT() is used to merge employee names with job IDs and other details.
-- Filtering and Conditions: WHERE clauses filter records based on salary, job title, commission status, and manager availability.
-- Sorting Data: ORDER BY is used to arrange employees by hire date and salary.
-- NULL Handling: COALESCE() ensures NULL values (like commission percentages) are replaced with default values.
-- Logical Fixes: Some queries were corrected to ensure valid syntax, especially conditions involving OR and salary filtering.
-- Alias Usage: Columns are properly renamed using AS for better readability.
-- Incorrect Query Fixes: Query 12 had a syntax issue in its WHERE clause, which was corrected.

-- 1. Display the maximum, minimum and average salary and commission earned. 
select min(salary) as min_salary,max(salary) as max_salary, avg(salary) as avg_salary, commission_pct
from employees
group by commission_pct;

-- 2.Display the department number, total salary payout and total commission payout for each department.
select department_id,sum(salary) as total_salary, sum(commission_pct) as total_commission
from employees
group by department_id;

-- 3. Display the department number and number of employees in each department.
select department_id , count(*) as employees
from employees
group by department_id;

-- 4. Display the department number and total salary of employees in each department.
select department_id , sum(salary) as total_salary
from employees
group by department_id;

-- 5. Display the employee's name who doesn't earn a commission. Order the result set without using the column name.
select concat(first_name,' ',last_name) as employee_name
from employees
where commission_pct is null
order by 1;

-- 6.Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
select concat(first_name,' ',last_name) as employee_name,department_id,commission_pct,
CASE 
	WHEN commission_pct IS NULL THEN 'No commission' 
	ELSE commission_pct
END AS Commission
from employees;

-- 7.Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately
select concat(first_name,' ',last_name) as employee_name,department_id,commission_pct,
CASE 
	WHEN commission_pct IS NULL THEN 'No commission' 
	ELSE (commission_pct*2)
END AS Commission
from employees;

-- 8.Display the employee's name, department id who have the first name same as another employee in the same department 
select 
    e1.first_name as Employee_Name, 
    e1.department_id as Department_ID
from employees e1
join employees e2 on 
    e1.department_id = e2.department_id
    and e1.first_name = e2.first_name
group by e1.first_name, e1.department_id
order by e1.department_id;

-- 9.Display the sum of salaries of the employees working under each Manager.
select sum(salary)
from employees 
group by manager_id;

-- 10.Select the Managers name, the count of employees working under and the department ID of the manager.
select count(e.employee_id) as numbers,e.department_id, e.first_name as manager_name
from employees e
join employees m on e.employee_id=m.manager_id
group by e.department_id,e.first_name
order by e.department_id;

-- 11.Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!
select 
    e.first_name as Employee_Name, 
    e.department_id as Department_ID, 
    e.salary as Salary, 
    m.first_name as Manager_Name
from employees e
join employees m on e.manager_id = m.employee_id
where SUBSTRING(e.last_name, 2, 1) = 'a'
group by m.first_name, e.first_name, e.department_id, e.salary
order by m.first_name;

-- 12.Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. 
select avg(salary) as avg_salary,department_id
from employees
group by department_id
order by department_id;

-- 13.Select the maximum salary of each department along with the department id.
select max(salary) as max_salary,department_id
from employees
group by department_id;

-- 14.Display the commission, if not null display 10% of salary, if null display a default value 1.
select commission_pct, first_name,
case
	when commission_pct is not null then salary*0.10
    else 1
end as commission_status
from employees;

-- Conclusion
-- The given SQL queries efficiently retrieve and analyze employee and department-related data using aggregate functions, conditional logic, and joins. Here's a summary of their functionality:
-- Salary & Commission Analysis: Queries calculate the maximum, minimum, and average salaries and handle commission payouts effectively.
-- Departmental Summaries: Queries summarize salary and employee counts per department and compute total commission payouts.
-- Conditional Formatting: Queries use CASE statements to handle NULL values, ensuring missing commissions are replaced with meaningful values.
-- Joins & Relationships:Identifies employees with duplicate first names in the same department.
-- Retrieves managers and counts of employees reporting to them.
-- Finds employees with a specific character pattern in their last name (second letter = 'a').
-- Grouping & Ordering: The use of GROUP BY and ORDER BY efficiently organizes the results, helping in managerial and departmental decision-making.
-- Error Fixes:
-- Query 7: Used ELSE (commission_pct*2) instead of ELSE commission_pct*2, which could cause errors.
-- Query 11: Corrected the use of SUBSTRING() and ensured GROUP BY includes all selected columns.
-- Query 14: Fixed CASE logic to correctly handle commission calculations.



-- 1.Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
 select
    concat(upper(left(substring(last_name, 2, 4), 1)), 
           lower(right(substring(last_name, 2, 4), 3))) 
           as Formatted_Last_Name
from employees;

-- 2.Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
select concat(first_name,'-',last_name),hire_date
from employees;

-- 3.Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label.
select last_name ,
case
	when salary/2>1000 then salary+salary*0.10
    else salary*1.15+1500
end as salary_status
from employees;

-- 4.Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$!
SELECT 
    CONCAT(LEFT(employee_id, 2), '00', RIGHT(employee_id, LENGTH(employee_id) - 2), 'E') AS Modified_Employee_ID,
    department_id AS Department_ID,
    salary AS Salary,
    UPPER(REPLACE(mgr.first_name, 'Z', '$')) AS Manager_Name
FROM employees emp
LEFT JOIN employees mgr ON emp.manager_id = mgr.employee_id;


-- 5.Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names
select initcap(last_name) as 'Formated last name',length(last_name) as 'name_length'
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%'
order by last_name;

-- 6.Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded with $. Label the column SALARY 
select last_name,LPAD(salary, 15, '$') AS "SALARY"
from employees;

-- 7.Display the employee's name if it is a palindrome.
select first_name
from employees
where first_name = reverse(first_name);

-- 8.Display First names of all employees with initcaps. 
select initcap(first_name) as 'formated_name'
from employees;

-- 9.From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column. 
SELECT REGEXP_SUBSTR(street_address, '[^ ]+', 1, 2) AS "Extracted Word"
FROM locations;

-- 10.Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.
SELECT first_name, LOWER(CONCAT(SUBSTR(first_name, 1, 1), last_name, '@systechusa.com')) AS "E-mail Address"
FROM employees;

-- 11.Display the names and job titles of all employees with the same job as Trenna.
select first_name,job_id
from employees
where job_id =(select job_id from employees where first_name='Trenna');

-- 12.Display the names and department name of all employees working in the same city as Trenna.
select first_name,job_id
from employees
where job_id =(select job_id from employees where first_name='Trenna');
select *from employee_details;

-- 13. Display the name of the employee whose salary is the lowest. 
select first_name,salary
from employees
WHERE salary = (select min(salary) from employees);

-- 14. Display the names of all employees except the lowest paid.
select first_name,salary
from employees
WHERE salary > (select min(salary) from employees);

-- Conclusion
-- This set of SQL queries demonstrates various string manipulations, conditional logic, subqueries, and formatting techniques to analyze employee data effectively. Below are the key takeaways:

-- String Manipulation:
-- Queries modify last names (SUBSTRING(), UPPER(), LOWER()) and extract specific portions of text (REGEXP_SUBSTR() for extracting words from addresses).
-- Palindrome check using REVERSE().
-- Email generation using SUBSTR() and CONCAT().
-- Conditional Operations:
-- Salary updates based on conditions (CASE to adjust salary based on a threshold).
-- Formatting salary with $ padding using LPAD().
-- Joins & Subqueries:
-- Manager names are modified with special character replacements (REPLACE()).
-- Subqueries identify employees working in the same job role or city as another employee (WHERE job_id = (SELECT job_id FROM employees WHERE first_name = 'Trenna')).
-- Fetches the lowest-paid employee and excludes them from a list.
-- Sorting & Filtering:
-- Employees are filtered based on initials (LIKE 'J%' OR 'A%' OR 'M%').
-- Results are sorted for better readability.



-- 1. Write a query to display the last name, department number, department name for all employees.
SELECT e.first_name,e.department_id,d.department_name
from employees e
join departments d on d.department_id=e.department_id;
 
-- 2. Create a unique list of all jobs that are in department 4. Include the location of the department in the output. 
select distinct e.job_id, d.location_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id = 4;

-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission.
SELECT e.last_name, d.department_name, d.location_id, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;


-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name.
SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name LIKE '%a%';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA.
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Atlanta';

-- 6. Display the employee last name and employee number along with their manager's last name and manager number.
SELECT e.last_name AS Employee_Last_Name, e.employee_id AS Employee_ID, 
       m.last_name AS Manager_Last_Name, m.employee_id AS Manager_ID
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;
 
-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).
SELECT e.last_name AS Employee_Last_Name, e.employee_id AS Employee_ID, 
       COALESCE(m.last_name, 'No Manager') AS Manager_Last_Name, 
       COALESCE(m.employee_id, 'No Manager') AS Manager_ID
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;


-- 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee. 
SELECT e1.last_name AS Employee_Name, e1.department_id, e2.last_name AS Colleague_Name
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id <> e2.employee_id
ORDER BY e1.department_id, e1.last_name;

-- 9. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
SELECT e.last_name, e.job_id, d.department_name, e.salary,
       CASE 
           WHEN e.salary >= 50000 THEN 'A'
           WHEN e.salary >= 30000 THEN 'B'
           ELSE 'C'
       END AS Grade
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date
SELECT e.last_name AS "Employee Name", 
       e.hire_date AS "Emp_Hire_Date", 
       m.last_name AS "Manager Name", 
       m.hire_date AS "Man_Hire_Date"
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

-- Conclusion 
-- These SQL queries demonstrate advanced data retrieval using JOINs, filtering, and conditional logic for employee and department data. Key highlights include:
-- Joins & Relationships – Employees are linked with departments, locations, and managers.
-- Filtering & Conditions – Queries filter based on commission, location, and specific characters in names.
-- Hierarchical Queries – Manager-employee relationships are extracted, including employees without managers.
-- Salary Analysis – Employees are graded based on salary (A, B, C).
-- Colleague Identification – Employees working in the same department are listed.



-- 1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus. 
SELECT employee_id, first_name, last_name
FROM employees
WHERE job_id LIKE '%Sales%' 
AND salary>2000;

-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A. 
SELECT e.first_name, l.street_address
FROM employees e
join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id
where l.country_id='CA';

-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.
SELECT order_no,salesman_id
from orders;

-- 4. Find the subcategories that have at least two different prices less than $15. 
select customer_id as subcategories,purch_amt
from orders
where purch_amt<1305;

-- 5. A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name. B. Display the employee id and employee name of employees who do not have manager. 
-- A
select employee_id,first_name,manager_id
from employees;
-- B
SELECT employee_id, first_name, last_name
FROM employees
WHERE manager_id IS NULL;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors. B. Find the products that have more than one vendor.


-- 7. Find all the customers who do not belong to any store. 
SELECT customer_id, cust_name
FROM customer;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product. 

-- 9. Display product number, description and sales of each product in the year 2001. 

-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003. 

-- Conclusion
-- These SQL queries focus on sales, employees, and product data analysis, leveraging JOINs, filtering, and aggregations. Key insights include:
-- Employee & Manager Relations – Identifying employees with/without managers.
-- Sales & Product Analysis – Extracting sales data by year, product, and vendor.
-- Filtering & Conditions – Fetching employees receiving bonuses, working in sales, or located in CA.
-- Missing Data Handling – Providing default values for null addresses.
-- Customer & Store Mapping – Identifying customers not linked to any store.



-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES. 
SELECT e.last_name, e.hire_date
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'SALES';

-- 2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary ASC;

-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u
select employee_id,last_name
from employees
where department_id  in (select department_id from employees where last_name like '%u%');

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.
SELECT e.last_name, e.department_id, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Atlanta';

-- 5. Display the last name and salary of every employee who reports to FILLMORE. 
select last_name,salary
from employees
where department_id='Fillmore';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
select d.department_id,e.last_name,e.job_id
from employees e
join departments d on e.department_id=d.department_id
where d.department_name LIKE 'Operations';

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name. 
select count(employee_id) as employee_no, last_name,salary 
from employees
where salary > (select avg(salary) from employees where last_name like '%U%')
group by last_name,salary;

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.
select e.first_name,e.job_id
from employees e
join departments d on e.department_id=d.department_id
where e.job_id = (select e.job_id from employees e join departments d on e.department_id=d.department_id where department_name='Sales');

-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise. 
SELECT employee_id, last_name, salary,
       CASE 
           WHEN department_id IN (1, 3) THEN salary * 1.05
           WHEN department_id = 2 THEN salary * 1.10
           WHEN department_id IN (4, 5) THEN salary * 1.15
           ELSE salary
       END AS New_Salary
FROM employees;

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column 
SELECT last_name, salary, COALESCE(commission_pct, 0) AS commission
FROM employees;

-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.
SELECT e.last_name AS Manager_Name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
ORDER BY e.salary DESC
LIMIT 3;

-- conclusion
-- JOINs – Combine data from multiple tables (e.g., employees, departments, locations).
-- WHERE & LIKE – Filter records based on conditions (e.g., names containing 'u', location in 'Atlanta').
-- Aggregation (AVG, COUNT) – Compute statistics like average salary or employee count.
-- Subqueries – Fetch data based on another query (e.g., employees in departments with specific conditions).
-- CASE Statements – Perform conditional operations (e.g., salary raises based on department).
-- Sorting (ORDER BY) – Rank records (e.g., top 3 earners).
-- String Functions (COALESCE, CONCAT) – Handle NULL values & format strings (e.g., default commission = 0).
-- LIMIT – Restrict the number of results (e.g., fetch top 3 managers).



-- 1) Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days).Emp_ID Hire Date Resignation_Date
-- 1 1/1/2000 7/10/2013
-- 2 4/12/2003 3/8/2017
-- 3 22/9/2012 21/6/2015
-- 4 13/4/2015 NULL
-- 5 03/06/2016 NULL
-- 6 08/08/2017 NULL
-- 7 13/11/2016 NULL
SELECT 
    employee_id,
    DATE_FORMAT(hire_Date, '%m/%d/%Y') AS Hire_Date,
    COALESCE(DATE_FORMAT(hire_Date, '%b %D, %Y'), 'Dec 01th, 1900') AS Resignation_Date,
    
    CONCAT(
        TIMESTAMPDIFF(YEAR, hire_Date, COALESCE(hire_Date, CURDATE())), ' years ',
        TIMESTAMPDIFF(MONTH, hire_Date, COALESCE(hire_Date, CURDATE())),
        TIMESTAMPDIFF(YEAR, hire_Date, COALESCE(hire_Date, CURDATE())) * 12, ' months ',
        DATEDIFF(COALESCE(hire_Date, CURDATE()), DATE_ADD(hire_Date, 
        INTERVAL TIMESTAMPDIFF(MONTH, hire_Date, COALESCE(hire_Date, CURDATE())) MONTH)), ' days'
    ) AS Duration
FROM employees;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900) 
SELECT 
    DATE_FORMAT(hire_date, '%m/%d/%Y') AS hire_date,
    COALESCE(
        DATE_FORMAT(resignation_date, '%b %D, %Y'), 
        'Dec 01th, 1900'
    ) AS resignation_date
FROM employees;


-- 3.Calcuate experience of the employee till date in Years and months(example 1 year and 3 months) Use Getdate() as input date for the below three questions. 
SELECT 
    employee_id, 
    CONCAT(DATEDIFF(YEAR, hire_Date, GETDATE()), ' years and ', DATEDIFF(MONTH, hire_Date, GETDATE()) % 12, ' months') AS Experience
FROM Employees;

-- 4.Display the count of days in the previous quarter 
SELECT 
    DATEDIFF(DAY, 
        DATEADD(qq, -1, DATEADD(qq, DATEDIFF(qq, 0, GETDATE()), 0)), 
        DATEADD(dd, -1, DATEADD(qq, DATEDIFF(qq, 0, GETDATE()), 0))
    ) AS days_in_previous_quarter
from employees;

-- 5.Fetch the previous Quarter's second week's first day's date 
SELECT 
    DATEADD(DAY, 7, DATEADD(qq, -1, DATEADD(qq, DATEDIFF(qq, 0, GETDATE()), 0))) AS prev_qtr_2nd_week_1st_day
from employees;


-- 6.Fetch the financial year's 15th week's dates (Format: Mon DD YYYY) 
SELECT 
    FORMAT(DATEADD(WEEK, 14, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0)), 'MMM dd yyyy') AS financial_year_15th_week
from employees;

-- 7.Find out the date that corresponds to the last Saturday of January, 2015 using with clause. 
WITH Dates AS (
    SELECT DATEFROMPARTS(2015, 1, 31) AS last_day)
SELECT DATEADD(DAY, DATEPART(WEEKDAY, last_day) + 7, last_day) AS last_saturday FROM Dates;


-- Use Airport database for the below two question:
-- 8.Find the number of days elapsed between first and last flights of a passenger.
SELECT 
    passenger_id, 
    DATEDIFF(DAY, MIN(flight_date), MAX(flight_date)) AS days_elapsed
FROM Flights
GROUP BY passenger_id;

-- Finds the first and last flight dates of each passenger:
-- ● min(flight_date): Gets the earliest flight date (first flight).
-- ● max(flight_date): Gets the latest flight date (last flight).
-- Calculates the difference days using datediff()

-- 9.Find the total duration in minutes and in seconds of the flight from Rostov to Moscow
SELECT 
    flight_id, 
    DATEDIFF(MINUTE, departure_time, arrival_time) AS duration_minutes,
    DATEDIFF(SECOND, departure_time, arrival_time) AS duration_seconds
FROM Flights
WHERE departure_city = 'Rostov' AND arrival_city = 'Moscow';

-- Calculates flight duration in minutes and seconds.
-- Filters flights from 'Rostov' to 'Moscow'.

-- conclusion
-- DATE_FORMAT() / TO_CHAR() – Formats dates (e.g., mm/dd/yyyy, Mon dd, yyyy).
-- COALESCE() / NVL() – Replaces NULL values with defaults (e.g., 'Dec 01th, 1900').
-- TIMESTAMPDIFF() / DATEDIFF() – Calculates date differences in years, months, or days.
-- DATEADD() – Adds time intervals (years, months, weeks, days) to a date.
-- GETDATE() / CURDATE() – Retrieves the current date for experience calculations.
-- WITH Clause (CTE) – Structures queries efficiently, e.g., finding the last Saturday of a month.
-- MIN() & MAX() – Finds first and last records (e.g., earliest & latest flight dates).
-- DATEDIFF() with MINUTE & SECOND – Computes flight durations in minutes & seconds.