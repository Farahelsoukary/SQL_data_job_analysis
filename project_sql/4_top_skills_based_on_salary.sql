SELECT
    skills_dim.skills,
   ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
FROM skills_job_dim
INNER JOIN job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE job_postings_fact.job_title LIKE'%Data Analyst%'  AND job_postings_fact.job_work_from_home = TRUE AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 10;
