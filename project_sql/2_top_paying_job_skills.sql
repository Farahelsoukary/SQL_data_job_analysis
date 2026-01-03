with top_paying_jobs AS (
SELECT
job_title,
-- skills_dim.skills,
job_id,
salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id 
WHERE salary_year_avg IS NOT NULL AND job_title LIKE '%Data Analyst%' AND job_work_from_home = TRUE
ORDER BY salary_year_avg DESC
LIMIT 10
)
SELECT top_paying_jobs.*,skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
ORDER BY top_paying_jobs.salary_year_avg DESC;