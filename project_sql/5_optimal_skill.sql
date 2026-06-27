/*
Objective: Identify the most optimal skills to learn for Data Analysts 
           (Intersection of high demand and high average salary).

Implementation:
- Focus exclusively on remote positions.
- Filter for postings with explicitly specified salaries.
- Analyze both mention frequency (demand) and average salary.

Purpose: Provide strategic insights for career development by targeting skills that offer both job security and strong financial reward.
*/

WITH skills_demand AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills AS skill_name, 
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE 
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE 
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id, 
    skills_demand.skill_name,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id -- Fixed "skills_id" typo
ORDER BY 
    demand_count DESC, 
    average_salary DESC
LIMIT 25