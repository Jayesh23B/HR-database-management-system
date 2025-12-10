USE hr_db;
GO

/* 1. List all employees with department & manager */
SELECT 
    E.EmployeeCode,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    D.DepartmentName,
    M.FirstName + ' ' + M.LastName AS ManagerName,
    E.HireDate
FROM dbo.Employee E
LEFT JOIN dbo.Department D ON E.DepartmentID = D.DepartmentID
LEFT JOIN dbo.Employee M ON E.ManagerID = M.EmployeeID;
GO

/* 2. Employee count by department */
SELECT 
    D.DepartmentName,
    COUNT(E.EmployeeID) AS EmployeeCount
FROM dbo.Department D
LEFT JOIN dbo.Employee E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;
GO

/* 3. Average salary by department */
SELECT 
    D.DepartmentName,
    AVG(S.BaseSalary + ISNULL(S.VariablePay,0)) AS AvgCompensation
FROM dbo.Employee E
JOIN dbo.Department D ON E.DepartmentID = D.DepartmentID
JOIN dbo.Salary S ON E.EmployeeID = S.EmployeeID AND S.EffectiveTo IS NULL
GROUP BY D.DepartmentName;
GO

/* 4. Current salary details */
SELECT 
    E.EmployeeCode,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    S.BaseSalary,
    S.VariablePay,
    (S.BaseSalary + ISNULL(S.VariablePay,0)) AS TotalCompensation
FROM dbo.Employee E
JOIN dbo.Salary S ON E.EmployeeID = S.EmployeeID AND S.EffectiveTo IS NULL;
GO

/* 5. Project allocation details */
SELECT
    E.EmployeeCode,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
    P.ProjectName,
    EP.Role,
    EP.AllocationPercent
FROM dbo.EmployeeProject EP
JOIN dbo.Employee E ON EP.EmployeeID = E.EmployeeID
JOIN dbo.Project P ON EP.ProjectID = P.ProjectID;
GO

/* 6. Hiring trend by year */
SELECT 
    YEAR(HireDate) AS HireYear,
    COUNT(*) AS TotalHires
FROM dbo.Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear;
GO

/* 7. Managers with number of direct reports */
SELECT 
    M.EmployeeCode,
    M.FirstName + ' ' + M.LastName AS ManagerName,
    COUNT(E.EmployeeID) AS DirectReports
FROM dbo.Employee M
LEFT JOIN dbo.Employee E ON E.ManagerID = M.EmployeeID
GROUP BY M.EmployeeCode, M.FirstName, M.LastName
HAVING COUNT(E.EmployeeID) > 0;
GO

