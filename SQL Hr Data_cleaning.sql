CREATE DATABASE HR_Project;
USE HR_Project;
SELECT * FROM HR;

DESCRIBE HR;

-- Changing the first column header--
ALTER TABLE hr 
CHANGE COLUMN ï»¿id Emp_ID VARCHAR(20)NULL;

-- change the date format for the birthdate and hiredate column 
SELECT birthdate,hire_date FROM hr;

set sql_safe_updates = 0;

UPDATE hr 
SET 
    birthdate = CASE
        WHEN
            birthdate LIKE '%/%'
        THEN
            DATE_FORMAT(STR_TO_DATE(birthdate, '%Y/%m/%d'),
                    '%Y-%m-%d')
        WHEN
            birthdate LIKE '%-%'
        THEN
            DATE_FORMAT(STR_TO_DATE(birthdate, '%Y-%m-%d'),
                    '%Y-%m-%d')
        ELSE NULL
    END;  

UPDATE hr 
SET 
    hire_date = CASE
        WHEN
            hire_date LIKE '%/%'
        THEN
            DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'),
                    '%Y-%m-%d')
        WHEN
            hire_date LIKE '%-%'
        THEN
            DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'),
                    '%Y-%m-%d')
        ELSE NULL
    END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr 
SET 
    termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE
    termdate IS NOT NULL AND termdate != '';

set sql_mode = '';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
ADD COLUMN Age INT;

update hr
set Age = timestampdiff(year,birthdate,curdate());
    
SELECT count(*) from hr;

-- QUESTIONS
-- 1. what is the gender breakdown of employees in the company?
SELECT 
    gender, COUNT(*) AS count
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- what is the race/ethnicity breakdown of employees in the company?
SELECT 
    race, COUNT(*) AS No_of_Races
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY COUNT(*) DESC;

-- 3. what is the age distribution of employees in the company?
SELECT 
    MIN(Age) AS youngest, MAX(Age) AS oldest
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00';
    
-- Age Distribution

SELECT 
    CASE
        WHEN Age >= 18 AND age <= 24 THEN '18-24'
        WHEN Age >= 25 AND age <= 34 THEN '25-34'
        WHEN Age >= 35 AND age <= 44 THEN '35-44'
        WHEN Age >= 45 AND age <= 54 THEN '45-54'
        WHEN Age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS Age_group,
    COUNT(*) AS count
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY Age_group
ORDER BY Age_group;

-- Age Distribution according to Gender

SELECT 
    CASE
        WHEN Age >= 18 AND age <= 24 THEN '18-24'
        WHEN Age >= 25 AND age <= 34 THEN '25-34'
        WHEN Age >= 35 AND age <= 44 THEN '35-44'
        WHEN Age >= 45 AND age <= 54 THEN '45-54'
        WHEN Age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS Age_group,
    Gender,
    COUNT(*) AS count
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY Age_group , Gender
ORDER BY Age_group , Gender;

-- 4. How many employees work at headquaters versus remote locations? 

SELECT 
    location, COUNT(*) AS count
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY location
ORDER BY COUNT(*);

-- 5. what is the average length of employment for employees who have been terminated?

SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365,
            0) AS avg_length_employment
FROM
    hr
WHERE
    termdate <= CURDATE()
        AND termdate <> '0000-00-00'
        AND Age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?

SELECT 
    gender, department, jobtitle, COUNT(*) AS count
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY gender , department
ORDER BY Department;
 
 -- 7. what is the distribution of job titles across the company?

 SELECT 
    jobtitle, COUNT(*) AS count
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. which department has the highest turnover rate?

SELECT 
    department,
    total_count,
    terminated_count,
    terminated_count / total_count AS termination_rate
FROM
    (SELECT 
        department,
            COUNT(*) AS total_count,
            SUM(CASE
                WHEN
                    termdate <> '0000-00-00'
                        AND termdate <= CURDATE()
                THEN
                    1
                ELSE 0
            END) AS terminated_count
    FROM
        hr
    WHERE
        age >= 18
    GROUP BY department) AS subquery
ORDER BY termination_rate DESC;

-- 9. what is the distribution of employees across locations by city and state?

SELECT 
    location, location_state, COUNT(*) AS count
FROM
    hr
WHERE
    Age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY COUNT(*) DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT 
    year,
    hires,
    terminations,
    hires - terminations AS net_change,
    ROUND((hires - terminations) / hires * 100, 2) AS net_change_percent
FROM
    (SELECT 
        YEAR(hire_date) AS year,
            COUNT(*) AS hires,
            SUM(CASE
                WHEN
                    termdate <> '0000-00-00'
                        AND termdate <= CURDATE()
                THEN
                    1
                ELSE 0
            END) AS terminations
    FROM
        hr
    WHERE
        age >= 18
    GROUP BY YEAR(hire_date)) AS subquery
ORDER BY year ASC;

-- 11. what is the Tenure distribution for each department?

SELECT 
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),
            0) AS avg_tenure
FROM
    hr
WHERE
    termdate <= CURDATE()
        AND termdate <> '0000-00-00'
        AND age >= 18
GROUP BY department
ORDER BY avg_tenure;


