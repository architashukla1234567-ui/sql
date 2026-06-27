Data Analyst Job Market Analysis (SQL Project)

Introduction:
This project explores the data analyst job market using SQL queries to uncover insights about top-paying roles, in-demand skills, and the intersection of high salary and high demand. The goal is to help job seekers make smarter career decisions by understanding what the market truly values.

Background:
The job market for data analysts is vast and competitive. This project digs into real job postings data to answer key questions:
1.Which companies offer the highest-paying remote Data Analyst roles?
2.What skills do top-paying jobs require?
3.Which skills are most in demand across all job postings?
4.What skills command the highest average salaries?
5.What are the most optimal skills to learn — high demand AND high pay?

Tools I Used:
SQL — Core tool for all data querying and analysis
PostgreSQL — Database management system
VS Code — Writing and running SQL queries with the SQL Console extension
Git & GitHub — Version control and project sharing


The Analysis
1. Top-Paying Data Analyst Jobs
File: 1_top_paying_jobs.sql
Identifies the top 10 highest-paying remote Data Analyst roles with explicitly listed salaries, joined with company data to show which organizations offer the best compensation.

sqlSELECT job_id, job_title, job_location, job_schedule_type,
       salary_year_avg, job_posted_date, name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;


2. Skills Required for Top-Paying Jobs

File: 2_top_paying_jobs.sql

Uses a CTE to pull the top 10 highest-paying jobs from Query 1, then joins with skills tables to reveal exactly which skills those roles demand.

Key Findings:


SQL had the highest demand (mentioned 8 times)
Python was a strong second (mentioned 7 times)
Tableau was highly sought after (mentioned 6 times)
Secondary skills: R, Snowflake, Pandas, and Excel



3. Most In-Demand Skills Across All Postings

File: 3_top_paying_jobs.sql

Aggregates skill mention counts across all Data Analyst job postings to find the top 5 most universally valued skills in the market.

sqlSELECT skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;


4. Highest-Paying Skills

File: 4_top_paying_jobs.sql

Calculates the average salary associated with each skill for Data Analyst roles (all locations, salaries specified). Helps job seekers prioritize which skills to learn for maximum financial impact.

sqlSELECT skills, ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;


5. Most Optimal Skills to Learn
File: 5_optimal_skill.sql
The most strategic query of the project — finds skills that are both high in demand and high in average salary, focused on remote Data Analyst roles. Uses two CTEs (skills_demand and average_salary) joined together for a complete picture.
Purpose: Provide strategic insights for career development by targeting skills that offer both job security and strong financial reward.


What I Learned:
SQL is non-negotiable — it dominates both demand and top-paying job requirements
Python and Tableau are the next most valuable skills to develop
CTEs are powerful for breaking complex multi-step queries into readable logic
Combining demand counts with average salaries gives a much clearer picture of skill value than looking at either metric alone
Remote Data Analyst roles with high salaries are competitive but very attainable with the right skill set


Conclusions:
This project reveals that a focused skill set — particularly SQL, Python, and Tableau — positions a Data Analyst candidate very strongly in today's market. For those looking to maximize both employability and earning potential, targeting skills with high demand and high average salary (as shown in Query 5) is the most efficient strategy.
