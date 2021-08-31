USE HR;
/*1. Write a query to find the addresses (location_id, street_address, city, 
state_province, country_name) of all the departments*/
SELECT 
    locations.location_id,
    street_address,
    city,
    state_province,
    country_name,
    department_name
FROM
    locations
        INNER JOIN
    departments ON locations.location_id = departments.location_id
        INNER JOIN
    countries ON countries.country_id = locations.country_id
GROUP BY department_name;

/*2. Write a query to find the name (first_name, last name), department ID and 
name of all the employees*/
select concat(first_name,' ',last_name) as name, department_id from employees;

/*3. Write a query to find the name (first_name, last_name), job, department ID 
and name of the employees who works in London */
/*select *from locations;
select * from departments;
select * from countries;
select * from jobs;
select * from employees;
select * from job_history;*/
SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    job_title,
    departments.department_id,
    city
FROM
    employees
        INNER JOIN
    departments ON departments.department_id = employees.department_id
inner join locations
on departments.location_id=locations.location_id
inner join jobs
 on employees.job_id = jobs.job_id
where city ='london';

/*4. Write a query to find the employee id, name (last_name) along with their 
manager_id and name (last_name)*/
SELECT 
    employee_id, last_name, manager_id
FROM
    employees;
    
    
SELECT 
    derived_table.employee_id,
    derived_table.last_name,
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS manager_name,
    derived_table.manager_id
FROM
    employees
        INNER JOIN
    (SELECT 
        employee_id, last_name, manager_id
    FROM
        employees) derived_table ON derived_table.manager_id = employees.employee_id;


/*5. Write a query to find the name (first_name, last_name) and hire date of the 
employees who was hired after 'Jones'*/
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= (SELECT 
            hire_date
        FROM
            employees
        WHERE
            last_name = 'jones')
ORDER BY hire_date;

/*6. Write a query to get the department name and number of employees in the 
department*/
SELECT 
    department_name,
    COUNT(department_name) AS number_of_employees
FROM
    employees
        INNER JOIN
    departments ON departments.department_id = employees.department_id
GROUP BY department_name;

/*7. Write a query to display department name, name (first_name, last_name), 
hire date, salary of the manager for all managers whose experience is more 
than 15 years*/
select employees.employee_id,concat(employees.first_name,' ',employees.last_name)as name,employees.hire_date,employees.salary,employees.manager_id,employees.department_id,department_name from employees
inner join (select * from employees
group by manager_id)m
on m.manager_id=employees.employee_id
inner join departments
on departments.department_id=employees.department_id
where year(employees.hire_date)<(2021-15);

/*8. Write a query to find the name (first_name, last_name) and the salary of the 
employees who have a higher salary than the employee whose 
last_name='Bull'*/
select employee_id,concat(first_name,' ',last_name),salary
from employees
where salary > (select salary 
from employees
where last_name='bull');

/*9. Write a query to find the name (first_name, last_name) of all employees 
who works in the IT department*/
SELECT 
    CONCAT(first_name, ' ', last_name) AS name, department_name
FROM
    employees
        INNER JOIN
    departments ON departments.department_id = employees.department_id
WHERE
    department_name = 'it';

/*10. Write a query to find the name (first_name, last_name) of the employees 
who have a manager and worked in a USA based department*/
SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    employees
        INNER JOIN
    (SELECT 
        employees.employee_id,
            CONCAT(employees.first_name, ' ', employees.last_name) AS name,
            employees.hire_date,
            employees.salary,
            employees.manager_id,
            employees.department_id,
            department_name,
            departments.location_id,
            country_id
    FROM
        employees
    INNER JOIN (SELECT 
        *
    FROM
        employees
    GROUP BY manager_id) m ON m.manager_id = employees.employee_id
    INNER JOIN departments ON departments.department_id = employees.department_id
    INNER JOIN locations ON departments.location_id = locations.location_id
    WHERE
        country_id = 'us') n ON n.employee_id = employees.manager_id;
        

/*11. Write a query to find the name (first_name, last_name), and salary of the 
employees whose salary is greater than the average salary*/
select * from employees
where salary > (select avg(salary) from employees);


/*12. Write a query to find the name (first_name, last_name), and salary of the 
employees whose salary is equal to the minimum salary for their job grade */
select min(salary),job_id from employees
group by job_id;

/*13. Write a query to find the name (first_name, last_name), and salary of the 
employees who earns more than the average salary and works in any of the IT 
departments  */
select * from employees
inner join departments
on departments.department_id=employees.department_id
where salary > (select avg(salary) from employees) and department_name='it';

/*14. Write a query to find the name (first_name, last_name), and salary of the 
employees who earn the same salary as the minimum salary for all 
departments.*/
select min(salary),department_name from employees
inner join departments
on departments.department_id=employees.department_id
group by department_name;

/*15. Write a query to find the name (first_name, last_name) and salary of the 
employees who earn a salary that is higher than the salary of all the Shipping 
Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to 
highest */
select max(salary) from employees
where job_id='sh_clerk';
 select concat(first_name,' ',last_name)as name,salary  from employees
 where salary > (select max(salary) from employees
where job_id='sh_clerk');