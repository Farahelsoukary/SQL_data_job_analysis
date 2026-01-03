-- -- CREATE TABLE job_applied(
-- --     job_id INT,
-- --     application_sent_date DATE,
-- --     custom_resume Boolean,
-- --     resume_file_name VARCHAR(255),
-- --     cover_letter_sent Boolean,
-- --     cover_letter_file_name VARCHAR(255),
-- --     status VARCHAR(50)
-- -- );

-- -- INSERT INTO job_applied (job_id, application_sent_date, custom_resume, resume_file_name, cover_letter_sent, cover_letter_file_name, status) VALUES
-- -- (1, '2024-01-15', TRUE, 'resume_john_doe.pdf', TRUE, 'cover_letter_john_doe.pdf', 'Under Review'),
-- -- (2, '2024-02-20', FALSE, 'resume_jane_smith.pdf', FALSE, NULL, 'Applied'),
-- -- (3, '2024-03-05', TRUE, 'resume_alex_jones.pdf', TRUE, 'cover_letter_alex_jones.pdf', 'Interview Scheduled'),
-- -- (4, '2024-04-10', FALSE, 'resume_emma_brown.pdf', FALSE, NULL, 'Rejected'),
-- -- (5, '2024-05-12', TRUE, 'resume_michael_clark.pdf', TRUE, 'cover_letter_michael_clark.pdf', 'Offer Extended');

-- -- ALTER TABLE job_applied 
-- -- ADD COLUMN contact VARCHAR(50);

-- -- UPDATE job_applied
-- -- SET contact = 'Farah Mohsen'
-- -- WHERE job_id = 3;

-- -- UPDATE job_applied
-- -- SET contact = 'Ahmed Mohsen'
-- -- WHERE job_id = 2;

-- -- UPDATE job_applied
-- -- SET contact = 'Ahmed Mohamed'
-- -- WHERE job_id = 1;

-- -- UPDATE job_applied
-- -- SET contact = 'Mazen Mohsen'
-- -- WHERE job_id = 4;

-- -- UPDATE job_applied
-- -- SET contact = 'Mahmoud Saleh'
-- -- WHERE job_id = 5;

-- -- ALTER TABLE job_applied
-- -- RENAME COLUMN contact TO contact_name;

-- -- ALTER TABLE job_applied
-- -- ALTER COLUMN contact_name TYPE TEXT;

-- -- ALTER TABLE job_applied
-- -- DROP COLUMN contact_name;

-- --DROP TABLE job_applied;

-- -- Create company_dim table with primary key
-- -- Drop existing tables if they exist (fresh start)
-- -- DROP TABLE IF EXISTS skills_job_dim CASCADE;
-- -- DROP TABLE IF EXISTS job_postings_fact CASCADE;
-- -- DROP TABLE IF EXISTS skills_dim CASCADE;
-- -- DROP TABLE IF EXISTS company_dim CASCADE;

-- -- -- Create company_dim table
-- -- CREATE TABLE public.company_dim (
-- --     company_id INT PRIMARY KEY,
-- --     name TEXT,
-- --     link TEXT,
-- --     link_google TEXT,
-- --     thumbnail TEXT
-- -- );

-- -- -- Create skills_dim table
-- -- CREATE TABLE public.skills_dim (
-- --     skill_id INT PRIMARY KEY,
-- --     skills TEXT,
-- --     type TEXT
-- -- );

-- -- -- Create job_postings_fact table
-- -- CREATE TABLE public.job_postings_fact (
-- --     job_id INT PRIMARY KEY,
-- --     company_id INT,
-- --     job_title_short VARCHAR(255),
-- --     job_title TEXT,
-- --     job_location TEXT,
-- --     job_via TEXT,
-- --     job_schedule_type TEXT,
-- --     job_work_from_home BOOLEAN,
-- --     search_location TEXT,
-- --     job_posted_date TIMESTAMP,
-- --     job_no_degree_mention BOOLEAN,
-- --     job_health_insurance BOOLEAN,
-- --     job_country TEXT,
-- --     salary_rate TEXT,
-- --     salary_year_avg NUMERIC,
-- --     salary_hour_avg NUMERIC,
-- --     FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
-- -- );

-- -- -- Create skills_job_dim table
-- -- CREATE TABLE public.skills_job_dim (
-- --     job_id INT,
-- --     skill_id INT,
-- --     PRIMARY KEY (job_id, skill_id),
-- --     FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
-- --     FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
-- -- );

-- -- -- Set ownership
-- -- ALTER TABLE public.company_dim OWNER TO postgres;
-- -- ALTER TABLE public.skills_dim OWNER TO postgres;
-- -- ALTER TABLE public.job_postings_fact OWNER TO postgres;
-- -- ALTER TABLE public.skills_job_dim OWNER TO postgres;

-- -- -- Import data with CORRECT paths (using forward slashes)
-- -- COPY company_dim
-- -- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/company_dim.csv'
-- -- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- -- COPY skills_dim
-- -- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/skills_dim.csv'
-- -- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- -- COPY job_postings_fact
-- -- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/job_postings_fact.csv'
-- -- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- -- -- Import skills_job_dim with duplicate handling
-- -- CREATE TEMP TABLE skills_job_dim_temp (
-- --     job_id INT,
-- --     skill_id INT
-- -- );

-- -- COPY skills_job_dim_temp
-- -- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/skills_job_dim.csv'
-- -- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- -- INSERT INTO skills_job_dim (job_id, skill_id)
-- -- SELECT DISTINCT job_id, skill_id
-- -- FROM skills_job_dim_temp;

-- -- DROP TABLE skills_job_dim_temp;

-- -- -- Create indexes
-- -- CREATE INDEX idx_company_id ON public.job_postings_fact (company_id);
-- -- CREATE INDEX idx_skill_id ON public.skills_job_dim (skill_id);
-- -- CREATE INDEX idx_job_id ON public.skills_job_dim (job_id);

-- -- -- Verify data (CORRECTED table name)
-- -- SELECT 'company_dim' as table_name, COUNT(*) as rows FROM company_dim
-- -- UNION ALL
-- -- SELECT 'skills_dim', COUNT(*) FROM skills_dim
-- -- UNION ALL
-- -- SELECT 'job_postings_fact', COUNT(*) FROM job_postings_fact
-- -- UNION ALL
-- -- SELECT 'skills_job_dim', COUNT(*) FROM skills_job_dim;

-- -- View sample data
-- -- SELECT * 
-- -- FROM 
-- --    company_dim 
-- -- LIMIT 5;
-- -- SELECT * 
-- -- FROM 
-- --    skills_dim 
-- -- LIMIT 5;
-- -- SELECT *
-- -- FROM 
-- --    job_postings_fact 
-- -- LIMIT 5;
-- -- SELECT * 
-- -- FROM 
-- --    skills_job_dim 
-- -- LIMIT 5;

-- -- ::used for casting 
-- -- EXTRACT function to get specific parts of date/time used the selection below
-- -- SELECT 
-- --    COUNT(job_id) AS total_jobs,
-- -- --    job_posted_date,
-- -- --    job_posted_date::DATE AS job_date,
-- -- --    job_posted_date AT TIME ZONE 'UTC' AS job_time,
-- -- --    EXTRACT(YEAR FROM job_posted_date) AS job_year,
-- --    EXTRACT(MONTH FROM job_posted_date) AS job_month
-- -- FROM 
-- --    job_postings_fact 
-- -- WHERE
-- --     job_title_short ILIKE '%Data Analyst%'
-- -- GROUP BY 
-- --    job_month
-- -- ORDER BY total_jobs DESC;
-- CREATE TABLE public.january_2023_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- AND EXTRACT(YEAR FROM job_posted_date) = 2023;



-- CREATE TABLE public.february_2023_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 2
-- AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- CREATE TABLE public.march_2023_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 3
-- AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- SELECT *
-- FROM public.march_2023_jobs

-- -- DROP TABLE february_2023_jobs;

-- -- SELECT 
-- --    CASE 
-- --       WHEN column_name = value THEN 'Description'
-- --       WHEN column_name BETWEEN value AND value THEN 'description'
-- --       ELSE 'Not Specified'
-- --    END AS column_description
-- -- FROM
-- --     table_name;

-- SELECT
--    COUNT(job_id) AS total_jobs,
--     CASE
--         WHEN job_location ILIKE '%Anywhere%' THEN 'Remote'
--         WHEN job_location ILIKE '%New York, NY%' THEN 'Local'
--         ELSE 'Onsite'
--     END AS job_location_type
-- FROM 
--     job_postings_fact
-- GROUP BY job_location_type

-- -- subqueries query nested inside a lagerer query

-- SELECT *
-- FROM(--subquery starts here
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) =4

-- ) AS january_jobs --subquery ends here

-- SELECT 
--    company_id,
--    job_no_degree_mention
-- FROM
--     job_postings_fact
--     WHERE company_id IN (
--         SELECT company_id
--         FROM company_dim
--         WHERE job_no_degree_mention = TRUE
--     );

-- -- JOINs combine rows from two or more tables based on a related column between them

-- SELECT 
--     job_postings_fact.company_id,
--     job_postings_fact.job_no_degree_mention
-- FROM  job_postings_fact
-- INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
-- WHERE  job_no_degree_mention = TRUE ;

-- SELECT 
--     company_id,
--     name
-- FROM
--     company_dim
-- WHERE company_id IN (
--     SELECT company_id
--     FROM job_postings_fact
--     WHERE job_no_degree_mention = TRUE
--     ORDER BY company_id
-- ); 

-- /*
-- Subqueries and CTEs (Common Table Expressions) can often be used interchangeably to achieve similar results. 
-- However, there are some differences in their usage and readability.
-- where subqueries are simple and executed first then results passed to the outer query and used once,
-- CTEs are better for complex queries or when the same result set is needed multiple times.
-- */

-- SELECT *
-- FROM(--subquery starts here
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) =4

-- ) AS january_jobs --subquery ends here

-- WITH january_jobs AS (--CTE starts here
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 4
-- )
-- SELECT *
-- FROM january_jobs;--CTE ends here

-- SELECT name
-- FROM company_dim
-- WHERE company_id IN (
--     SELECT company_id
--     FROM job_postings_fact
--     WHERE job_no_degree_mention = true
--     ORDER BY company_id

-- );

-- WITH company_job_counts AS (
--     SELECT 
--         company_id,
--         COUNT(*) AS total_jobs
--     FROM 
--         job_postings_fact
--     GROUP BY company_id
-- )
-- -- SELECT name
-- -- FROM company_dim
-- -- LEFT JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id


-- SELECT company_dim.name AS company_name,
--        company_job_counts.total_jobs
-- FROM company_dim
-- LEFT JOIN company_job_counts ON company_job_counts.company_id = company_dim.company_id
-- ORDER BY company_job_counts.total_jobs DESC;

-- with skill_job_counts AS (
--     SELECT 
--         skill_id,
--         COUNT(*) AS total_jobs
--     FROM skills_job_dim
--     GROUP BY skill_id
-- )
-- SELECT skills_dim.skills AS skill_name,
--        skill_job_counts.total_jobs
-- FROM skills_dim
-- LEFT JOIN skill_job_counts ON skills_dim.skill_id = skill_job_counts.skill_id






-- WITH remote_job_skills AS (
--     SELECT 
--     skill_id ,
--     COUNT(*) AS skill_count
--     FROM skills_job_dim AS skills_to_jobs
--     INNER JOIN job_postings_fact AS job_postings ON skills_to_jobs.job_id = job_postings.job_id
--     WHERE 
--     job_postings.job_work_from_home = TRUE
--     GROUP BY skill_id
-- )
-- SELECT 
-- skills_dim.skills AS skill_name,
-- skill_count,
-- skills_dim.skill_id
-- FROM remote_job_skills
-- INNER JOIN skills_dim ON skills_dim.skill_id = remote_job_skills.skill_id
-- ORDER BY skill_count DESC
-- LIMIT 5

-- -- UNION and UNION ALL operators to combine Results from multiple SELECT statements
-- SELECT
-- combine_jobs.job_title_short,
-- combine_jobs.job_location,
-- combine_jobs.job_posted_date ::DATE AS posted_date

-- FROM(
--     SELECT *
--     FROM january_2023_jobs

--     UNION ALL

--     SELECT *
--     FROM february_2023_jobs

--     UNION ALL

--     SELECT *
--     FROM march_2023_jobs
-- ) AS combine_jobs
-- WHERE 
-- combine_jobs.salary_year_avg > 70000
-- --  while UNION ALL includes all duplicates from the combined result set and return all rows.


-- -- Problem: Get employee name, department, manager name, and salary.

-- -- Tables:
-- --   employees (id, name, salary, department_id, manager_id)
-- --   departments (id, name)
-- --   managers (id, name)

-- -- SELECT
-- -- e.name AS employee_name,
-- -- d.name AS department_name,
-- -- m.name AS manager_name,
-- -- e.salary AS employee_salary
-- -- FROM employees e
-- -- INNER JOIN departments d ON e.department_id = d.id
-- -- INNER JOIN managers m ON e.manager_id = m.id;


-- -- SELECT
-- -- name,
-- -- department,
-- -- rank() OVER (PARTITION BY department ORDER BY employees.salary DESC) as salary_rank,
-- -- ROW_NUMBER() OVER (PARTITION BY department ORDER BY employees.salary DESC) as row_number,
-- -- LAG(salary) OVER (PARTITION BY department ORDER BY employees.salary DESC) AS previous_salary
-- -- FROM employees;

-- -- SELECT
-- -- salary,
-- -- name,
-- -- CASE
-- --     WHEN salary<50000 THEN "C"
-- --     WHEN salary BETWEEN 50000 AND 100000 THEN "B"
-- --     ELSE "A"

-- -- END AS salary_grade
-- -- FROM employees;

-- -- SELECT DISTINCT department.name AS department_name
-- -- FROM employees
-- -- INNER JOIN department ON employees.department_id = department.id;

-- -- SELECT 
-- -- MAX(salary) AS highest_salary
-- -- FROM employees;
-- -- ORDER BY highest_salary DESC
-- -- LIMIT 5 OFFSET 5;

-- -- SELECT
-- -- name
-- -- FROM employees
-- -- WHERE Lower(name) LIKE "%john%"

-- -- SELECT name
-- -- FROM employees
-- -- WHERE extract(year FROM hire_date) = 2024;

-- -- SELECT 
-- -- name,salary,department
-- -- FROM employees
-- -- WHERE salary>7000

-- -- UNION

-- -- SELECT
-- -- name,salary,department
-- -- FROM managers
-- -- WHERE department = "IT"

-- SELECT 
-- percentile_cont(0.25) WITHIN GROUP (ORDER BY salary) AS salary_25th_percentile,
-- percentile_cont(0.50) WITHIN GROUP(ORDER BY salary) AS salary_50th_percentile,
-- percentile_cont(0.70) WITHIN GROUP(ORDER BY salary) AS salary_70th_percentile
-- FROM employees;

-- with jobs AS (
-- SELECT
-- skills_job_dim.skill_id,
-- count(*) AS remote_jobs_count
-- FROM skills_job_dim
-- INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
-- WHERE job_work_from_home = TRUE
-- GROUP BY skills_job_dim.skill_id
-- )
-- SELECT * FROM jobs