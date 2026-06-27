/*
Objective: What are the highest-paying skills for Data Analysts?

Implementation:
- Calculate the average salary associated with each skill.
- Filter for Data Analyst roles with explicitly specified salaries.
- Include all locations (global search).

Purpose: Reveal the financial impact of specific skills to help job seekers prioritize which ones to learn or improve.
*/
 
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25