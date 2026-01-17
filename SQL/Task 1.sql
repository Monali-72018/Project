CREATE DATABASE MYDB_Project;

USE MYDB_Project;

CREATE TABLE Employee (
    Empno INT(4) NOT NULL DEFAULT 0,
    Ename VARCHAR(10),
    Job VARCHAR(9),
    Mgr INT(4),
    Hiredate DATE,
    Sal DECIMAL(7 , 2 ),
    Comm DECIMAL(7 , 2 ),
    Deptno INT(2),
    PRIMARY KEY (Empno)
);

CREATE TABLE Dept (
    Deptno INT(2) NOT NULL DEFAULT 0,
    Dname VARCHAR(14),
    Loc VARCHAR(13),
    PRIMARY KEY (Deptno)
);

CREATE TABLE Student (
    Rno INT(2) NOT NULL DEFAULT 0,
    Sname VARCHAR(14),
    City VARCHAR(20),
    State VARCHAR(20),
    PRIMARY KEY (Rno)
);

CREATE TABLE Emp_Log (
    Empno INT(5) NOT NULL,
    Log_date DATE,
    New_salary INT(10),
    Action VARCHAR(20),
    CONSTRAINT fk_emp FOREIGN KEY (Empno)
        REFERENCES Employee (Empno)
);

INSERT INTO Dept (Deptno, Dname, Loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

SELECT 
    *
FROM
    Dept;

INSERT INTO Employee
(Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno)
VALUES
(7369, 'SMITH',  'CLERK',    7902, '1980-12-17',  800.00,  NULL, 20),
(7499, 'ALLEN',  'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD',   'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES',  'MANAGER',  7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE',  'MANAGER',  7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK',  'MANAGER',  7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT',  'ANALYST',  7566, '1987-06-11', 3000.00, NULL, 20),
(7839, 'KING',   'PRESIDENT', NULL,'1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30),
(7876, 'ADAMS',  'CLERK',    7788, '1987-07-13', 1100.00, NULL, 20),
(7900, 'JAMES',  'CLERK',    7698, '1981-03-12',  950.00, NULL, 30),
(7902, 'FORD',   'ANALYST',  7566, '1981-03-12', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK',    7782, '1982-01-23', 1300.00, NULL, 10);

SELECT 
    *
FROM
    Employee;

-- Q - 1. Select unique job from EMP table.

SELECT DISTINCT
    job
FROM
    Employee;

-- Q - 2. List the details of the emps in asc order of the Dptnos and desc of Jobs? 

SELECT 
    *
FROM
    Employee
ORDER BY Deptno ASC , Job DESC;

-- Q - 3. Display all the unique job groups in the descending order? 

SELECT DISTINCT
    job
FROM
    Employee
ORDER BY Job DESC;

-- Q - 4. List the emps who joined before 1981. 

SELECT 
    *
FROM
    Employee
WHERE
    Hiredate < '1981-01-01';

-- Q - 5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.

SELECT 
    Empno, Ename, Sal, Sal / 30 AS Daily_sal, Sal * 12 AS Annsal
FROM
    Employee
ORDER BY Annsal ASC;

-- Q - 6. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.

SELECT Empno, Ename, Sal,
       TIMESTAMPDIFF(YEAR, Hiredate, CURDATE()) AS Exp
FROM Employee
WHERE Mgr = 7369;


-- Q - 7. Display all the details of the emps who’s Comm. Is more than their Sal? 

SELECT 
    *
FROM
    Employee
WHERE
    Comm > sal;

-- Q - 8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order. 

SELECT 
    *
FROM
    Employee
WHERE
    Job IN ('CLERK' , 'ANALYST')
ORDER BY Job desc;

-- Q - 9 List the emps Who Annual sal ranging from 22000 and 45000;

SELECT Empno, Ename, Sal, Sal * 12 AS Annual_Sal
FROM Employee
WHERE Sal * 12 BETWEEN 22000 AND 45000;

-- Q - 10. List the Enames those are starting with ‘S’ and with five characters. 

select * from Employee
where Ename like 'S____';

-- Q - 11. List the emps whose Empno not starting with digit78. 

SELECT *
FROM Employee
WHERE CAST(Empno AS CHAR) NOT LIKE '78%';

-- Q - 12. List all the Clerks of Deptno 20. 

Select * from Employee
where Job = 'CLERK' and  Deptno = 20;

-- Q - 13. List the Emps who are senior to their own MGRS. 

SELECT 
    e.Empno,
    e.Ename,
    e.Hiredate,
    m.Ename AS Manager_Name,
    m.Hiredate AS Manager_Hiredate
FROM Employee e
JOIN Employee m
ON e.Mgr = m.Empno
WHERE e.Hiredate < m.Hiredate;

-- Q - 14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10. 

SELECT *
FROM Employee
WHERE Deptno = 20
AND Job IN (
    SELECT DISTINCT Job
    FROM Employee
    WHERE Deptno = 10
);

-- Q - 15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal. 

SELECT Empno, Ename, Sal
FROM Employee
WHERE Sal IN (
    SELECT Sal
    FROM Employee
    WHERE Ename IN ('FORD', 'SMITH')
)
ORDER BY Sal DESC;

-- Q - 16. List the emps whose jobs same as SMITH or ALLEN. 

SELECT Empno, Ename, Job
FROM Employee
WHERE Job IN (
    SELECT Job
    FROM Employee
    WHERE Ename IN ('ALLEN', 'SMITH')
);

-- Q - 17. Any jobs of deptno 10 those that are not found in deptno 20. 

select 
	Ename,Job,Deptno 
from Employee
where Deptno = 10
and Job not in (select Job
from Employee where deptno = 20);

-- Q - 18. Find the highest sal of EMP table. 

SELECT *
FROM Employee
WHERE Sal = (SELECT MAX(Sal) FROM Employee);

-- Q - 19. Find details of highest paid employee. 

SELECT *
FROM Employee
ORDER BY Sal DESC
LIMIT 1;

SELECT *
FROM Employee
WHERE Sal = (SELECT MAX(Sal) FROM Employee);

-- Q - 20. Find the total sal given to the MGR. 

SELECT SUM(DISTINCT e.Sal) AS Total_Manager_Sal
FROM Employee e
JOIN Employee sub
ON e.Empno = sub.Mgr;

-- Q - 21. List the emps whose names contains ‘A’. 

select * from Employee
where Ename like '%A%';

-- Q - 22. Find all the emps who earn the minimum Salary for each job wise in ascending order. 

SELECT Ename, Job, Sal
FROM Employee e
WHERE Sal = (
    SELECT MIN(Sal)
    FROM Employee
    WHERE Job = e.Job
)
ORDER BY Job ASC;

-- Q - 23. List the emps whose sal greater than Blake’s sal. 

SELECT Ename, Sal
FROM Employee
WHERE Sal > (
    SELECT Sal
    FROM Employee
    WHERE Ename = 'BLAKE'
);

-- Q - 24. Create view v1 to select ename, job, dname, loc whose deptno are same. 

CREATE VIEW v1 AS
SELECT 
    e.Ename,
    e.Job,
    d.Dname,
    d.Loc
FROM Employee e
INNER JOIN Dept d
ON e.Deptno = d.Deptno;

select * from v1;

-- Q - 25. Create a procedure with dno as input parameter to fetch ename and dname.

DELIMITER $$

CREATE PROCEDURE get_emp_dept(IN dno INT)
BEGIN
    SELECT e.Ename, d.Dname
    FROM Employee e
    INNER JOIN Dept d
        ON e.Deptno = d.Deptno
    WHERE e.Deptno = dno;
END $$

DELIMITER ;

CALL get_emp_dept(10);

-- Q - 26. Add column Pin with bigint data type in table student. 

ALTER TABLE student
ADD Pin BIGINT;

-- Q - 27. Modify the student table to change the sname length from 14 to 40. 

ALTER TABLE student
MODIFY sname VARCHAR(40);


-- Q - 28.Create trigger to insert data in emp_log table whenever any update of sal in EMP table.
    # You can set action as ‘New Salary’.

#Drop trigger trg_sal_update;

DELIMITER $$

CREATE TRIGGER trg_sal_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Sal <> NEW.Sal THEN
        INSERT INTO Emp_Log
            (Empno, Log_date, New_salary, Action)
        VALUES
            (NEW.Empno, CURRENT_DATE, NEW.Sal, 'New Salary');
    END IF;
END $$

DELIMITER ;


UPDATE Employee
SET Sal = Sal + 500
WHERE Empno = 7369;

SELECT * FROM Emp_Log;









