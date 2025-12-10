/* ============================================================
   HR DATABASE – SCHEMA
   Creates tables, keys, and relationships
   ============================================================ */

IF DB_ID('hr_db') IS NULL
BEGIN
    CREATE DATABASE hr_db;
END;
GO

USE hr_db;
GO

/* ======================
   1. DEPARTMENT TABLE
   ====================== */

IF OBJECT_ID('dbo.Department', 'U') IS NOT NULL
    DROP TABLE dbo.Department;
GO

CREATE TABLE dbo.Department (
    DepartmentID      INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName    VARCHAR(100) NOT NULL UNIQUE,
    Location          VARCHAR(100),
    CreatedAt         DATETIME2 DEFAULT SYSDATETIME()
);
GO

/* ======================
   2. PROJECT TABLE
   ====================== */

IF OBJECT_ID('dbo.Project', 'U') IS NOT NULL
    DROP TABLE dbo.Project;
GO

CREATE TABLE dbo.Project (
    ProjectID     INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName   VARCHAR(150) NOT NULL,
    ClientName    VARCHAR(150),
    StartDate     DATE,
    EndDate       DATE,
    Status        VARCHAR(50),
    DepartmentID  INT,
    CONSTRAINT FK_Project_Department
        FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID)
);
GO

/* ======================
   3. EMPLOYEE TABLE
   ====================== */

IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL
    DROP TABLE dbo.Employee;
GO

CREATE TABLE dbo.Employee (
    EmployeeID    INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeCode  VARCHAR(20) NOT NULL UNIQUE,
    FirstName     VARCHAR(50) NOT NULL,
    LastName      VARCHAR(50) NOT NULL,
    Gender        CHAR(1) CHECK (Gender IN ('M','F','O')),
    DateOfBirth   DATE,
    Email         VARCHAR(100) UNIQUE,
    PhoneNumber   VARCHAR(20),
    HireDate      DATE NOT NULL,
    DepartmentID  INT,
    ManagerID     INT,
    IsActive      BIT DEFAULT 1,

    CONSTRAINT FK_Employee_Department
        FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID),

    CONSTRAINT FK_Employee_Manager
        FOREIGN KEY (ManagerID) REFERENCES dbo.Employee(EmployeeID)
);
GO

/* ======================
   4. JOB TITLE TABLE
   ====================== */

IF OBJECT_ID('dbo.JobTitle', 'U') IS NOT NULL
    DROP TABLE dbo.JobTitle;
GO

CREATE TABLE dbo.JobTitle (
    JobTitleID      INT IDENTITY(1,1) PRIMARY KEY,
    JobTitleName    VARCHAR(100) NOT NULL UNIQUE,
    CreatedAt       DATETIME2 DEFAULT SYSDATETIME()
);
GO

ALTER TABLE dbo.Employee
ADD JobTitleID INT NULL
CONSTRAINT FK_Employee_JobTitle
FOREIGN KEY (JobTitleID) REFERENCES dbo.JobTitle(JobTitleID);
GO

/* ======================
   5. SALARY TABLE
   ====================== */

IF OBJECT_ID('dbo.Salary', 'U') IS NOT NULL
    DROP TABLE dbo.Salary;
GO

CREATE TABLE dbo.Salary (
    SalaryID        INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID      INT NOT NULL,
    BaseSalary      DECIMAL(18,2) NOT NULL,
    VariablePay     DECIMAL(18,2),
    EffectiveFrom   DATE NOT NULL,
    EffectiveTo     DATE,

    CONSTRAINT FK_Salary_Employee
        FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID)
);
GO

/* ======================
   6. EMPLOYEE PROJECT TABLE
   ====================== */

IF OBJECT_ID('dbo.EmployeeProject', 'U') IS NOT NULL
    DROP TABLE dbo.EmployeeProject;
GO

CREATE TABLE dbo.EmployeeProject (
    EmployeeID        INT NOT NULL,
    ProjectID         INT NOT NULL,
    Role              VARCHAR(100),
    AllocationPercent INT CHECK (AllocationPercent BETWEEN 0 AND 100),
    StartDate         DATE NOT NULL,
    EndDate           DATE,

    CONSTRAINT PK_EmployeeProject PRIMARY KEY (EmployeeID, ProjectID, StartDate),

    CONSTRAINT FK_EmployeeProject_Employee
        FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID),

    CONSTRAINT FK_EmployeeProject_Project
        FOREIGN KEY (ProjectID) REFERENCES dbo.Project(ProjectID)
);
GO

