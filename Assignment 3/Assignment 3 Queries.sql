-- 1. Simple Subquery with WHERE: Find employees whose salary is greater than Amit's salary.
SELECT name, salary 
FROM employee
WHERE salary > (
    SELECT salary 
    FROM employee 
    WHERE name = 'Amit'
);

-- 2. Subquery with MAX(): Find the employee who has the highest salary.
SELECT name, salary
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
);

-- 3. Subquery with AVG(): Find employees whose salary is greater than the average salary.
SELECT name, salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);

-- 4. Subquery with IN: Find employees working in departments whose names start with 'S' or 'I' (IT, Sales).
SELECT name, salary
FROM employee
WHERE dept_id IN (
    SELECT dept_id
    FROM department
    WHERE dept_name IN ('IT', 'Sales')
);

-- 5. Subquery with NOT IN: Find employees who do not work in IT.
SELECT name, salary
FROM employee
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM department
    WHERE dept_name = 'IT'
);

-- 6. Subquery with EXISTS: Return employees whose department exists in the department table.
SELECT name
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM department d
    WHERE d.dept_id = e.dept_id
);

-- 7. Correlated Subquery: Find employees whose salary is greater than the average salary of their own department.
SELECT e.name, e.salary, e.dept_id
FROM employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.dept_id = e.dept_id
);

-- 8. Subquery in FROM: Select employees earning more than 40000 using a derived temporary table.
SELECT *
FROM (
    SELECT name, salary
    FROM employee
    WHERE salary > 40000
) AS temp;

-- 9. Subquery in SELECT: Display each employee's name, salary, and the overall company average salary.
SELECT
    name,
    salary,
    (SELECT AVG(salary) FROM employee) AS average_salary
FROM employee;

-- 10a. Subquery vs JOIN (Subquery version): Find employees in the IT department.
SELECT e.name
FROM employee e
WHERE e.dept_id IN (
    SELECT d.dept_id
    FROM department d
    WHERE d.dept_name = 'IT'
);

-- 10b. Subquery vs JOIN (JOIN version): Find employees in the IT department.
SELECT e.name
FROM employee e
JOIN department d
    ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';