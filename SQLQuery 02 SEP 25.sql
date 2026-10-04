
-- Create Departments table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

-- Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT NULL,
    Salary DECIMAL(10,2), --decimal datatype - 10 (total no. of values), 2(no. of values after decimal) -- if 10 - 8+2 .. eg: 17933322.76
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Insert into Departments
INSERT INTO Departments (DeptID, DeptName, Location) VALUES
(101, 'HR', 'Chennai'),
(102, 'IT', 'Bangalore'),
(104, 'Finance', 'Hyderabad');   -- Notice: 103 is missing intentionally

-- Insert into Employees
INSERT INTO Employees (EmpID, EmpName, DeptID, Salary) VALUES
(1, 'Alice', 101, 50000.00),   -- Matches HR
(2, 'Bob', 102, 60000.00),     -- Matches IT
(3, 'Charlie', NULL, 55000.00),-- No Dept assigned (instead of 103 for FK safety)
(4, 'David', NULL, 45000.00),  -- No Dept assigned
(5, 'Emma', 102, 70000.00);    -- Matches IT

use MyFirstDB

select * from Departments;
select * from Employees;


---inner join

SELECT e.EmpID, e.EmpName, d.DeptName, d.Location
FROM Employees e
INNER JOIN Departments d
    ON e.DeptID = d.DeptID;

	--  Practice Queries for INNER JOIN

-- 1. List all employees with their department name

select e.EmpName, d.DeptName
from Employees E
inner join Departments D
on e.DeptId=d.DeptId;


-- 2. Get employee names and their department locations

select e.EmpName, d.location
from employees e
inner join departments d
on e.deptid=d.deptid

-- 3. Find all employees in the IT department

select e.EmpName, d.DeptName
from Employees E
inner join Departments D
on e.DeptId=d.DeptId
where DeptName='IT';

-- 4. Count how many employees are in each department

select DeptName,count(EmpId) as total from departments d
inner join employees e
on d.deptid=e.deptid
group by DeptName;


-- LEFT JOIN (LEFT OUTER JOIN)

SELECT columns
FROM LeftTable L
LEFT JOIN RightTable R
ON L.CommonColumn = R.CommonColumn;

-- Query 1: List all employees with their department names

select EmpName, DeptName 
from Employees E
left join Departments D
on e.deptId=d.deptId;


-- Q2️. List all departments with the employees working in them (if no employees, show NULL).

select deptname, empname
from departments d
left join employees e
on d.deptId=e.deptId;

-- Q3️.  Find employees who do not belong to any department. (Hint: filter where DeptName is NULL)

select empname,deptname
from employees e
left join departments d
on e.deptid=d.deptid 
where deptname is null;

-- Q4. Show employees’ names, department names, and location (even if the department does not exist).

select empname, deptname, location
from employees e
left join departments d
on e.deptid=d.deptid;

-- Q5️. Count how many employees are in each department (including departments with zero employees).

select deptname, count(empid) as totalemp
from departments d
left join employees e
on d.deptid=e.deptid
group by deptname;

-- RIGHT JOIN (Right Outer Join) 

-- Q1. List all departments and employees (even if no employee exists in a department).

select deptname, empname
from employees e
right join departments d
on e.deptid=d.deptid;

-- Q2. List all departments with their location and employees working in them.
-- Even if no employees are present in a department, still show the department.

select deptname, location, empname
from employees e
right join departments d
on e.deptid=d.deptid;

-- Q3. Find departments that do not have any employees.
-- (Hint: filter EmpName IS NULL after a RIGHT JOIN)

select deptname, empname
from employees e
right join departments d
on e.deptid=d.deptid
where empname is null;

-- Q4. Show all departments and employees, along with the department’s location (include empty departments).

select deptname, empname, location
from employees e
right join departments d
on e.deptid=d.deptid;

-- Q5. Count how many employees are in each department, including departments with zero employees (using RIGHT JOIN this time).

select deptname, count(empname) as totemp
from employees e
right join departments d
on e.deptid=d.deptid
group by deptname;

-- FULL OUTER JOIN 

-- Q1. List all employees with their department names (include employees with no dept & depts with no employees). Use FULL OUTER JOIN.

select empname, deptname
from employees e
Full join departments d
on e.deptid=d.deptid;

-- Q2. Show employees and their department locations (include employees with no dept & depts with no employees).

select empname, deptname, location
from employees e
full join departments d
on e.deptid=d.deptid;

-- Q3. Find all employees who are not assigned to any department, and all departments that have no employees.
-- (Hint: filter where DeptName IS NULL OR EmpName IS NULL).

select empname, deptname
from employees e
full join departments d
on e.deptid=d.deptid
where empname is null;

select empname, deptname
from employees e
full join departments d
on e.deptid=d.deptid
where deptname is null;

-- can give both as once by or

select empname, deptname
from employees e
full join departments d
on e.deptid=d.deptid
where empname is null or deptname is null;

-- Q4. Display all departments and employees, even if there is no match. Show: EmpName, DeptName, Location.

select empname, deptname, location
from employees e
full join departments d
on e.deptid=d.deptid;

-- Q5. Count how many employees exist in each department, but also show departments with zero employees and employees with no department.
-- (Hint: Use GROUP BY DeptName with FULL OUTER JOIN).

select deptname, count(empname) as totalemp
from departments d
full join employees e
on d.deptid=e.deptid
group by deptname;

-- CROSS JOIN = m × n rows

-- syntax:

SELECT columns
FROM TableA
CROSS JOIN TableB;

--  Q1. Show all possible employee–department combinations (basic CROSS JOIN).

SELECT EmpName, DeptName
FROM Employees
CROSS JOIN Departments;

-- Q2. Show all possible employee–department pairs, but only keep those where the employee’s DeptID matches the department’s DeptID.
--(This is how CROSS JOIN + WHERE can simulate INNER JOIN)

select empname, deptname
from employees e
cross join departments d
where e.deptid=d.deptid;

-- Q3. Find employees who could possibly belong to Finance (using CROSS JOIN, not INNER).
-- Hint: CROSS JOIN gives you all pairs first, then you filter

select empname, deptname
from employees e
cross join departments d
where deptname='Finance';

-- Q4. Show every employee paired with every possible location of departments.

select empname, location
from employees e
cross join departments d;

-- Q5. Suppose every employee can attend any department’s training. List all possible employee–training pairs.
--(Think of CROSS JOIN as generating “all possible scenarios”).

SELECT EmpName, DeptName AS TrainingDepartment
FROM Employees E
CROSS JOIN Departments D;

-- Q6. Assign every employee a potential project in each department (hypothetical mapping).

SELECT EmpName, DeptName, 
       CONCAT(EmpName, '_Project_', DeptName) AS ProjectCode
FROM Employees E
CROSS JOIN Departments D;

--  Creates unique project codes like:  Alice_Project_HR, Alice_Project_IT, Alice_Project_Finance, etc.



-- SELF JOIN

-- Syntax for Self Join:


SELECT E.EmpName AS Employee, M.EmpName AS Manager
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerID = M.EmpID;

-- real-life style dataset for self join practice:
-- for self join practice will create new table as manager

create table managers(
managerId int primary key,
managerName varchar(20),
department varchar(10),
location varchar(25),
reportsto int null);     --  refers to another manager ID

insert into managers (managerId, managerName, department, location, reportsto) 
values 
(1, 'Alice', 'HR', 'Chennai', NULL),     -- Alice is top-level
(2, 'Bob', 'IT', 'Bangalore', 1),        -- Bob reports to Alice
(3, 'Charlie', 'Finance', 'Hyderabad', 1), -- Charlie reports to Alice
(4, 'David', 'IT', 'Chennai', 2),        -- David reports to Bob
(5, 'Emma', 'Finance', 'Bangalore', 3);  -- Emma reports to Charlie

select * from managers;

 

-- Q1. Show each manager with their boss.

SELECT 
    E.ManagerName AS Employee,   -- Alias E = Employee
    M.ManagerName AS Boss        -- Alias M = Manager
FROM Managers E
LEFT JOIN Managers M
ON E.ReportsTo = M.ManagerID;
 

-- Q2. Find all employees who report to ‘Alice’.
-- (Hint: Self join, filter Boss = 'Alice')

SELECT 
    E.ManagerName AS Employee,  
    M.ManagerName AS Boss        
FROM Managers E
LEFT JOIN Managers M
    ON E.ReportsTo = M.ManagerID
	where M.ManagerName='Alice';

 

-- Q3.Find all employees who are managers themselves (i.e., others report to them).

SELECT DISTINCT M.ManagerName AS Manager
FROM Managers E
JOIN Managers M
    ON E.ReportsTo = M.ManagerID;


-- Q4.List employees and their "grandboss" (manager’s manager).
-- (This will need a double self join → Employees → Manager → Manager’s Manager)

SELECT 
    E.ManagerName AS Employee,
    M.ManagerName AS Boss,
    GM.ManagerName AS GrandBoss
FROM Managers E
LEFT JOIN Managers M
    ON E.ReportsTo = M.ManagerID
LEFT JOIN Managers GM
    ON M.ReportsTo = GM.ManagerID;

 

-- Q5.Find employees who don’t report to anyone (i.e., top-level managers).

SELECT ManagerName
FROM Managers
WHERE ReportsTo IS NULL;



-- 1. Equi Join
--Uses an equality operator (=) in the join condition.
--	Almost all joins we practiced so far (INNER, LEFT, RIGHT, FULL) are Equi Joins because we matched DeptID = DeptID.

SELECT EmpName, DeptName
FROM Employees E
INNER JOIN Departments D
    ON E.DeptID = D.DeptID;


-- 2. Non-Equi Join
---	Uses operators other than = (like <, >, BETWEEN, !=) in the join condition.
--	Useful when relationship is based on range instead of exact match.

SELECT E.EmpName, E.Salary, S.Grade
FROM Employees E
JOIN SalaryGrades S
    ON E.Salary BETWEEN S.MinSalary AND S.MaxSalary;


	-- MULTI TABLE Joins

--  Tables for Practice

-- 1. Employees

CREATE TABLE Employees1 (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT
);

INSERT INTO Employees1 (EmpID, EmpName, DeptID) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', NULL),
(4, 'David', 3),
(5, 'Emma', 2);

-- 2. Departments

CREATE TABLE Departments1 (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    LocationID INT
);

INSERT INTO Departments1 (DeptID, DeptName, LocationID) VALUES
(1, 'HR', 101),
(2, 'IT', 102),
(3, 'Finance', 103);

-- 3. Locations

CREATE TABLE Locations1 (
    LocationID INT PRIMARY KEY,
    City VARCHAR(50),
    Country VARCHAR(50)
);

INSERT INTO Locations1 (LocationID, City, Country) VALUES
(101, 'Chennai', 'India'),
(102, 'Bangalore', 'India'),
(103, 'Hyderabad', 'India'),
(104, 'Delhi', 'India');

select * from employees1;
select * from departments1;
select * from locations1;

--- Q1: List all employees with their department and city

SELECT e.EmpName, d.DeptName, l.City
FROM Employees1 e
INNER JOIN Departments1 d
   ON e.DeptID = d.DeptID
INNER JOIN Locations1 l
   ON d.LocationID = l.LocationID;

   -- here we have 3 table - employees1, departments1, location1
   -- deptID is common between employees and department table
   -- LocationID is common between department and location table
   -- we want employees , department and city in output-- where all 3 column is in different 3 tables 
   -- as usual we will join bt will use joins twice


  -- Q2. List all employees, even if they don’t have a department (use LEFT JOIN).

  SELECT e.EmpName, d.DeptName, l.City
FROM Employees1 e
LEFT JOIN Departments1 d
   ON e.DeptID = d.DeptID
LEFT JOIN Locations1 l
   ON d.LocationID = l.LocationID;

   -- Q3. Show all departments with their employees and city (even if no employee exists).

   select  d.deptname, e.empname, l.city
   from departments1 d
   left join employees1 e
   on e.deptid=d.deptid
   left join locations1 l
   on d.locationid=l.locationid;

  -- or

      select  d.deptname, e.empname, l.city
   from departments1 d
   left join employees1 e
   on e.deptid=d.deptid
   inner join locations1 l
   on d.locationid=l.locationid;

  -- Q4. Count how many employees are in each city.

  select l.city, count(empid) as total
  from locations1 l
  left join departments1 d
  on l.locationid=d.locationid
  left join employees1 e
  on e.deptid=d.deptid
  group by l.city;

  -- Dataset 2: Students, Courses, Enrollments

  CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Age INT
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Students
INSERT INTO Students VALUES 
(1, 'Ravi', 20),
(2, 'Priya', 21),
(3, 'Karthik', 22),
(4, 'Meena', 20);

-- Insert Courses
INSERT INTO Courses VALUES
(101, 'Maths', 4),
(102, 'Physics', 3),
(103, 'Chemistry', 4),
(104, 'Biology', 3);

-- Insert Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, 'A'),
(2, 1, 102, 'B'),
(3, 2, 101, 'A'),
(4, 3, 103, 'C');

select * from students;
select * from courses;
select * from enrollments;

-- Q1. List all students with the courses they are enrolled in.

select s.studentName, c.CourseName
from students s
left join enrollments e
on s.studentId=e.studentId
left join courses c
on e.courseid=c.courseid;

-- Q2. Find students who are not enrolled in any course.

select s.studentName, c.CourseName
from students s
left join enrollments e
on s.studentId=e.studentId
left join courses c
on e.courseid=c.courseid
where coursename is null;

-- or

SELECT s.StudentName
FROM Students s
LEFT JOIN Enrollments e
   ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;



-- Q3. List each course and how many students are enrolled.

select c.coursename, count(s.studentname) as studentcount
from courses c
left join enrollments e
on c.courseID=e.courseID
left join students s
on e.studentid=s.studentid
group by c.coursename;

-- Q4. Show student names, course names, and grades.

select s.studentname, c.coursename, e.grade
from students s
left join enrollments e
on s.studentid=e.studentid
left join courses c
on e.courseid=c.courseid;

-- Q5. Find courses that no student has enrolled in.

select c.coursename, s.studentname
from courses c
left join enrollments e
on c.courseID=e.courseID
left join students s
on e.studentid=s.studentid
where s.studentname is null;

--or

select c.coursename
from courses c
left join enrollments e on c.courseID = e.courseID
where e.studentid is null;


-- Q6. List each student with the total number of courses they are enrolled in

select s.studentname, count(c.courseid) as total
from students s
left join enrollments e
on s.studentid=e.studentid
left join courses c
on e.courseid=c.courseid
group by studentname;



-- Dataset 2: Orders, Customers, Products

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Suresh', 'Chennai'),
(2, 'Anita', 'Bangalore'),
(3, 'Rajesh', 'Hyderabad'),
(4, 'Divya', 'Chennai');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Laptop', 55000),
(102, 'Mobile', 20000),
(103, 'Tablet', 30000),
(104, 'Headphones', 2000);

-- Insert Orders
INSERT INTO Orders VALUES
(1, 1, 101, 1, '2025-08-01'),
(2, 1, 104, 2, '2025-08-05'),
(3, 2, 102, 1, '2025-08-10'),
(4, 3, 103, 1, '2025-08-12');

select * from customers;
select * from products;
select * from orders;


-- Sample Questions

-- Q1. List all orders with customer names and product names.

select c.customername, p.productname
from customers c
left join orders o
on c.customerid=o.customerid
inner join products p
on o.productid=p.productid;

-- Q2. Show total sales amount per customer.

select c.customername, sum(p.price) as totalamount
from customers c
left join orders o
on c.customerid=o.customerid
inner join products p
on o.productid=p.productid
group by c.customername
order by totalamount desc;

--or

select c.customername, sum(p.price * o.quantity) as totalamount
from customers c
join orders o on c.customerid = o.customerid
join products p on o.productid = p.productid
group by c.customername
order by totalamount desc;

--or

select 
    c.customername,
    p.productname,
    p.price,
    o.quantity,
    (p.price * o.quantity) as total_amount
from customers c
join orders o on c.customerid = o.customerid
join products p on o.productid = p.productid;




-- Q3. Find customers who have never placed an order.

select c.customername
from customers c
left join orders o
on c.customerid=o.customerid
left join products p
on o.productid=p.productid
where p.productid is null;

-- or

select c.customername
from customers c
left join orders o on c.customerid = o.customerid
where o.orderid is null;



-- Q4. List top 3 most ordered products.

-- wrong answer
-- used MAX(quantity), which only shows the largest single order for that product.
-- We need the total quantity ordered per product.

select p.productname, max(o.quantity) as most
from products p
left join orders o
on p.productid=o.productid
group by p.productname;

-- Correct Answer:

select top 3 p.productname, sum(o.quantity) as total_ordered
from products p
join orders o on p.productid = o.productid
group by p.productname
order by total_ordered desc;


-- Q5. Show all orders placed in the last 30 days with customer & product details.

-- wrong answer
-- query was missing the date filter.
-- We must assume the Orders table has an OrderDate column.

select c.customername, p.productname,p.Price
from customers c
left join orders o
on c.customerid=o.customerid
left join products p
on p.productid=o.productid;

-- Correct Answer:


