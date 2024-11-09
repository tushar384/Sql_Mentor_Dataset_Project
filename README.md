# Sql_Mentor_Dataset_Project
## SQL Mentor User Performance Analysis
![Image Alt](https://github.com/tushar384/Sql_Mentor_Dataset_Project/blob/main/Chat%20Boat%20Image.jpg)
SQL Mentor User Performance Analysis
Project Overview
This project is designed to help beginners understand SQL querying and performance analysis using real-world data from the SQL Mentor User Performance dataset. The goal is to analyze user activity on an online learning platform by creating and querying tables of user submissions. Through this project, you'll gain hands-on experience solving SQL problems that extract meaningful insights from user data.

Objectives
Learn SQL techniques for data analysis, including aggregation, filtering, and ranking.
Understand how to calculate and manipulate data in a real-world dataset.
Gain practical experience using SQL functions like COUNT, SUM, AVG, EXTRACT(), and DENSE_RANK().
Develop SQL skills for performance analysis by solving data-related tasks.
Project Level: Beginner
This project is ideal for those familiar with the basics of SQL and who want to practice real-world data analysis with a small dataset. You’ll write SQL queries to solve tasks that are commonly encountered in data analytics.

Dataset: SQL Mentor User Performance
The dataset consists of information on user submissions for an online learning platform. Each submission record includes:

User ID: Unique identifier for each user.
Question ID: Unique identifier for each question.
Points Earned: Points earned by a user for a submission.
Submission Timestamp: Date and time of the submission.
Username: Name of the user.
Using this data, you can analyze user performance in terms of correct and incorrect submissions, total points earned, and activity on a daily or weekly basis.

SQL Problems and Solutions
Q1. List All Distinct Users and Their Stats
Description: Return the username, total submissions, and total points earned by each user.
Expected Output: A list of users with their submission count and total points.

Q2. Calculate the Daily Average Points for Each User
Description: For each day, calculate the average points earned by each user.
Expected Output: A report showing the average points per user for each day.

Q3. Find the Top 3 Users with the Most Correct Submissions for Each Day
Description: Identify the top 3 users with the most correct submissions for each day.
Expected Output: A list of users and their correct submission counts, ranked daily.

Q4. Find the Top 5 Users with the Highest Number of Incorrect Submissions
Description: Identify the top 5 users with the highest number of incorrect submissions.
Expected Output: A list of users with the count of incorrect submissions.

Q5. Find the Top 10 Performers for Each Week
Description: Identify the top 10 users with the highest total points earned each week.
Expected Output: A report showing the top 10 users ranked by total points per week.

Key SQL Concepts Covered
Aggregation: Using functions like COUNT, SUM, and AVG to summarize data.
Date Functions: Using EXTRACT() and TO_CHAR() to manipulate dates.
Conditional Aggregation: Using CASE WHEN to filter correct and incorrect submissions.
Ranking: Using DENSE_RANK() to rank users based on performance.
Group By: Aggregating data by different groups (e.g., by user, day, or week).
