CREATE DATABASE Case_Study2
USE Case_Study2
--------------------------
CREATE TABLE LOCATION (
Location_ID INT PRIMARY KEY,
City VARCHAR(50)
)
INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),(123, 'Dallas'),(124, 'Chicago'),(167, 'Boston')

SELECT * FROM LOCATION
----------------------------
  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
)
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),(20, 'Sales', 124),(30, 'Research', 123),(40, 'Operations', 167)

SELECT * FROM DEPARTMENT
-----------------------
CREATE TABLE JOB (
Job_ID INT PRIMARY KEY,
Designation VARCHAR(50)
)
INSERT  INTO JOB VALUES(667, 'CLERK'),
(668,'STAFF'),(669,'ANALYST'),(670,'SALES_PERSON'),(671,'MANAGER'),(672, 'PRESIDENT')

SELECT * FROM JOB
-------------------------DROP TABLE EMPLOYEE
CREATE TABLE EMPLOYEE(
Employee_Id INT,
Last_Name VARCHAR(20),
First_Name VARCHAR(20),
Middle_Name CHAR(1),
Job_Id INT FOREIGN KEY
REFERENCES JOB(Job_Id),
Manager_Id INT,
Hire_Date DATETIME,
Salary INT,
Comm INT,
Department_Id  INT FOREIGN KEY
REFERENCES DEPARTMENT(Department_Id))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

SELECT * FROM EMPLOYEE 
-----------------------------------

SELECT * FROM LOCATION
SELECT * FROM DEPARTMENT
SELECT * FROM JOB
SELECT * FROM EMPLOYEE
---------------------QUESTIONS------------------------

---------------------SIMPLE QUERIES

--1. LIST ALL THE EMPLOYEE DETAILS
SELECT * FROM EMPLOYEE
--2. LIST ALL THE DEPARTMENT DETAILS
SELECT * FROM DEPARTMENT
--3. LIST ALL THE JOB DETAILS 
SELECT * FROM JOB
--4. LIST ALL THE LOCATION DETAILS 
SELECT * FROM LOCATION 

--5. List out the First Name, Last Name, Salary, Commission for all Employees. 
SELECT FIRST_NAME,LAST_NAME,SALARY,COMM FROM EMPLOYEE

--6. List out the Employee ID, Last Name, Department ID for all employees and alias 
--   Employee ID as "ID of the Employee", Last Name as "Name of the 
--   Employee", Department ID as "Dep_id". 
SELECT EMPLOYEE_ID AS 'id', LAST_NAME AS 'name_of_the_employee', DEPARTMENT_ID AS 'dep_id' FROM EMPLOYEE

--7. List out the annual salary of the employees with their names only

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name, SALARY FROM EMPLOYEE


---------------------WHERE Condition:



--1. List the details about "Smith"

SELECT * FROM EMPLOYEE AS E JOIN JOB AS J ON E.JOB_ID=J.Job_ID
JOIN DEPARTMENT AS D ON E.DEPARTMENT_ID=D.Department_Id
JOIN LOCATION AS L ON D.Location_Id=L.Location_ID
WHERE LAST_NAME='SMITH'
------OR---------
SELECT * FROM EMPLOYEE WHERE Last_Name='Smith'

--2. List out the employees who are working in department 20.

SELECT * FROM EMPLOYEE WHERE Department_Id=20
--------OR
SELECT * FROM EMPLOYEE AS E 
JOIN DEPARTMENT AS D ON
E.Department_Id=D.Department_Id
WHERE D.Department_Id=20

--3. List out the employees who are earning salary between 2000 and 3000

SELECT * FROM EMPLOYEE 
WHERE SALARY BETWEEN 2000 AND 3000

--4. List out the employees who are working in department 10 or 20.

SELECT * FROM EMPLOYEE WHERE Department_Id=10 OR Department_Id=20
--OR
SELECT * FROM EMPLOYEE WHERE Department_Id IN (10,20)

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE Department_Id <> 10 AND Department_Id <> 30
---OR
SELECT * FROM EMPLOYEE WHERE Department_Id NOT IN (10,30) 

--6. List out the employees whose name starts with 'L'. 

SELECT * FROM EMPLOYEE
WHERE First_Name LIKE 'L%'

--7. List out the employees whose name starts with 'L' and ends with 'E'.

SELECT * FROM EMPLOYEE
WHERE First_Name LIKE 'L%E'

--8. List out the employees whose name length is 4 and start with 'J'. 

SELECT * FROM EMPLOYEE
WHERE LEN(First_Name) =4 AND First_Name LIKE 'J%'

--9. List out the employees who are working in department 30 and draw the salaries more than 2500. 

SELECT * FROM EMPLOYEE 
WHERE Department_Id=30 AND Salary>2500

--10. List out the employees who are not receiving commission.

SELECT * FROM EMPLOYEE WHERE Comm IS NULL


---------------------ORDER BY Clause:


--1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 

SELECT Employee_Id, Last_Name FROM EMPLOYEE
ORDER BY Employee_Id ASC


--2. List out the Employee ID and Name in descending order based on salary. 

SELECT Employee_Id, CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS Name,Salary FROM EMPLOYEE 
ORDER BY Salary DESC

--3. List out the employee details according to their Last Name in ascending-order

SELECT *FROM EMPLOYEE ORDER BY Last_Name ASC

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

SELECT * FROM EMPLOYEE ORDER BY Last_Name ASC , Department_Id DESC


---------------------GROUP BY and HAVING Clause: 


--1. List out the department wise maximum salary, minimum salary and average salary of the employees.

SELECT Department_Id,MAX(Salary)AS max_salary,MIN(Salary)AS min_salary,AVG(Salary)AS avg_salary FROM EMPLOYEE 
GROUP BY Department_Id  

---OR 

SELECT Name AS dept_name,MAX(Salary)AS max_salary,MIN(Salary)AS min_salary,AVG(Salary)AS avg_salary FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Department_Id=D.Department_Id
GROUP BY Name

--2. List out the job wise maximum salary, minimum salary and average salary of the employees.

SELECT Job_Id,MAX(Salary)AS max_salary,MIN(Salary)AS min_salary,AVG(Salary)AS avg_salary FROM EMPLOYEE 
GROUP BY Job_Id 

--3. List out the number of employees who joined each month in ascending order. 

SELECT COUNT(Employee_Id) AS emp_join_per_month,MONTH(Hire_Date) AS month_no FROM EMPLOYEE
GROUP BY MONTH(Hire_Date)
ORDER BY MONTH(Hire_Date) ASC

--4. List out the number of employees for each month and year in ascending order based on the year and month.

SELECT COUNT(Employee_Id) AS emp_join_per_month,MONTH(Hire_Date) AS month_no, YEAR(Hire_Date) AS year_no FROM EMPLOYEE
GROUP BY MONTH(Hire_Date), YEAR(Hire_Date)
ORDER BY MONTH(Hire_Date) ASC, YEAR(Hire_Date) ASC


--5. List out the Department ID having at least four employees. 

SELECT  Department_Id, COUNT(Employee_Id)AS no_of_emp FROM EMPLOYEE
GROUP BY Department_Id
HAVING COUNT(Employee_Id)>3

--6. How many employees joined in February month
SELECT COUNT(Employee_Id)AS no_of_emp,MONTH(Hire_Date)AS joining_month_no FROM EMPLOYEE
GROUP BY MONTH(Hire_Date)
HAVING MONTH(Hire_Date)=2

--7. How many employees joined in May or June month.   

SELECT COUNT(Employee_Id)AS no_of_emp,MONTH(Hire_Date)AS joining_month_no FROM EMPLOYEE
GROUP BY MONTH(Hire_Date)
HAVING MONTH(Hire_Date) IN (2,6)

--8. How many employees joined in 1985?
 
 SELECT COUNT(Employee_Id)AS no_of_emp, YEAR(Hire_Date) AS joining_year FROM EMPLOYEE
 GROUP BY YEAR(Hire_Date)
 HAVING YEAR(Hire_Date)=1985

--9. How many employees joined each month in 1985? 

SELECT COUNT(Employee_Id)AS no_of_emp, MONTH(Hire_Date) AS joining_month_no, YEAR(Hire_Date) AS joining_year FROM EMPLOYEE
GROUP BY YEAR(Hire_Date),MONTH(Hire_Date)
HAVING YEAR(Hire_Date)=1985


--10. How many employees were joined in April 1985? 

SELECT COUNT(Employee_Id)AS no_of_emp, MONTH(Hire_Date) AS joining_month_no, YEAR(Hire_Date) AS joining_year FROM EMPLOYEE
GROUP BY YEAR(Hire_Date),MONTH(Hire_Date)
HAVING YEAR(Hire_Date)=1985 AND MONTH(Hire_Date)=4

--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985? 

SELECT COUNT(Employee_Id)AS no_of_emp, MONTH(Hire_Date) AS joining_month_no, YEAR(Hire_Date) AS joining_year FROM EMPLOYEE
GROUP BY YEAR(Hire_Date),MONTH(Hire_Date)
HAVING YEAR(Hire_Date)=1985 AND MONTH(Hire_Date)=4 AND COUNT(Employee_Id)>2


---------------------Joins: 


--1. List out employees with their department names. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Name AS dep_name  FROM EMPLOYEE AS E JOIN DEPARTMENT AS D
ON E.Department_Id=D.Department_Id

--2. Display employees with their designations. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Designation FROM EMPLOYEE AS E
JOIN JOB AS J ON E.Job_Id=J.Job_ID

--3. Display the employees with their department names and city. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Name AS dep_name,City FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
JOIN LOCATION AS L ON D.Location_Id=L.Location_ID

--4. How many employees are working in different departments? Display with department names. 

SELECT COUNT(Employee_Id)AS no_of_emp,Name AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
GROUP BY Name

--5. How many employees are working in the sales department? 

SELECT COUNT(Employee_Id)AS no_of_emp,Name AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
GROUP BY Name
HAVING Name='Sales'

--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order. 

SELECT COUNT(Employee_Id)AS no_of_emp,Name AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
GROUP BY Name
HAVING COUNT(Employee_Id)>3
ORDER BY Name 

--7. How many employees are working in 'Dallas'? 

SELECT COUNT(Employee_Id)AS no_of_emp,City FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
JOIN LOCATION AS L ON L.Location_ID=D.Location_Id
GROUP BY City
HAVING City='Dallas'

--8. Display all employees in sales or operation departments. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Name AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON E.Department_Id=D.Department_Id
WHERE Name IN ('Sales','Operations')



---------------------CONDITIONAL STATEMENT : 


--1. Display the employee details with salary grades. Use conditional statement to create a grade column. 

SELECT *, 
CASE
WHEN Salary>2500 THEN 'A'
WHEN Salary BETWEEN 2000 AND 2500 THEN 'B'
WHEN Salary BETWEEN 1500 AND 1999 THEN 'C'
WHEN Salary BETWEEN 1000 AND 1499 THEN 'D'
ELSE 'E' 
END AS Grade FROM EMPLOYEE

--2. List out the number of employees grade wise. Use conditional statement to  create a grade column. 

SELECT Grade,COUNT(Employee_Id) AS no_of_emp FROM 
(
SELECT *,
CASE 
WHEN Salary>2500 THEN 'A'
WHEN Salary BETWEEN 2000 AND 2500 THEN 'B'
WHEN Salary BETWEEN 1500 AND 1999 THEN 'C'
WHEN Salary BETWEEN 1000 AND 1499 THEN 'D'
ELSE 'E' 
END AS Grade
FROM EMPLOYEE
) 
AS GradeTable
GROUP BY Grade
ORDER BY Grade


--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT COUNT(Employee_Id)AS no_of_emp,Grade FROM 
( SELECT *,
CASE 
WHEN Salary BETWEEN 2501 AND 5000 THEN 'A'
WHEN Salary BETWEEN 2000 AND 2500 THEN 'B'
WHEN Salary BETWEEN 1500 AND 1999 THEN 'C'
WHEN Salary BETWEEN 1000 AND 1499 THEN 'D'
ELSE 'E' 
END AS Grade
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000) 
AS GradeTable
GROUP BY Grade

---------------------Subqueries: 


--1. Display the employees list who got the maximum salary. 

SELECT * FROM EMPLOYEE
WHERE Salary=(SELECT MAX(Salary)FROM EMPLOYEE)

---------0R USING DENSE RANK

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Salary,  
DENSE_RANK() OVER (ORDER BY Salary DESC)AS salary_rank FROM EMPLOYEE


--2. Display the employees who are working in the sales department. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,NAME AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON D.Department_Id=E.Department_Id
WHERE Name='Sales'

--3. Display the employees who are working as 'Clerk'. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Designation FROM EMPLOYEE AS E
JOIN JOB AS J ON J.Job_ID=E.Job_Id
WHERE Designation='Clerk'

--4. Display the list of employees who are living in 'Boston'. 

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name, City FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON D.Department_Id=E.Department_Id
JOIN LOCATION AS L ON L.Location_ID=D.Location_Id
WHERE City='Boston'

--5. Find out the number of employees working in the sales department. 

SELECT COUNT(Employee_Id)AS no_of_emp,NAME AS dep_name FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON D.Department_Id=E.Department_Id
GROUP BY NAME
HAVING NAME='Sales'

--6. Update the salaries of employees who are working as clerks on the basis of 10%. 

SELECT Employee_Id,Salary,Designation,(Salary*1.10)AS updated_salary FROM EMPLOYEE AS E
JOIN JOB AS J ON E.Job_Id=J.Job_ID
WHERE Designation='Clerk'

--7. Display the second highest salary drawing employee details. 

SELECT *,DENSE_RANK() OVER (ORDER BY Salary DESC)AS salary_rank FROM EMPLOYEE

-----OR

SELECT MAX(Salary) AS second_highest_salary
FROM EMPLOYEE
WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE)

--8. List out the employees who earn more than every employee in department 30. 

------FIRST METHOD-----------

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Salary,Department_Id FROM EMPLOYEE
WHERE Salary>(SELECT MAX(Salary) FROM EMPLOYEE WHERE Department_Id=30) AND Department_Id != 30

------SECOND METHOD-----------

SELECT * FROM 
(
SELECT  CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Salary,Department_Id FROM EMPLOYEE 
)AS all_dept_table
JOIN 
(
SELECT  CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Salary,Department_Id FROM EMPLOYEE 
WHERE Department_Id=30
)AS dep_30_table 
ON all_dept_table.Salary=dep_30_table.Salary
WHERE all_dept_table.Salary>dep_30_table.Salary

--9. Find out which department has no employees.

SELECT Name AS dep_name,COUNT(Employee_Id)AS no_of_emp FROM DEPARTMENT AS D
LEFT JOIN EMPLOYEE AS E ON D.Department_Id=E.Department_Id
GROUP BY Name
HAVING COUNT(Employee_Id) =0


--10. Find out the employees who earn greater than the average salary for their department.




-----EMPLOYEE SALARY > THEIR AVG DEPARTMENT ID's SALARY

SELECT CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME)AS employee_name,Salary FROM(
SELECT * FROM EMPLOYEE
) empl_details
JOIN (
SELECT Department_Id,AVG(Salary) dept_avg_salary FROM EMPLOYEE
GROUP BY Department_Id
) avg_salaries_dept_wise
ON empl_details.Department_Id=avg_salaries_dept_wise.Department_Id
WHERE empl_details.Salary>avg_salaries_dept_wise.dept_avg_salary



---------------------------------------------------------
-----EMPLOYEE SALARY > THEIR AVG DEPARTMENT NAME's SALARY
---------------------------------------------------------



SELECT Employee_Id,employee_name,Department_Id,genral_table.dept_name,Salary,avg_salary FROM (
SELECT Employee_Id,CONCAT(FIRST_NAME,' ',MIDDLE_NAME,' ',LAST_NAME) employee_name,E.Department_Id,Name dept_name,Salary
FROM EMPLOYEE E JOIN DEPARTMENT D ON E.Department_Id=D.Department_Id 
)
genral_table
JOIN (
SELECT Name dept_name,AVG(Salary) avg_salary FROM EMPLOYEE E JOIN DEPARTMENT D ON E.Department_Id=D.Department_Id
GROUP BY Name
)
dept_wise_avg_salary ON genral_table.dept_name=dept_wise_avg_salary.dept_name
WHERE genral_table.Salary>dept_wise_avg_salary.avg_salary
