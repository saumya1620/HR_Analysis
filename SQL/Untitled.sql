SELECT COUNT(*) AS total_employees
FROM hr_analysis;

SELECT
    Department,
    COUNT(*) AS employee_count
FROM hr_analysis
GROUP BY Department
ORDER BY employee_count DESC;

SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM hr_analysis
GROUP BY JobRole
ORDER BY employee_count DESC;

SELECT
    JobLevel,
    COUNT(*) AS employee_count
FROM hr_analysis
GROUP BY JobLevel
ORDER BY JobLevel;

SELECT
    Gender,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM hr_analysis
GROUP BY Gender;

select
	agegroup,
    count(*) as employee_count
from hr_analysis
group by agegroup;

select
	jobrole,
	department,
    count(*) as employee_count
    from HR_analysis
    group by department,jobrole
    order by department,jobrole;


-- attrition analysis

select count(*) as employe_Count,
sum(case
	when attrition = 'Yes' then 1 else 0
    end) as employees_left,
sum(case
	when attrition = 'No' then 1 else 0
    end) as active_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end) *100.0 / count(*),2) as attrition_rate
from HR_analysis;

-- attrition by department
select department , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left 
from HR_analysis 
group by department;

-- attrition by job role
select jobrole , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from HR_analysis
group by jobrole;

-- attrition by agegroup 
select agegroup, sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_analysis
group by agegroup;

-- attrition by tenure
select tenuregroup , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_Analysis
group by tenuregroup;

-- attrition by overtime
select overtime, sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from HR_analysis
group by overtime;

-- attrition by buisness travel
select businesstravel , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from HR_analysis
group by businesstravel;

-- attrition by salary band
select salaryband , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_analysis
group by salaryband;

-- attrition by distance
select distancegroup , sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left
from HR_analysis
group by distancegroup;



-- compensation


-- average salary by department
select department , avg(monthlyincome) as average_salary 
from HR_analysis
group by department;

-- average salary by jobrole
select jobrole,avg(monthlyincome) as average_salary
from HR_analysis
group by jobrole;

-- salary by job level
select joblevel , count(*) as total_employees , avg(monthlyincome) as average_income , avg(percentsalaryhike) as average_hike
from HR_analysis
group by joblevel;

-- salary by exp group 
select experiencegroup , avg(monthlyincome) as average_Salary
from HR_analysis
group by experiencegroup;



-- career progression 


-- average tenure by department
select department,
	avg(yearsatcompany) as average_years,
    avg(yearsincurrentrole) as average_years_in_current_role,
    avg(yearssincelastpromotion) as average_years
    from HR_analysis
    group by department;
    
-- employees with long promotion gap 
select employeenumber,department,jobrole,joblevel,yearsatcompany,yearssincelastpromotion 
from HR_analysis
where yearssincelastpromotion >=5 ;

-- promotion gap by job level
select joblevel , avg(yearssincelastpromotion) as promotion_gap 
from hr_analysis
group by joblevel;

SELECT
    JobLevel,
    Attrition,
    COUNT(*) AS employees
FROM hr_analysis
GROUP BY JobLevel, Attrition
ORDER BY JobLevel, Attrition;


-- performance & employee xperience


-- performance by department
select department,avg(performancerating) as average_performance
from HR_analysis
group by department;

-- job satisfaction by department
select department,avg(jobsatisfaction) , avg(environmentsatisfaction) , avg(relationshipsatisfaction) 
from HR_analysis
GROUP BY department;

-- overtime vs satisfaction
SELECT
    OverTime,
    ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction,
    ROUND(AVG(WorkLifeBalance), 2) AS avg_work_life_balance,
    ROUND(AVG(EnvironmentSatisfaction), 2) AS avg_environment_satisfaction
FROM hr_analysis
GROUP BY OverTime;

-- satisfaction vs attrition 
SELECT
    JobSatisfaction,
    Attrition,
    COUNT(*) AS employees
FROM hr_analysis
GROUP BY JobSatisfaction, Attrition
ORDER BY JobSatisfaction, Attrition;

WITH department_attrition AS
(
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM hr_analysis
    GROUP BY Department
)

SELECT
    Department,
    total_employees,
    employees_left,
    attrition_rate,
    RANK() OVER (ORDER BY attrition_rate DESC) AS attrition_rank
FROM department_attrition;



WITH role_salary AS
(
    SELECT
        JobRole,
        ROUND(AVG(MonthlyIncome), 2) AS avg_salary
    FROM hr_analysis
    GROUP BY JobRole
)

SELECT
    JobRole,
    avg_salary,
    DENSE_RANK() OVER (ORDER BY avg_salary DESC) AS salary_rank
FROM role_salary;


    