use job_market;
-- 1.How many total job postings are there?
Select * from job_market;
select count(Job_Title) from job_market;
-- 2.How many unique companies?
Select * from job_market;
select count(distinct (company)) as unique_companies
 from  job_market;
-- 3.How many unique job titles?
select distinct(Job_Title) from job_market;
-- 4.How many locations?
select distinct(location) from job_market;
-- 5.Which job titles have the highest number of job postings?
select max(Job_Title)as Highest_Job_Posting from job_market;
-- 6.Which locations have the highest number of job opportunities?
select max(Location)as Most_prefered_job_location from job_market;
-- 7.What is the average salary for each job title?
select Job_Title,round(avg(Salary_lpa),2) as AVG_Salary from job_market
group by Job_Title;
-- 8.How does average salary change across experience levels?
select Experience_Years,round(avg(Salary_lpa),2) as average_salary from job_market
group by Experience_Years;
-- 9.Which industries have the highest average salary?
select industry,avg(salary_lpa)as avg_salary from job_market
group by industry
order by avg_salary desc
limit 5;
-- 10.Compare average salary and job volume for Remote, Hybrid, and On-site jobs.
select work_mode,round(avg(salary_lpa), 2) as avg_salary, count(*) as job_volume from job_market
group by work_mode
order by avg_salary desc;
-- 11.How many jobs require 0–1 years of experience?
select count(Job_Title)as total_jobs from job_market where Experience_Years = '0-1';
-- 12.What is the average salary for 0–1 year experience jobs by location?
select location,round(avg(Salary_LPA),2)as avg_salary from job_market where Experience_Years='0-1'
group by location;
-- 13.Which education qualifications appear most frequently in job postings?
select Education, count(*) as Job_Postings from job_market
where Education is not null
group by Education
 ORDER BY job_postings DESC;
 -- Top-paying job titles
 -- 14. Which job titles have the highest average salary?
 select Job_Title ,round(avg(salary_lpa),2) as avg_salary from job_market
 group by Job_Title
 order by avg_salary desc
 limit 5;
-- Highest-paying locations
-- 15. Which locations provide the highest average salary?
select location, round(avg(salary_lpa),2) as avg_salary, count(*) as job_posting from job_market
group by location
order by avg_salary desc
limit 5;
/* 16. Salary by experience
Create:
Experience	Job Count	Avg Salary
0–1		
1–2		
2–3		
3–5
*/
select experience_years,count(*) as Job_count, round(avg(salary_lpa),2) as avg_salary from job_market
group by experience_years
order by experience_years asc;

/* 17. High-paying jobs
Define a high-paying job as:
Salary ≥ 7 LPA
Then find:
Number of high-paying jobs
Top companies
Top locations
Most common job titles
Most common skills
*/

select count(*) as high_paying_job from job_market
where salary_lpa >= 7;
-- top Companies
select company,count(*) as high_paying_job from job_market
where salary_lpa >= 7
group by company;
-- Top Locations
select location,count(*) as high_paying_job from job_market
where salary_lpa >= 7
group by location;
-- Most common job titles
select job_title,count(*) as high_paying_job from job_market
where salary_lpa >= 7
group by job_title;
-- Most common skills
select skills_required,count(*) as job_count from job_market
where salary_lpa >= 7
group by skills_required
order by job_count;
 /*  18. Entry-level opportunity score
Identify locations where:
0–1 year jobs are high AND average salary is relatively high.
*/
select 
	location ,
	count(*) as entry_level_jobs, 
	round(avg(salary_lpa),2) as  avg_salary,
    round(count(*) * avg(salary_lpa),2) as opportunity_score
from job_market 
where experience_years='0-1' 
group by location
having count(*) >=10
order by opportunity_score desc;

-- 19.Which skills appear in the highest number of job postings?
SELECT
    skills_required,
    COUNT(*) AS job_posting_count
FROM job_market
GROUP BY skills_required
ORDER BY job_posting_count DESC
LIMIT 10;
-- 20.What are the most demanded skills for Data Analyst jobs?
select skills_required, count(*) as job_postings from job_market
where job_title='Data Analyst' 
group by skills_required
order by job_postings desc;
-- What are the most demanded skills for Business Analyst jobs?
select skills_required, count(*) as job_postings from job_market
where job_title='Business Analyst' 
group by skills_required
order by job_postings desc;
--  What are the most demanded skills for MIS Executive jobs?
select skills_required, count(*) as job_postings from job_market
where job_title='MIS Executive' 
group by skills_required
order by job_postings desc;
-- What are the most demanded skills for BI Analyst jobs?
select skills_required, count(*) as job_postings from job_market
where job_title='BI Analyst' 
group by skills_required
order by job_postings desc;
-- 21.What is the average salary of jobs requiring each skill?
SELECT
    skills_required,
    ROUND(AVG(salary_lpa), 2) AS average_salary
FROM job_market
GROUP BY skills_required
ORDER BY average_salary DESC;





