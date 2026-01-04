with top_demand_skills AS(
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(*) AS demand_count

FROM skills_job_dim
INNER JOIN job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE job_title LIKE'%Data Analyst%' AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skill_id

), top_salary_skills AS(
    SELECT
        skills_dim.skill_id,
       ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
    FROM skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
    WHERE job_postings_fact.job_title LIKE'%Data Analyst%'  AND job_postings_fact.job_work_from_home = TRUE AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    
)
SELECT
    top_demand_skills.skills,
    top_demand_skills.demand_count,
    avg_salary
FROM top_demand_skills
INNER JOIN top_salary_skills ON top_demand_skills.skill_id=top_salary_skills.skill_id
WHERE demand_count >10
ORDER BY 
avg_salary DESC,
demand_count DESC
LIMIT 10;