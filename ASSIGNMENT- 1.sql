use hr;
select * from countries;
/* 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "LastName" */
SELECT 
    first_name AS First_Name, last_name AS Last_Name
FROM
    employees;

/* 2. Write a query to get unique department ID from employee table */
SELECT DISTINCT
    department_id
FROM
    employees;
 
 /* 3. Write a query to get all employee details from the employee table order by first name, descending */
SELECT 
    *
FROM
    employees
ORDER BY first_name DESC; 

/* 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary) */
SELECT 
    first_name, last_name, salary, salary * (15 / 100) AS PF
FROM
    employees;
    
/* 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary */
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
ORDER BY salary;

/* 6. Write a query to get the total salaries payable to employees */
SELECT 
    SUM(salary)
FROM
    employees;
    
/* 7. Write a query to get the maximum and minimum salary from employees table */
SELECT 
    MAX(salary), MIN(salary)
FROM
    employees;
    
/* 8. Write a query to get the average salary and number of employees in the employees table */    
SELECT 
    AVG(salary), COUNT(employee_id)
FROM
    employees;
    
/* 9. Write a query to get the number of employees working with the company */
SELECT 
     COUNT(employee_id)
FROM
    employees;
use hr;
/* 10. Write a query to get the number of jobs available in the employees table */
SELECT DISTINCT(job_id)
FROM
    employees;
    
/* 11. Write a query get all first name from employees table in upper case */
SELECT 
    UPPER(first_name)
FROM
    employees;
    
/* 12. Write a query to get the first 3 characters of first name from employees table */    
SELECT 
    first_name, LEFT(first_name, 3)
FROM
    employees;
    
/* 13. Write a query to get first name from employees table after removing white spaces from both side */
SELECT 
    first_name, TRIM(first_name)
FROM
    employees;

/* 14. Write a query to get the length of the employee names (first_name, last_name) from employees table */
SELECT 
    first_name, LENGTH(first_name), last_name, LENGTH(last_name)
FROM
    employees;
/* 15. Write a query to check if the first_name fields of the employees table contains numbers */  
SELECT 
    first_name
FROM
    employees
WHERE
    first_name REGEXP '[0-9]';

/* 16. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 */
SELECT 
    CONCAT(first_name, ', ', last_name) AS name, salary
FROM
    employees
WHERE
    salary NOT BETWEEN 10000 AND 15000;

/* 17. Write a query to display the name (first_name, last_name) and department ID of
 all employees in departments 30 or 100 in ascending order */
SELECT 
    first_name, last_name, department_id
FROM
    employees
WHERE
    department_id in (30,100)
ORDER BY department_id;

/* 18. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is
not in the range $10,000 through $15,000 and are in department 30 or 100 */
SELECT 
    CONCAT(first_name, ', ', last_name) AS name, salary
FROM
    employees
WHERE
    salary NOT BETWEEN 10000 AND 15000
        AND department_id  IN (30 , 100)
ORDER BY department_id;

/* 19. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987 */
SELECT 
    first_name, last_name, hire_date
FROM
    employees
WHERE
    YEAR(hire_date) = 1987;
    
/* 20. Write a query to display the first_name of all employees who have both "b" and "c" in their first name */
SELECT 
    first_name
FROM
    employees
WHERE
    (first_name LIKE ('%b%' AND '%c%'));    

/*21. Write a query to display the last name, job, and salary for all employees whose job is that of a
Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000? */
SELECT 
    a.last_name, b.job_title, a.salary
FROM
    employees AS a
        INNER JOIN
    jobs AS b ON a.job_id = b.job_id
WHERE
   (b.job_title in ('programmer','shipping clerk')
        AND (a.salary not in (4500,10000,15000)));
        
/* 22. Write a query to display the last name of employees whose names have exactly 6 characters */        
SELECT 
    last_name
FROM
    employees
WHERE
    LENGTH(last_name) = 6; 
    
/* 23. Write a query to display the last name of employees having 'e' as the third character */    
SELECT 
    last_name
FROM
    employees
WHERE
    substr(last_name,3,1) = 'e';
        
/* 24. Write a query to get the job_id and related employee's id
Partial output of the query :
job_id Employees ID
AC_ACCOUNT206
AC_MGR 205
AD_ASST 200
AD_PRES 100
AD_VP 101 ,102
FI_ACCOUNT 110 ,113 ,111 ,109 ,112 */
SELECT 
    job_id, GROUP_CONCAT(employee_id)
FROM
    employees
GROUP BY job_id;

/* 25. Write a query to update the portion of the phone_number in the employees table, within the phone
number the substring '124' will be replaced by '999' */
SELECT 
    first_name,
    last_name,
    REPLACE(phone_number, '124', '999') AS 'phone__number'
FROM
    employees;
    
/* 26. Write a query to get the details of the employees where the length of the first name greater than or equal to 8 */
SELECT 
    first_name
FROM
    employees
WHERE
    LENGTH(first_name) >= 8;

/* 27. Write a query to append '@example.com' to email field */
SELECT 
     CONCAT(email, '@example.com')
FROM
    employees;

/* 28. Write a query to extract the last 4 character of phone numbers */
SELECT 
    RIGHT(phone_number, 4)
FROM
    employees;

/* 29. Write a query to get the last word of the street address */
SELECT 
    street_address, SUBSTRING_INDEX(street_address,' ',- 1) AS last_word
FROM
    locations;

/* 30. Write a query to get the locations that have minimum street length */
SELECT 
    *
FROM
    locations
WHERE
    LENGTH(street_address) = (SELECT 
            MIN(LENGTH(street_address))
        FROM
            locations);

/* 31. Write a query to display the first word from those job titles which contains more than one words */
SELECT 
    job_title,
    SUBSTR(job_title,
        1,
        INSTR(job_title,' ')- 1)
FROM
    jobs;

/* 32. Write a query to display the length of first name for employees where last name contain character 'c'
after 2nd position */
SELECT 
    first_name, LENGTH(first_name)
FROM
    employees
WHERE
    SUBSTR(last_name, 3, 1) = 'c';

/* 33. Write a query that displays the first name and the length of the first name for all employees whose
name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the
employees' first names */
SELECT 
    first_name, LENGTH(first_name)
FROM
    employees
WHERE
    LEFT(first_name, 1) IN ('a' , 'j', 'm') order by first_name;
    
/* 34. Write a query to display the first name and salary for all employees. Format the salary to be 10
characters long, left-padded with the $ symbol. Label the column SALARY */
select * from employees;
SELECT 
    first_name, CONCAT(LEFT(salary, 5), '$') AS Salary
FROM
    employees;
    
/* 35. Write a query to display the first eight characters of the employees' first names and indicates the
amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in
descending order of salary */
SELECT 
    SUBSTRING(first_name, 1, 8),
    CONCAT( FLOOR(salary / 1000), '$')
FROM
    employees
ORDER BY salary DESC;


/* 36. Write a query to display the employees with their code, first name, last name and hire date who hired
either on seventh day of any month or seventh month in any year */        
SELECT 
    first_name, last_name, hire_date
FROM
    employees
WHERE
    (DAY(hire_date) = 7)
        OR (MONTH(hire_date) = 7);


