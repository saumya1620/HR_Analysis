select count(*) from hr_data;
select count(distinct employeenumber) from hr_data;
SELECT 
    EmployeeNumber,
    COUNT(*) AS employee_count
FROM hr_data
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_data), 2) AS percentage
FROM hr_data
GROUP BY Attrition;

CREATE VIEW hr_analysis AS
SELECT
    EmployeeNumber,
    Age,
    Gender,
    MaritalStatus,
    Education,
    EducationField,
    Department,
    JobRole,
    JobLevel,
    BusinessTravel,
    OverTime,
    DistanceFromHome,

    DailyRate,
    HourlyRate,
    MonthlyIncome,
    MonthlyRate,
    PercentSalaryHike,
    StockOptionLevel,

    TotalWorkingYears,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager,
    NumCompaniesWorked,
    TrainingTimesLastYear,

    EnvironmentSatisfaction,
    JobInvolvement,
    JobSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,
    PerformanceRating,

    Attrition,

    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS AgeGroup,

    CASE
        WHEN YearsAtCompany <= 1 THEN '<2 Years'
        WHEN YearsAtCompany BETWEEN 2 AND 4 THEN '2-4 Years'
        WHEN YearsAtCompany BETWEEN 5 AND 7 THEN '5-7 Years'
        WHEN YearsAtCompany BETWEEN 8 AND 10 THEN '8-10 Years'
        ELSE '11+ Years'
    END AS TenureGroup,

    CASE
        WHEN TotalWorkingYears <= 2 THEN '0-2 Years'
        WHEN TotalWorkingYears BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN TotalWorkingYears BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN TotalWorkingYears BETWEEN 11 AND 20 THEN '11-20 Years'
        ELSE '21+ Years'
    END AS ExperienceGroup,

    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome < 6000 THEN 'Lower-Middle'
        WHEN MonthlyIncome < 10000 THEN 'Upper-Middle'
        ELSE 'High'
    END AS SalaryBand,

    CASE
        WHEN DistanceFromHome <= 5 THEN '0-5 Miles'
        WHEN DistanceFromHome <= 10 THEN '6-10 Miles'
        WHEN DistanceFromHome <= 20 THEN '11-20 Miles'
        ELSE '21+ Miles'
    END AS DistanceGroup

FROM hr_data;

SELECT *
FROM hr_analysis;

