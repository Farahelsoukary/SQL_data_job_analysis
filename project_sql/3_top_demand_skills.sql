with top_demand_skills AS(
    SELECT 
    COUNT(*) AS demand_count,
    skills_job_dim.skill_id
    FROM skills_job_dim
    LEFT JOIN job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
    WHERE job_postings_fact.job_title LIKE'%Data Analyst%' AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id 
)
SELECT
    top_demand_skills.skill_id,
    demand_count,
    skills_dim.skills
FROM top_demand_skills
INNER JOIN skills_dim ON top_demand_skills.skill_id=skills_dim.skill_id
ORDER BY demand_count DESC
LIMIT 10; 

-- OR

SELECT
    skills_dim.skills,
    COUNT(*) AS demand_count

FROM skills_job_dim
INNER JOIN job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE job_title LIKE'%Data Analyst%' AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 10;