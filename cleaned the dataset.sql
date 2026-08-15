use job_market;
RENAME TABLE job_market_intelligence_dataset_cleaned TO job_market2;
SELECT *
FROM job_market
WHERE salary_lpa IS NULL;
describe job_market;

-- check duplicate
SELECT 
	job_id,
    Job_Title,
    Company,
    Location,
    Industry,
    Salary_lpa,
    experience_years,
    education,
    employment_type,
    work_mode,
    skills_required,
    date_posted,
    COUNT(*) AS duplicate_count
FROM job_market
GROUP BY 
    job_id,
    Job_Title,
    Company,
    Location,
    Industry,
    Salary_lpa,
    experience_years,
    education,
    employment_type,
    work_mode,
    skills_required,
    date_posted
HAVING COUNT(*) > 1;
-- check invalid  values,
SELECT *
FROM job_market
WHERE Salary_lpa < 0
   OR Salary_lpa > 100;

SELECT *
FROM job_market
WHERE Experience_Years < 0
   OR Experience_Years > 40;

DESCRIBE job_market2;