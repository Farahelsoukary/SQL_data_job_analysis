-- CREATE TABLE job_applied(
--     job_id INT,
--     application_sent_date DATE,
--     custom_resume Boolean,
--     resume_file_name VARCHAR(255),
--     cover_letter_sent Boolean,
--     cover_letter_file_name VARCHAR(255),
--     status VARCHAR(50)

-- );

-- INSERT INTO job_applied (job_id, application_sent_date, custom_resume, resume_file_name, cover_letter_sent, cover_letter_file_name, status) VALUES
-- (1, '2024-01-15', TRUE, 'resume_john_doe.pdf', TRUE, 'cover_letter_john_doe.pdf', 'Under Review'),
-- (2, '2024-02-20', FALSE, 'resume_jane_smith.pdf', FALSE, NULL, 'Applied'),
-- (3, '2024-03-05', TRUE, 'resume_alex_jones.pdf', TRUE, 'cover_letter_alex_jones.pdf', 'Interview Scheduled'),
-- (4, '2024-04-10', FALSE, 'resume_emma_brown.pdf', FALSE, NULL, 'Rejected'),
-- (5, '2024-05-12', TRUE, 'resume_michael_clark.pdf', TRUE, 'cover_letter_michael_clark.pdf', 'Offer Extended');

-- ALTER TABLE job_applied 
-- ADD COLUMN contact VARCHAR(50);

-- UPDATE job_applied
-- SET contact = 'Farah Mohsen'
-- WHERE job_id = 3;

-- UPDATE job_applied
-- SET contact = 'Ahmed Mohsen'
-- WHERE job_id = 2;

-- UPDATE job_applied
-- SET contact = 'Ahmed Mohamed'
-- WHERE job_id = 1;

-- UPDATE job_applied
-- SET contact = 'Mazen Mohsen'
-- WHERE job_id = 4;

-- UPDATE job_applied
-- SET contact = 'Mahmoud Saleh'
-- WHERE job_id = 5;

-- ALTER TABLE job_applied
-- RENAME COLUMN contact TO contact_name;

-- ALTER TABLE job_applied
-- ALTER COLUMN contact_name TYPE TEXT;

-- ALTER TABLE job_applied
-- DROP COLUMN contact_name;

--DROP TABLE job_applied;

-- Create company_dim table with primary key
-- Drop existing tables if they exist (fresh start)
-- DROP TABLE IF EXISTS skills_job_dim CASCADE;
-- DROP TABLE IF EXISTS job_postings_fact CASCADE;
-- DROP TABLE IF EXISTS skills_dim CASCADE;
-- DROP TABLE IF EXISTS company_dim CASCADE;

-- -- Create company_dim table
-- CREATE TABLE public.company_dim (
--     company_id INT PRIMARY KEY,
--     name TEXT,
--     link TEXT,
--     link_google TEXT,
--     thumbnail TEXT
-- );

-- -- Create skills_dim table
-- CREATE TABLE public.skills_dim (
--     skill_id INT PRIMARY KEY,
--     skills TEXT,
--     type TEXT
-- );

-- -- Create job_postings_fact table
-- CREATE TABLE public.job_postings_fact (
--     job_id INT PRIMARY KEY,
--     company_id INT,
--     job_title_short VARCHAR(255),
--     job_title TEXT,
--     job_location TEXT,
--     job_via TEXT,
--     job_schedule_type TEXT,
--     job_work_from_home BOOLEAN,
--     search_location TEXT,
--     job_posted_date TIMESTAMP,
--     job_no_degree_mention BOOLEAN,
--     job_health_insurance BOOLEAN,
--     job_country TEXT,
--     salary_rate TEXT,
--     salary_year_avg NUMERIC,
--     salary_hour_avg NUMERIC,
--     FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
-- );

-- -- Create skills_job_dim table
-- CREATE TABLE public.skills_job_dim (
--     job_id INT,
--     skill_id INT,
--     PRIMARY KEY (job_id, skill_id),
--     FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
--     FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
-- );

-- -- Set ownership
-- ALTER TABLE public.company_dim OWNER TO postgres;
-- ALTER TABLE public.skills_dim OWNER TO postgres;
-- ALTER TABLE public.job_postings_fact OWNER TO postgres;
-- ALTER TABLE public.skills_job_dim OWNER TO postgres;

-- -- Import data with CORRECT paths (using forward slashes)
-- COPY company_dim
-- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/company_dim.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- COPY skills_dim
-- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/skills_dim.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- COPY job_postings_fact
-- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/job_postings_fact.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- -- Import skills_job_dim with duplicate handling
-- CREATE TEMP TABLE skills_job_dim_temp (
--     job_id INT,
--     skill_id INT
-- );

-- COPY skills_job_dim_temp
-- FROM 'C:/Users/user/Downloads/SQL_data_job_analysis/csv_files/skills_job_dim.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

-- INSERT INTO skills_job_dim (job_id, skill_id)
-- SELECT DISTINCT job_id, skill_id
-- FROM skills_job_dim_temp;

-- DROP TABLE skills_job_dim_temp;

-- -- Create indexes
-- CREATE INDEX idx_company_id ON public.job_postings_fact (company_id);
-- CREATE INDEX idx_skill_id ON public.skills_job_dim (skill_id);
-- CREATE INDEX idx_job_id ON public.skills_job_dim (job_id);

-- -- Verify data (CORRECTED table name)
-- SELECT 'company_dim' as table_name, COUNT(*) as rows FROM company_dim
-- UNION ALL
-- SELECT 'skills_dim', COUNT(*) FROM skills_dim
-- UNION ALL
-- SELECT 'job_postings_fact', COUNT(*) FROM job_postings_fact
-- UNION ALL
-- SELECT 'skills_job_dim', COUNT(*) FROM skills_job_dim;

-- View sample data
SELECT * 
FROM 
   company_dim 
LIMIT 5;
SELECT * 
FROM 
   skills_dim 
LIMIT 5;
SELECT *
FROM 
   job_postings_fact 
LIMIT 5;
SELECT * 
FROM 
   skills_job_dim 
LIMIT 5;