use job_market;
-- To view the table 
select * from job_market;
-- 1.What is the overall size of the job market dataset?
SELECT COUNT(*) AS total_job_postings
FROM job_market;
-- 2.Which job titles have the highest demand?
SELECT 
	job_title, 
	count(*) as job_posting 
from job_market
group by job_title
order by job_posting desc;
-- 3.Which locations have the highest number of opportunities?
select 
	location, 
    count(*) as job_opportunites 
from job_market
group by location
order by job_opportunites desc;
-- 4.What is the average salary by job title?
select 
	job_title,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by job_title
order by avg_salary desc;
-- 5. How does salary change with experience?
select 
	Experience_Years,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by Experience_Years
order by avg_salary asc;
-- 6.Which industries offer the highest salaries?
select
    industry,
    ROUND(AVG(salary_lpa), 2) as average_salary
from job_market
group by industry
order by average_salary desc;
-- 7.How do Remote, Hybrid and On-site jobs compare?
-- i will compare on basis of  job postings
select 
	work_mode,
    count(*) as job_postings
from job_market
group by Work_Mode
order by job_postings desc;
-- 8.How many opportunities are available for freshers?
select 
	count(*) as Fresher_opportunities
from job_market
where Experience_Years ='0-1';
-- 9. Which locations offer the best fresher opportunities?
select 
	location,
    count(*) as fresher_opportunities
from job_market
where Experience_Years ='0-1'
group by location;
-- 10. Which education qualifications are most requested?
select 
	education,
    count(*) as most_requested_education
from job_market
group by education
order by most_requested_education desc;
-- 11. Which job titles have the highest average salary?
select
	job_title,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by Job_Title
order by avg_salary desc;
-- 12.Which locations have the highest average salary?
select 
	location,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by location
order by avg_salary desc;
-- 13. What percentage of jobs are high-paying?
select
    round(
        (sum(case when salary_lpa >= 7 then 1 else 0 end) / count(*)) * 100,
        2
    ) as high_paying_job_percentage
from job_market;
-- 14.Which companies offer the most high-paying opportunities?
select 
	company,
	count(*) as high_paying_opportunities
from job_market
where Salary_LPA >=7
group by company
order by high_paying_opportunities desc;
-- 15. Which skills are most demanded?
select 
	Skills_Required,
    count(*) as most_demanded_skill
from job_market
group by Skills_Required
order by most_demanded_skill desc;
-- 16.Which skills are most demanded for Data Analyst roles?
select 
	Skills_Required,
    count(*) as most_demanded_skill
from job_market
where Job_Title="Data analyst"
group by Skills_Required
order by most_demanded_skill desc;
-- 17.Which skills are associated with higher salaries?
select 
	skills_required,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by Skills_Required
order by avg_salary desc;
--  18. Which skill combinations occur most frequently?
select
    skills_required,
    COUNT(*) as combination_count
from job_market
group by skills_required
order by combination_count desc
limit 10;
-- 19.Which industries have the strongest demand for analysts?
select 
	industry,
    count(*) as need_for_analyst
from job_market
where  job_title LIKE '%Analyst%'
group by Industry
order by need_for_analyst desc;
-- What skill combination provides the strongest career opportunity?
select 
	skills_required,
    count(*) as carrer_opportunity,
    round(avg(salary_lpa),2) as avg_salary
from job_market
group by Skills_Required
order by carrer_opportunity desc, avg_salary desc
limit 10






