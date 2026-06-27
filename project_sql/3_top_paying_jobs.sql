/*
Question: What are the top 5 most in-demand skills for data analysts across all job postings?

Implementation:
- Join the job postings table (similar inner join logic used in query 2).
- Aggregate and filter for the top 5 highest-demand skills.
- Purpose: Help job seekers identify the most valuable market skills.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5