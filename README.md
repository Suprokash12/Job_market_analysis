# Job Market Intelligence Analysis Using SQL

## 1. Project Overview

This project analyzes a **Job Market Intelligence dataset** using SQL to identify trends in job demand, salaries, experience requirements, education qualifications, work modes, locations, industries, and required skills.

The goal is to transform raw job-posting data into **actionable insights for job seekers, recruiters, and career decision-makers**.

The analysis focuses particularly on analyst-oriented roles such as:

* Data Analyst
* Business Analyst
* BI Analyst
* MIS Executive

The project also investigates the relationship between **skills, experience, job demand, and salary** to identify which skill combinations can provide stronger career opportunities.

---

## 2. Business Objective / Questions

The main business objective is to understand:

> **Where are the strongest employment opportunities, what skills are employers demanding, and which combinations of skills, experience, location, and job type offer the best career potential?**

### Key Business Questions

1. What is the overall size of the job market dataset?
2. How many unique companies are hiring?
3. Which job titles have the highest demand?
4. Which locations have the highest number of opportunities?
5. What is the average salary for each job title?
6. How does salary change with experience?
7. Which industries offer the highest salaries?
8. How do Remote, Hybrid, and On-site jobs compare?
9. How many opportunities are available for freshers?
10. Which locations offer the strongest fresher opportunities?
11. Which education qualifications are most requested?
12. Which job titles have the highest average salary?
13. Which locations offer the highest average salary?
14. What percentage of jobs are high-paying?
15. Which companies offer the most high-paying opportunities?
16. Which skills are most demanded?
17. Which skills are most demanded for Data Analyst roles?
18. Which skills are associated with higher salaries?
19. Which skill combinations occur most frequently?
20. Which industries have the strongest demand for analysts?
21. Which skill combinations provide the strongest career opportunities?

---

# 3. Dataset Description

The analysis is based on a job-market dataset containing job-posting information.

### Main Table

`job_market`

### Important Columns

| Column             | Description                                  |
| ------------------ | -------------------------------------------- |
| `job_id`           | Unique identifier for the job posting        |
| `job_title`        | Title of the advertised position             |
| `company`          | Hiring organization                          |
| `location`         | Job location                                 |
| `industry`         | Industry associated with the position        |
| `salary_lpa`       | Salary expressed in LPA                      |
| `experience_years` | Required experience level                    |
| `education`        | Required/preferred educational qualification |
| `employment_type`  | Type of employment                           |
| `work_mode`        | Remote, Hybrid, or On-site                   |
| `skills_required`  | Skills requested by the employer             |
| `date_posted`      | Date the job was posted                      |

### Experience Categories

The dataset uses experience ranges such as:

```text
0-1
1-2
2-3
3-5
```

The `0-1` category is particularly important because it represents **entry-level/fresher opportunities**.

### Salary Definition

For this project, a job is classified as **high-paying** when:

```text
Salary >= 7 LPA
```

This threshold is used consistently in the high-paying-job analysis.

---

# 4. Tools & Technologies

## Database

* MySQL
* SQL

## SQL Concepts Used

The project demonstrates:

* `SELECT`
* `COUNT()`
* `COUNT(DISTINCT)`
* `AVG()`
* `SUM()`
* `ROUND()`
* `MAX()`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `HAVING`
* `CASE`
* `WHERE`
* `LIKE`
* `DISTINCT`
* Aggregate functions
* Conditional aggregation

## Data Analysis Areas

* Job demand
* Salary analysis
* Experience analysis
* Geographic analysis
* Industry analysis
* Work-mode analysis
* Fresher opportunities
* Education requirements
* Skill-demand analysis
* High-paying jobs
* Career opportunity scoring

---

# 5. Data Cleaning

Before performing the analysis, the dataset was checked for common data-quality issues.

The cleaning script includes checks for:

### Missing Salary Values

```sql
SELECT *
FROM job_market
WHERE salary_lpa IS NULL;
```

This identifies job postings where salary information is unavailable.

### Duplicate Records

The project checks for duplicate job records using multiple identifying fields:

```sql
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
```

### Salary Validation

The dataset is checked for unrealistic salary values:

```sql
SELECT *
FROM job_market
WHERE Salary_lpa < 0
   OR Salary_lpa > 100;
```

This helps identify potentially invalid salary records.

### Experience Validation

Experience values are also checked:

```sql
SELECT *
FROM job_market
WHERE Experience_Years < 0
   OR Experience_Years > 40;
```

### Schema Validation

The project uses:

```sql
DESCRIBE job_market;
```

to verify column names, data types, and table structure.

---

# 6. SQL Analysis

## 6.1 Overall Job Market Size

```sql
SELECT COUNT(*) AS total_job_postings
FROM job_market;
```

This determines the total number of job postings available in the dataset.

### Business Use

This metric establishes the overall scale of the analyzed job market.

---

## 6.2 Most In-Demand Job Titles

```sql
SELECT 
    job_title,
    COUNT(*) AS job_posting
FROM job_market
GROUP BY job_title
ORDER BY job_posting DESC;
```

This identifies which roles have the greatest number of job postings.

### Business Use

Job seekers can prioritize roles with stronger market demand.

Recruiters can use this information to understand which job categories are most active.

---

## 6.3 Locations With the Highest Job Opportunities

```sql
SELECT 
    location,
    COUNT(*) AS job_opportunities
FROM job_market
GROUP BY location
ORDER BY job_opportunities DESC;
```

### Business Use

This identifies geographic markets with the highest concentration of opportunities.

It can help job seekers decide where to focus applications or whether relocation may provide additional opportunities.

---

## 6.4 Average Salary by Job Title

```sql
SELECT 
    job_title,
    ROUND(AVG(salary_lpa), 2) AS avg_salary
FROM job_market
GROUP BY job_title
ORDER BY avg_salary DESC;
```

### Business Use

This allows comparison of earning potential across different career paths.

For example, an analyst can compare:

* Data Analyst
* Business Analyst
* BI Analyst
* MIS Executive

and evaluate salary differences.

---

## 6.5 Salary vs Experience

```sql
SELECT 
    experience_years,
    ROUND(AVG(salary_lpa), 2) AS avg_salary
FROM job_market
GROUP BY experience_years
ORDER BY avg_salary ASC;
```

### Business Use

This analysis evaluates whether salary increases as required experience increases.

It provides insight into the potential financial return of gaining additional professional experience.

---

## 6.6 Highest-Paying Industries

```sql
SELECT
    industry,
    ROUND(AVG(salary_lpa), 2) AS average_salary
FROM job_market
GROUP BY industry
ORDER BY average_salary DESC;
```

### Business Use

Job seekers can identify industries with stronger compensation potential.

Companies can also benchmark compensation against other industries.

---

## 6.7 Remote vs Hybrid vs On-site

```sql
SELECT 
    work_mode,
    COUNT(*) AS job_postings
FROM job_market
GROUP BY work_mode
ORDER BY job_postings DESC;
```

The project also includes a more useful comparison of **salary and job volume**:

```sql
SELECT 
    work_mode,
    ROUND(AVG(salary_lpa), 2) AS avg_salary,
    COUNT(*) AS job_volume
FROM job_market
GROUP BY work_mode
ORDER BY avg_salary DESC;
```

### Business Use

This allows comparison between:

* Job availability
* Average compensation
* Work flexibility

This is more informative than looking at job volume alone.

---

## 6.8 Fresher Opportunities

Freshers are defined as candidates requiring:

```text
0-1 years of experience
```

Query:

```sql
SELECT COUNT(*) AS fresher_opportunities
FROM job_market
WHERE experience_years = '0-1';
```

### Business Use

This is one of the most important metrics for entry-level candidates.

It measures how accessible the market is for candidates with little or no professional experience.

---

## 6.9 Best Locations for Freshers

```sql
SELECT 
    location,
    COUNT(*) AS fresher_opportunities
FROM job_market
WHERE experience_years = '0-1'
GROUP BY location
ORDER BY fresher_opportunities DESC;
```

### Business Use

This identifies locations where entry-level candidates have the largest number of opportunities.

---

## 6.10 Most Requested Education Qualifications

```sql
SELECT 
    education,
    COUNT(*) AS most_requested_education
FROM job_market
WHERE education IS NOT NULL
GROUP BY education
ORDER BY most_requested_education DESC;
```

### Business Use

This helps candidates understand which educational qualifications are most commonly requested by employers.

---

## 6.11 Highest-Paying Job Titles

```sql
SELECT
    job_title,
    ROUND(AVG(salary_lpa), 2) AS avg_salary
FROM job_market
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 5;
```

### Business Use

This identifies the top-paying career paths in the dataset.

---

## 6.12 Highest-Paying Locations

```sql
SELECT 
    location,
    ROUND(AVG(salary_lpa), 2) AS avg_salary,
    COUNT(*) AS job_posting
FROM job_market
GROUP BY location
ORDER BY avg_salary DESC
LIMIT 5;
```

### Important Analytical Point

Salary alone should not determine whether a location is attractive.

A location with a very high average salary but only a few job postings may provide fewer practical opportunities than a location with slightly lower salaries and much higher job volume.

Therefore, **salary + job volume** should be evaluated together.

---

# 7. High-Paying Job Analysis

A high-paying job is defined as:

```text
Salary >= 7 LPA
```

## Number of High-Paying Jobs

```sql
SELECT COUNT(*) AS high_paying_jobs
FROM job_market
WHERE salary_lpa >= 7;
```

## Percentage of High-Paying Jobs

```sql
SELECT
    ROUND(
        (SUM(CASE WHEN salary_lpa >= 7 THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS high_paying_job_percentage
FROM job_market;
```

This provides a better measure than simply counting high-paying jobs because it normalizes the result against total market size.

---

## Companies With the Most High-Paying Jobs

```sql
SELECT 
    company,
    COUNT(*) AS high_paying_opportunities
FROM job_market
WHERE salary_lpa >= 7
GROUP BY company
ORDER BY high_paying_opportunities DESC;
```

### Business Use

This identifies companies that appear frequently among higher-paying opportunities.

---

## Locations With the Most High-Paying Jobs

```sql
SELECT 
    location,
    COUNT(*) AS high_paying_jobs
FROM job_market
WHERE salary_lpa >= 7
GROUP BY location
ORDER BY high_paying_jobs DESC;
```

### Business Use

This identifies geographic markets with greater availability of higher-paying roles.

---

## Most Common High-Paying Job Titles

```sql
SELECT 
    job_title,
    COUNT(*) AS high_paying_jobs
FROM job_market
WHERE salary_lpa >= 7
GROUP BY job_title
ORDER BY high_paying_jobs DESC;
```

This identifies which career paths appear most frequently among higher-paying positions.

---

# 8. Skill Demand Analysis

One of the most valuable parts of this project is the skill analysis.

## Most Demanded Skills

```sql
SELECT
    skills_required,
    COUNT(*) AS job_posting_count
FROM job_market
GROUP BY skills_required
ORDER BY job_posting_count DESC
LIMIT 10;
```

This identifies the most frequently occurring skill combinations.

---

## Skills for Data Analyst Roles

```sql
SELECT
    skills_required,
    COUNT(*) AS job_postings
FROM job_market
WHERE job_title = 'Data Analyst'
GROUP BY skills_required
ORDER BY job_postings DESC;
```

### Business Use

This analysis is particularly useful for someone targeting Data Analyst positions because it reveals what employers are requesting in Data Analyst job postings.

---

## Skills for Business Analyst Roles

```sql
SELECT
    skills_required,
    COUNT(*) AS job_postings
FROM job_market
WHERE job_title = 'Business Analyst'
GROUP BY skills_required
ORDER BY job_postings DESC;
```

---

## Skills for MIS Executive Roles

```sql
SELECT
    skills_required,
    COUNT(*) AS job_postings
FROM job_market
WHERE job_title = 'MIS Executive'
GROUP BY skills_required
ORDER BY job_postings DESC;
```

---

## Skills for BI Analyst Roles

```sql
SELECT
    skills_required,
    COUNT(*) AS job_postings
FROM job_market
WHERE job_title = 'BI Analyst'
GROUP BY skills_required
ORDER BY job_postings DESC;
```

---

# 9. Skills Associated With Higher Salaries

```sql
SELECT
    skills_required,
    ROUND(AVG(salary_lpa), 2) AS average_salary
FROM job_market
GROUP BY skills_required
ORDER BY average_salary DESC;
```

This analysis connects **skills with compensation**.

### Business Interpretation

A skill should not be considered valuable simply because it appears frequently.

A stronger career strategy considers both:

```text
Skill Demand
+
Salary Association
```

A skill combination that appears frequently and is associated with relatively high salaries may represent a stronger career investment.

---

# 10. Skill Combination Analysis

The project also identifies frequently occurring combinations:

```sql
SELECT
    skills_required,
    COUNT(*) AS combination_count
FROM job_market
GROUP BY skills_required
ORDER BY combination_count DESC
LIMIT 10;
```

This is useful because employers frequently request combinations of skills rather than a single technical skill.

For example, an analyst may need a combination of:

```text
SQL
+
Excel
+
Power BI
+
Data Visualization
```

rather than only one of these skills.

---

# 11. Analyst Industry Demand

```sql
SELECT 
    industry,
    COUNT(*) AS need_for_analyst
FROM job_market
WHERE job_title LIKE '%Analyst%'
GROUP BY industry
ORDER BY need_for_analyst DESC;
```

### Business Use

This identifies industries with strong demand for analyst-oriented roles.

Potential use cases include:

* Career targeting
* Industry switching
* Recruitment strategy
* Workforce planning

---

# 12. Career Opportunity Score

The project introduces an opportunity score for entry-level roles:

```sql
SELECT 
    location,
    COUNT(*) AS entry_level_jobs, 
    ROUND(AVG(salary_lpa), 2) AS avg_salary,
    ROUND(COUNT(*) * AVG(salary_lpa), 2) AS opportunity_score
FROM job_market 
WHERE experience_years = '0-1'
GROUP BY location
HAVING COUNT(*) >= 10
ORDER BY opportunity_score DESC;
```

### Formula

```text
Opportunity Score
=
Entry-Level Job Count × Average Salary
```

### Why This Is Useful

Instead of selecting a location based only on salary, the score considers both:

* Number of entry-level opportunities
* Average salary

A location with many entry-level jobs and competitive salaries may therefore rank higher.

### Important Limitation

This is a custom analytical metric rather than a standardized labor-market measure.

For a production analysis, the score could be improved by incorporating:

* Cost of living
* Competition
* Application-to-interview ratio
* Industry diversity
* Remote opportunities
* Salary distribution

---

# 13. Key Insights

The SQL analysis is designed to answer several important business questions.

### Insight 1 — Job Demand Is Not the Same as Salary

A role can have a large number of job postings but a lower average salary.

Therefore, job seekers should evaluate both:

```text
Demand + Compensation
```

rather than focusing on only one metric.

---

### Insight 2 — Experience Is an Important Salary Driver

The project compares average salaries across experience levels.

This helps determine whether increased experience is associated with increased compensation.

For candidates starting their careers, this provides a useful long-term career perspective.

---

### Insight 3 — Entry-Level Opportunities Need Separate Analysis

The overall job market can look attractive while entry-level opportunities remain limited.

Therefore, filtering for:

```text
Experience = 0-1 years
```

provides a much more realistic view for fresh graduates and junior candidates.

---

### Insight 4 — Location Matters

The project analyzes both:

* Number of jobs by location
* Average salary by location

This allows the difference between **job availability** and **salary attractiveness** to be evaluated.

---

### Insight 5 — Skills Are a Major Career Differentiator

The skill analysis connects employer requirements with salary.

Rather than learning skills randomly, candidates can prioritize skills based on:

```text
Market Demand
+
Salary Potential
+
Target Job Role
```

---

### Insight 6 — High-Paying Jobs Can Be Analyzed Separately

Using the ₹7 LPA threshold makes it possible to identify:

* Companies with high-paying roles
* Locations with high-paying roles
* Job titles associated with higher salaries
* Skill combinations appearing in high-paying jobs

This provides a more targeted view of the upper segment of the market.

---

# 14. Business Decisions / Recommendations

## Decision 1 — Build Skills Based on Market Demand

Job seekers should prioritize skills that appear frequently in relevant job postings.

For a Data Analyst career path, the strongest approach is to identify the most frequently requested skill combinations specifically for Data Analyst roles rather than relying on generic skill lists.

### Recommended Strategy

```text
Job Market Data
      ↓
Identify Data Analyst Skills
      ↓
Rank Skill Demand
      ↓
Compare Salary Association
      ↓
Prioritize Learning
```

---

## Decision 2 — Do Not Choose a Location Based Only on Salary

A high average salary does not automatically mean a better job market.

Candidates should evaluate:

```text
Job Volume
+
Average Salary
+
Entry-Level Opportunities
```

The opportunity-score analysis is designed to support this decision.

---

## Decision 3 — Freshers Should Target Entry-Level-Friendly Markets

Candidates with 0–1 years of experience should focus on locations with a strong volume of entry-level postings.

Instead of asking:

> "Which city has the highest salary?"

the better question is:

> "Which city gives me the best combination of entry-level opportunity and salary?"

---

## Decision 4 — Target High-Paying Companies Strategically

The high-paying-job analysis can be used to identify companies that frequently advertise roles above the ₹7 LPA threshold.

Job seekers can then prioritize these companies in their application strategy.

---

## Decision 5 — Build Skill Combinations, Not Isolated Skills

Employers frequently request combinations of skills.

Therefore, candidates should build a complete analyst skill stack instead of learning one tool independently.

For example:

```text
SQL
+
Excel
+
Power BI
+
Data Visualization
+
Business Understanding
```

The exact combination should be validated against the Data Analyst-specific results from the dataset.

---

## Decision 6 — Recruiters Can Use the Analysis for Workforce Planning

Companies can use similar analysis to understand:

* Salary benchmarks
* Skill availability
* Competitive locations
* Job-market demand
* Work-mode preferences
* Required education
* Experience expectations

This can help improve hiring strategy and compensation planning.

---

# 15. Data Quality / SQL Improvements

While reviewing the SQL scripts, I identified several areas where the analysis can be improved.

### Issue 1 — `MAX(Job_Title)` Does Not Find the Most In-Demand Job

The original query:

```sql
SELECT MAX(Job_Title)
FROM job_market;
```

does **not** identify the job title with the highest number of postings.

The correct approach is:

```sql
SELECT 
    job_title,
    COUNT(*) AS job_postings
FROM job_market
GROUP BY job_title
ORDER BY job_postings DESC
LIMIT 1;
```

---

### Issue 2 — `MAX(Location)` Does Not Find the Most Popular Location

Similarly:

```sql
SELECT MAX(Location)
FROM job_market;
```

returns the maximum value alphabetically/according to the database's ordering rules, not the location with the most jobs.

The correct approach is:

```sql
SELECT
    location,
    COUNT(*) AS job_opportunities
FROM job_market
GROUP BY location
ORDER BY job_opportunities DESC
LIMIT 1;
```

---

### Issue 3 — High-Paying Skills Should Be Ordered Correctly

The original query:

```sql
SELECT skills_required, COUNT(*) AS job_count
FROM job_market
WHERE salary_lpa >= 7
GROUP BY skills_required
ORDER BY job_count;
```

orders the results ascending.

For the most common skills, use:

```sql
ORDER BY job_count DESC;
```

---

### Issue 4 — Experience Ordering

Experience categories stored as strings such as:

```text
0-1
1-2
2-3
3-5
```

may not always sort naturally depending on the database and data structure.

For production analysis, an explicit ordering field or numeric experience bands would be preferable.

---

### Issue 5 — Skill Strings Limit Skill-Level Analysis

If `skills_required` stores the entire combination in a single field, for example:

```text
SQL, Excel, Power BI
```

then the analysis treats the whole combination as one category.

A more advanced data model would normalize skills into separate rows:

```text
job_id | skill
-------|-------------
101    | SQL
101    | Excel
101    | Power BI
```

This would allow accurate analysis of individual skill demand.

---

# 16. Project Structure

Recommended GitHub repository structure:

```text
job-market-intelligence-sql/
│
├── README.md
│
├── sql/
│   ├── cleaned_the_dataset.sql
│   ├── final_sql_question.sql
│   └── job_market.sql
│
└── images/
    └── job_market_dashboard.png
```

### File Description

### `cleaned_the_dataset.sql`

Contains:

* Database selection
* Table preparation
* Missing-value checks
* Duplicate checks
* Salary validation
* Experience validation
* Schema validation

### `final_sql_question.sql`

Contains the main business-analysis queries covering:

* Job demand
* Salary
* Experience
* Location
* Education
* Work mode
* Fresher opportunities
* Skills
* Industries
* High-paying opportunities
* Career opportunity scoring

### `job_market.sql`

Contains additional exploratory analysis and supporting queries.

---

# 17. How to Run

## Step 1 — Create/Select the Database

```sql
CREATE DATABASE job_market;
```

Then:

```sql
USE job_market;
```

If the database already exists:

```sql
USE job_market;
```

---

## Step 2 — Load the Dataset

Import the `job_market` table into MySQL.

The table should contain the required columns:

```text
job_id
job_title
company
location
industry
salary_lpa
experience_years
education
employment_type
work_mode
skills_required
date_posted
```

---

## Step 3 — Run Data Validation

Execute:

```text
cleaned the dataset.sql
```

Check:

* Missing salaries
* Duplicate records
* Invalid salary values
* Invalid experience values
* Table structure

---

## Step 4 — Run Exploratory Analysis

Execute:

```text
job_market.sql
```

This contains additional exploratory questions and analysis.

---

## Step 5 — Run Final Analysis

Execute:

```text
final sql question.sql
```

This contains the primary business questions and final analytical queries.

---

# 18. Conclusion

This project demonstrates how SQL can be used to transform job-posting data into actionable **career and business intelligence**.

The analysis covers the complete analytical workflow:

```text
Raw Job Data
      ↓
Data Cleaning
      ↓
Data Validation
      ↓
Exploratory SQL Analysis
      ↓
Salary Analysis
      ↓
Job Demand Analysis
      ↓
Skill Analysis
      ↓
Location Analysis
      ↓
Business Recommendations
```

The most important analytical idea in this project is that **job-market decisions should not be based on a single metric**.

A strong career opportunity should ideally be evaluated using:

```text
Job Demand
+
Salary
+
Entry-Level Accessibility
+
Skill Demand
+
Location
+
Career Growth Potential
```

For an aspiring Data Analyst, this project demonstrates practical ability in:

* SQL querying
* Data cleaning
* Aggregation
* Business problem solving
* Salary analysis
* Market research
* Skill-gap analysis
* Career-oriented data analysis

The project can be further strengthened by adding a **Power BI/Tableau dashboard**, normalized skill-level analysis, salary distributions, and time-based job-market trends.

---

# 19. Author

**Suprokash Ghosh**

Aspiring Data Analyst

### Skills Demonstrated

* SQL
* MySQL
* Data Cleaning
* Exploratory Data Analysis
* Business Analysis
* Salary Analysis
* Job Market Analysis
* Data Visualization
* Business Intelligence
* Data-driven Decision Making

---
