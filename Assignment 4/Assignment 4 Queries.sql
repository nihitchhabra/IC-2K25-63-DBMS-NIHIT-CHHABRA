-- 1. Write a query to list the number of jobs available in the employees table[span_4](start_span)[span_4](end_span).
SELECT COUNT(DISTINCT job_id) AS Number_Of_Jobs 
FROM employees;

-- 2. Write a query to get the total salaries payable to employees[span_5](start_span)[span_5](end_span).
SELECT SUM(salary) AS Total_Salaries 
FROM employees;

-- 3. Write a query to get the minimum salary from employees table[span_6](start_span)[span_6](end_span).
SELECT MIN(salary) AS Minimum_Salary 
FROM employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer[span_7](start_span)[span_7](end_span).
SELECT MAX(e.salary) AS Max_Programmer_Salary 
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'Programmer';

-- 5. Write a query to get the average salary and number of employees working the department 90[span_8](start_span)[span_8](end_span).
SELECT AVG(salary) AS Average_Salary, COUNT(*) AS Employee_Count 
FROM employees 
WHERE department_id = 90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees[span_9](start_span)[span_9](end_span).
SELECT MAX(salary) AS Highest_Salary, 
       MIN(salary) AS Lowest_Salary, 
       SUM(salary) AS Total_Salary, 
       AVG(salary) AS Average_Salary 
FROM employees;

-- 7. Write a query to get the number of employees with the same job[span_10](start_span)[span_10](end_span).
SELECT job_id, COUNT(*) AS Employee_Count 
FROM employees 
GROUP BY job_id;

-- 8. Write a query to get the difference between the highest and lowest salaries[span_11](start_span)[span_11](end_span).
SELECT MAX(salary) - MIN(salary) AS Salary_Difference 
FROM employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager[span_12](start_span)[span_12](end_span).
SELECT manager_id, MIN(salary) AS Lowest_Salary 
FROM employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;

-- 10. Write a query to get the department ID and the total salary payable in each department[span_13](start_span)[span_13](end_span).
SELECT department_id, SUM(salary) AS Total_Salary 
FROM employees 
GROUP BY department_id;

-- 11. Write a query to get the average salary for each job ID excluding programmer[span_14](start_span)[span_14](end_span).
SELECT job_id, AVG(salary) AS Average_Salary 
FROM employees 
WHERE job_id != 'IT_PROG' 
GROUP BY job_id;

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only[span_15](start_span)[span_15](end_span).
SELECT job_id, 
       SUM(salary) AS Total_Salary, 
       MAX(salary) AS Max_Salary, 
       MIN(salary) AS Min_Salary, 
       AVG(salary) AS Avg_Salary 
FROM employees 
WHERE department_id = 90 
GROUP BY job_id;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000[span_16](start_span)[span_16](end_span).
SELECT job_id, MAX(salary) AS Max_Salary 
FROM employees 
GROUP BY job_id 
HAVING MAX(salary) >= 4000;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees[span_17](start_span)[span_17](end_span).
SELECT department_id, AVG(salary) AS Average_Salary, COUNT(*) AS Employee_Count 
FROM employees 
WHERE department_id IS NOT NULL 
GROUP BY department_id 
HAVING COUNT(*) > 10;