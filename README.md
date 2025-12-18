👥 HR Employee Attrition Analysis & Prediction
📘 Introduction

Employee attrition poses a significant challenge for organizations by increasing hiring costs, disrupting productivity, and impacting workforce stability.
This project analyzes HR employee data to understand why employees leave, identify high-risk groups, and uncover key drivers of attrition.
The analysis combines structured HR data with SQL-based analytics and Power BI dashboards to generate actionable, business-focused insights.

🎯 Objectives

The key objectives of this analysis are:

To analyze overall employee attrition trends across the organization

To examine attrition patterns by tenure, salary, department, and job role

To understand the impact of overtime, work-life balance, and performance ratings on attrition

To identify high-risk employee segments

To provide data-driven recommendations that can help HR teams reduce employee churn

🗂️ Dataset and Context

One primary dataset was used:

HR Employee Attrition Dataset (HR-Employee-Attrition.csv)

The dataset contains employee-level information such as:

Demographics: Age, Gender, Marital Status

Job Information: Department, Job Role, Job Level

Compensation: Monthly Income, Salary Band

Work Conditions: Overtime, Work-Life Balance

Performance: Performance Rating

Attrition Status: Yes / No

Each row represents one employee.

🧰 Tools Used

The analysis was carried out using:

SQL

Data cleaning and transformation

Attrition rate calculations

CTEs, CASE statements, and aggregations

Power BI

Interactive dashboards

KPI visualization and business storytelling

CSV / Excel

Source data storage

The SQL script and dashboard are included for reproducibility.

🧹 Data Preparation

The following data preparation steps were undertaken:

Cleaned and standardized HR data fields

Created derived columns such as tenure buckets and salary bands

Converted categorical variables for analysis

Segmented employees by department, role, and experience level

Filtered and validated attrition flags

Aggregated data to compute department-level and role-level attrition rates

📊 Key Findings

Early-tenure employees (0–1 year) experience the highest attrition rate, indicating onboarding and early engagement gaps

Employees in the low salary band show significantly higher attrition compared to medium and high salary groups

Overtime and poor work-life balance are strongly associated with attrition, with rates exceeding 30% in some segments

Attrition is role-specific, with Sales-related and operational roles experiencing higher churn

High performance ratings do not reduce attrition, suggesting burnout and compensation issues outweigh performance satisfaction

📈 Dashboard Insights

The Power BI dashboard provides:

Overall attrition KPIs

Attrition by tenure, department, and job role

Salary vs attrition comparisons

Overtime and work-life balance impact analysis

Filters for deep-dive exploration

📄 Dashboard preview available in Dashboard.pdf

💬 Conclusion and Insights

The analysis shows that employee attrition is driven more by structural and operational factors than individual performance.

Early-career employees, low-paid roles, and overtime-heavy positions face the highest attrition risk. Departments such as Sales require targeted retention strategies, while compensation and workload balance emerge as critical levers for reducing churn.

Retention efforts focused on early engagement, fair pay, and sustainable workloads can significantly improve workforce stability.

💡 Recommendations

Strengthen early-tenure onboarding and mentoring programs

Review and optimize compensation for low-paid, high-attrition roles

Actively monitor and control overtime and workload distribution

Design role-specific retention strategies, especially for Sales and HR

Implement an attrition risk scoring framework using tenure, overtime, and satisfaction indicators
