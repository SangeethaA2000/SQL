

-- string functions

use MyFirstDB


CREATE TABLE Employees2 (
    EmpID INT,
    EmpName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Employees2 VALUES
(1, 'Alice Johnson', 'Chennai'),
(2, 'Bob Smith', 'Bangalore'),
(3, 'Charlie Brown', 'Delhi'),
(4, 'David Miller', 'Hyderabad'),
(5, 'Emma Watson', 'Mumbai');

-- 1. LEN / LENGTH → returns length of string

SELECT EmpName, LEN(EmpName) AS NameLength FROM Employees2;

-- 2. UPPER → convert to uppercase

SELECT EmpName, UPPER(EmpName) AS UpperName FROM Employees2;

-- 3. LOWER → convert to lowercase

SELECT City, LOWER(City) AS LowerCity FROM Employees2;

-- 4. LTRIM / RTRIM / TRIM → remove spaces

SELECT LTRIM('   Hello') AS NoLeftSpaces,
       RTRIM('Hello   ') AS NoRightSpaces,
       TRIM('   Hello   ') AS NoSpaces
FROM Employees2;
