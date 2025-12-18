                                         -- Data Cleaning
create database Employee_attrition;


-- Created copy of raw data

create table hr_data
(select * from hr_data_raw);


-- Created Dimension Tables
-- Employees

create table Employees
(select distinct employee_number,age,education_field,
 gender,marital_status
 from hr_data);


 -- Department

 create table Department
 (select distinct department from hr_data);


 -- Job_role

 create table Job_role
 (select distinct Job_role from hr_data);


-- Dropped Irrelevant columns

alter table hr_data
drop column education,
drop column over_18,
drop column Standard_Hours;


-- Changed Data Type 

alter table hr_data
modify Age int,
modify Attrition text, 
modify Business_Travel text, 
modify Daily_Rate int, 
modify Department text,
modify Distance_From_Home int,  
modify Education_Field text, 
modify Employee_Number int, 
modify Environment_Satisfaction int, 
modify Gender text, 
modify Hourly_Rate int, 
modify Job_Involvement int, 
modify Job_Level int, 
modify Job_Role text, 
modify Job_Satisfaction int, 
modify Marital_Status text, 
modify Monthly_Income int, 
modify Monthly_Rate int, 
modify Num_Companies_Worked int, 
modify OverTime text, 
modify Percent_Salary_Hike int, 
modify Performance_Rating int, 
modify Relationship_Satisfaction int, 
modify Total_Working_Years int, 
modify Work_Life_Balance int, 
modify Years_At_Company int, 
modify Years_In_CurrentRole int, 
modify Years_Since_Last_Promotion int,
modify Years_With_Curr_Manager int;


                                              -- Data Analysis

-- What is the Attrition Rate by Department & Job Role?   

with attrition_perc as 
(select d.Department_name,j.job_role_name,count(*) as Total_employees,
  sum(case when h.attrition = 'Yes' then 1 else 0 end ) as Total_attrition, 
  round(100.0*sum(case when h.attrition = 'Yes' then 1 else 0 end )/ 
    (count(*)),2) as Attrition_rate 
from hr_data as h 
 join departments as d 
  on d.department_name = h.department_name 
 join job_roles as j 
  on j.Job_role_name = h.Job_role_name 
group by d.Department_name,j.job_role_name), 

attrition_ranks as 
(select Department_name,job_role_name,Total_employees,Total_attrition,Attrition_rate, 
  dense_rank() over(partition by Department_name order by attrition_rate desc) as ranking 
from attrition_perc 
where total_attrition > 0) 

select Department_name,job_role_name,Total_employees,
  Total_attrition,Attrition_rate 
from attrition_ranks;


-- What is the Attrition rate by Salary Slab?

with attritions as
(select 
case when monthly_income < 4000 then 'Low'
     when monthly_income between 4000 and 9000 then 'Medium'
       else 'High' end as Salary_band,
count(*) as Total_employees,
sum(case when Attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by salary_band)

select Salary_band,Total_employees,Total_attrition,
 round(100.0*total_attrition/total_employees,2) as attrition_rate
from attritions
order by attrition_rate desc;


-- What is the Attrition rate by Employee experience at company?

with attritions as
(select Years_At_Company,count(*) as total_employees,
 sum(case when attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by Years_At_Company)

select Years_At_Company,total_employees,Total_attrition,
  round(100.0*Total_attrition/total_employees,2) as attrition_rate
from attritions
where Total_attrition is not null
order by attrition_rate desc;


-- Is Work-Life Balance Impacting employee attrition?

with attritions as
(select Work_Life_Balance,count(*) as Total_employees,
 sum(case when attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by Work_Life_Balance)   

select Work_Life_Balance,Total_employees,Total_attrition,
    round(100.0*Total_attrition/total_employees,2) as attrition_rate
from attritions
order by attrition_rate desc;


-- Are good performers leaving the most?

with attritions as
(select Performance_Rating,count(*) as Total_employees,
 sum(case when attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by Performance_Rating)
								
select Performance_Rating,Total_employees,Total_attrition,
  round(100.0*Total_attrition/total_employees,2) as attrition_rate
from attritions
order by attrition_rate desc;											
                                              
-- Who are the employees with High risk of attrition? (Attrition Risk Segmentation) 

select Employee_Number,Department_name,
case when overtime = 'Yes' and Job_Satisfaction <=2 and 
          Years_At_Company < 3   then 'High Risk' 
	 when overtime = 'Yes' and Job_Satisfaction <=3 and 
          Years_At_Company < 3   then 'Medium Risk' 
            else 'Low Risk' end as attrition_risk
from hr_data;                                             


-- Do we have risk of Loosing most experienced employees in the company? (Attrition Cohort Analysis)  

with attritions as
(select case when Years_At_Company <=1 then '0-1 Years' 
            when Years_At_Company <=2 then '1-2 Years' 
            when Years_At_Company <=5 then '2-5 Years' 
            else '5+ Years' end as experience_band,
	count(*) as Total_employees,
    sum(case when attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by experience_band)                                              
                                              
select experience_band,Total_employees,Total_attrition,
  round(100.0*Total_attrition/total_employees,2) as attrition_rate
from attritions
order by attrition_rate desc;											


-- Is No promotion in the last years affecting the attrition? 

with attritions as
(select Years_Since_Last_Promotion,count(*) as Total_employees,
sum(case when attrition = 'Yes' then 1 end) as Total_attrition
from hr_data
group by Years_Since_Last_Promotion)

select Years_Since_Last_Promotion,Total_employees,
 Total_attrition,round(100.0*Total_attrition/total_employees,2) as attrition_rate
from attritions
where Total_attrition is not null
order by attrition_rate desc; 


-- What is the Attrition Cost by Department?

select d.department_name,count(*) as Total_employees,
sum(case when attrition = 'Yes' then 1 end) as Total_attrition,
(6*sum(case when attrition = 'Yes' then Monthly_Income end)) as estimated_attrition_cost 
 -- 6 months salary as replacement proxy
from hr_data as h
 join departments as d
  on h.department_name = d.department_name
group by d.department_name;


-- What are the Top Risk factors?

select OverTime,Job_Satisfaction,Years_at_company,
count(*) as attritions
from hr_data
where Attrition='Yes'
group by OverTime,Job_Satisfaction,Years_at_company
order by attritions desc
limit 10;











											
                                              
                                              
                                              
                                              
                                              
