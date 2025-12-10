USE hr_db;
GO

/* ======================
   INSERT DEPARTMENTS
   ====================== */
INSERT INTO dbo.Department (DepartmentName, Location) VALUES
('Human Resources', 'Mumbai'),
('Engineering', 'Pune'),
('Sales', 'Bangalore'),
('Finance', 'Mumbai');
GO

/* ======================
   INSERT JOB TITLES
   ====================== */
INSERT INTO dbo.JobTitle (JobTitleName) VALUES
('HR Manager'),
('Software Engineer'),
('Senior Software Engineer'),
('Sales Executive'),
('Finance Manager');
GO

/* ======================
   INSERT EMPLOYEES
   ====================== */

-- Managers
INSERT INTO dbo.Employee (EmployeeCode, FirstName, LastName, Gender, DateOfBirth, Email, PhoneNumber, HireDate, DepartmentID, ManagerID, IsActive, JobTitleID)
VALUES
('EMP001','Rahul','Sharma','M','1985-02-10','rahul.sharma@example.com','9876543210','2015-06-01',1,NULL,1,1),
('EMP002','Sneha','Patil','F','1987-08-15','sneha.patil@example.com','9876543211','2016-01-15',2,NULL,1,3),
('EMP003','Amit','Joshi','M','1984-11-20','amit.joshi@example.com','9876543212','2014-09-10',3,NULL,1,5);
GO

-- Employees reporting to managers
INSERT INTO dbo.Employee (...)
VALUES
('EMP004','Priya','Desai','F','1992-04-05','priya.desai@example.com','9876543213','2019-03-01',2,2,1,2),
('EMP005','Rohan','Kulkarni','M','1993-09-25','rohan.kulkarni@example.com','9876543214','2020-07-15',2,2,1,2),
('EMP006','Neha','Mehta','F','1990-12-30','neha.mehta@example.com','9876543215','2018-11-01',3,3,1,4);
GO

/* ======================
   INSERT PROJECTS
   ====================== */
INSERT INTO dbo.Project (ProjectName, ClientName, StartDate, EndDate, Status, DepartmentID)
VALUES
('HR Automation Portal','Internal','2021-01-01',NULL,'Active',1),
('Billing System','ABC Corp','2020-05-01',NULL,'Active',2),
('Sales Dashboard','XYZ Ltd','2021-03-15','2022-03-31','Completed',3);
GO

/* ======================
   INSERT EMPLOYEE-PROJECT ALLOCATION
   ====================== */
-- Rahul on HR Portal
INSERT INTO dbo.EmployeeProject
SELECT EmployeeID, 1, 'Project Lead', 50, '2021-01-01', NULL
FROM dbo.Employee WHERE EmployeeCode='EMP001';

-- Priya & Rohan on Billing System
INSERT INTO dbo.EmployeeProject
SELECT EmployeeID, 2, 'Developer', 100, '2020-05-01', NULL
FROM dbo.Employee WHERE EmployeeCode IN ('EMP004','EMP005');

-- Neha on Sales Dashboard
INSERT INTO dbo.EmployeeProject
SELECT EmployeeID, 3, 'Business Analyst', 100, '2021-03-15','2022-03-31'
FROM dbo.Employee WHERE EmployeeCode='EMP006';
GO

/* ======================
   INSERT SALARIES
   ====================== */

INSERT INTO dbo.Salary (EmployeeID, BaseSalary, VariablePay, EffectiveFrom, EffectiveTo)
SELECT EmployeeID, 800000,150000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP001';

INSERT INTO dbo.Salary (EmployeeID, BaseSalary, VariablePay, EffectiveFrom, EffectiveTo)
SELECT EmployeeID, 700000,120000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP002';

INSERT INTO dbo.Salary (...)
SELECT EmployeeID, 850000,180000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP003';

INSERT INTO dbo.Salary (...)
SELECT EmployeeID, 500000,80000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP004';

INSERT INTO dbo.Salary (...)
SELECT EmployeeID, 480000,70000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP005';

INSERT INTO dbo.Salary (...)
SELECT EmployeeID, 520000,90000,'2023-04-01',NULL FROM dbo.Employee WHERE EmployeeCode='EMP006';
GO

