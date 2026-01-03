SELECT
job_id,
job_title,
job_postings_fact.company_id,
company_dim.name AS company_name,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
job_work_from_home
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id 
WHERE salary_year_avg IS NOT NULL AND job_title LIKE '%Data Analyst%' AND job_work_from_home = TRUE
ORDER BY salary_year_avg DESC
LIMIT 10;