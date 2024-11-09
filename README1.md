# SQL Mentor User Performance Analysis 

![SQL Data Analytics](Chat Boat Image.jpg)

## Project Overview

This project is designed to help beginners understand SQL querying and performance analysis using real-time data from SQL Mentor datasets. In this project, you will analyze user performance by creating and querying a table of user submissions. The goal is to solve a series of SQL problems to extract meaningful insights from user data.

## Objectives

- Learn how to use SQL for data analysis tasks such as aggregation, filtering, and ranking.
- Understand how to calculate and manipulate data in a real-world dataset.
- Gain hands-on experience with SQL functions like `COUNT`, `SUM`, `AVG`, `EXTRACT()`, and `DENSE_RANK()`.
- Develop skills for performance analysis using SQL by solving different types of data problems related to user performance.

## Project Level: Beginner

This project is designed for beginners who are familiar with the basics of SQL and want to learn how to handle real-world data analysis problems. You'll be working with a small dataset and writing SQL queries to solve different tasks that are commonly encountered in data analytics.

## SQL Mentor User Performance Dataset

The dataset consists of information about user submissions for an online learning platform. Each submission includes:
- **User ID**
- **Question ID**
- **Points Earned**
- **Submission Timestamp**
- **Username**

This data allows you to analyze user performance in terms of correct and incorrect submissions, total points earned, and daily/weekly activity.

## SQL Problems and Questions

Here are the SQL problems that you will solve as part of this project:

### Q1. List All Distinct Users and Their Stats
- **Description**: Return the user name, total submissions, and total points earned by each user.
- **Expected Output**: A list of users with their submission count and total points.

### Q2. Calculate the Daily Average Points for Each User
- **Description**: For each day, calculate the average points earned by each user.
- **Expected Output**: A report showing the average points per user for each day.

### Q3. Find the Top 3 Users with the Most Correct Submissions for Each Day
- **Description**: Identify the top 3 users with the most correct submissions for each day.
- **Expected Output**: A list of users and their correct submissions, ranked daily.

### Q4. Find the Top 5 Users with the Highest Number of Incorrect Submissions
- **Description**: Identify the top 5 users with the highest number of incorrect submissions.
- **Expected Output**: A list of users with the count of incorrect submissions.

### Q5. Find the Top 10 Performers for Each Week
- **Description**: Identify the top 10 users with the highest total points earned each week.
- **Expected Output**: A report showing the top 10 users ranked by total points per week.

## Key SQL Concepts Covered

- **Aggregation**: Using `COUNT`, `SUM`, `AVG` to aggregate data.
- **Date Functions**: Using `EXTRACT()` and `TO_CHAR()` for manipulating dates.
- **Conditional Aggregation**: Using `CASE WHEN` to handle positive and negative submissions.
- **Ranking**: Using `DENSE_RANK()` to rank users based on their performance.
- **Group By**: Aggregating results by groups (e.g., by user, by day, by week).

## SQL Queries Solutions

Below are the solutions for each question in this project:

### Q1: List All Distinct Users and Their Stats
```sql
select
	username,
	count(*) as total_submissions,
	sum(points) as total_points
from user_sub_missions
group by username
order by count(*)desc;
```

### Q2: Calculate the Daily Average Points for Each User
```sql
select
	username,
	avg(points) as avg_points,
	Extract(day from submitted_at) as days
from user_sub_missions
group by Extract(day from submitted_at),username
order by username;
```

### Q3: Find the Top 3 Users with the Most Correct Submissions for Each Day
```sql
with cte as
(
select
	username,
	Extract(day from submitted_at) as days,
	SUM(CASE	
			WHEN points > 0 THEN 1
			ELSE 0
		END) AS correct_submissions
from user_sub_missions
group by Extract(day from submitted_at),username
),
rank_cte as
(
select
	*,
	DENSE_RANK() OVER(PARTITION BY days ORDER BY correct_submissions) AS dens_rk
from cte
)
select
days,
username,
correct_submissions
from rank_cte
where dens_rk <=3;
```

### Q4: Find the Top 5 Users with the Highest Number of Incorrect Submissions
```sql
select
	username,
	sum(case when points<0 then 1 else 0 end)  as incorrect_submission_ur_one,
	sum(case when points<0 then points else 0 end) as incorrect_submission_ur_orignal_pt,
	sum(case when points>0 then 1 else 0 end) as correct_submission_ur_one,
	sum(case when points>0 then points else 0 end) as correct_submission_ur_orignal_pt
from user_sub_missions
group by username
order by incorrect_submission_ur_one desc
;
```

### Q5: Find the Top 10 Performers for Each Week
```sql
with cte as
(
select
	username,
	Extract(week from submitted_at) as week_no,
	sum(points) as total_points,
	DENSE_RANK() OVER(PARTITION BY Extract(week from submitted_at) ORDER BY sum(points)desc) AS den_rk
from user_sub_missions
group by Extract(week from submitted_at),username

)

select
	week_no,
	username,
	total_points,
	den_rk
from cte 
where den_rk <=10;
```

## Conclusion

This project provides an excellent opportunity for beginners to apply their SQL knowledge to solve practical data problems. By working through these SQL queries, you'll gain hands-on experience with data aggregation, ranking, date manipulation, and conditional logic.
