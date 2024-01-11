-- introduction to aggregate
-- Aggregate functions are count(),sum,min,max etc
-- count can be used with distinct. count() has no white space
SELECT 
    COUNT(emp_no)
FROM
    employees;
    
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
