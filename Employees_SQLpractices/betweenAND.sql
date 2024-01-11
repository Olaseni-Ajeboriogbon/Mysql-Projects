-- USING  BETWEEN AND OPERATOR
SELECT 
    *
FROM
    employees
WHERE
    emp_no BETWEEN '10004' AND '10012';
    
    SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no between "d003" and "d006";
    
-- USING IS NULL AND NOT NULL
SELECT 
    *
FROM
    employees
WHERE
    first_name is not null;
    
-- using Is Null
SELECT 
    *
FROM
    employees
WHERE
    first_name is null;
    
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no is not null;
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01' and gender ="F";