-- SQL Mini Project 10/10
-- SQL Mentor User Performance

DROP TABLE IF EXISTS user_sub_missions;

CREATE TABLE user_sub_missions (
	id SERIAL PRIMARY KEY,
	user_id BIGINT,
	question_id INT,
	points INT,
	submitted_at TIMESTAMP WITH TIME ZONE,
	username VARCHAR(50)
);


SELECT * FROM user_sub_missions

select
count(*)
from user_sub_missions

-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)
select
distinct(username) as distinct_user,
points,
count(*) as total_submissions
from user_sub_missions
group by username,points

--  if you want total points each distinct user

select
	username,
	count(*) as total_submissions,
	sum(points) as total_points
from user_sub_missions
group by username
order by count(*)desc

-- -- Q.2 Calculate the daily average points for each user.
-- each day
-- each user and their daily avg points
-- group by day and user


select
	username,
	avg(points) as avg_points,
	Extract(day from submitted_at) as days
from user_sub_missions
group by Extract(day from submitted_at),username
order by username

-- Q.3 Find the top 3 users with the most correct submissions for each day.
-- each day
-- most correct submissions

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
where dens_rk <=3

-- ///// using day and month /////----

WITH daily_submissions
AS
(
	SELECT 
		-- EXTRACT(DAY FROM submitted_at) as day,
		TO_CHAR(submitted_at, 'DD-MM') as daily,
		username,
		SUM(CASE 
			WHEN points > 0 THEN 1 ELSE 0
		END) as correct_submissions
	FROM user_sub_missions
	GROUP BY 1, 2
),
users_rank
as
(SELECT 
	daily,
	username,
	correct_submissions,
	DENSE_RANK() OVER(PARTITION BY daily ORDER BY correct_submissions DESC) as rank
FROM daily_submissions
)

SELECT 
	daily,
	username,
	correct_submissions
FROM users_rank
WHERE rank <= 3;

-- ///

-- Q.4 Find the top 5 users with the highest number of incorrect submissions.

select
	username,
	sum(case when points<0 then 1 else 0 end)  as incorrect_submission_ur_one,
	sum(case when points<0 then points else 0 end) as incorrect_submission_ur_orignal_pt,
	sum(case when points>0 then 1 else 0 end) as correct_submission_ur_one,
	sum(case when points>0 then points else 0 end) as correct_submission_ur_orignal_pt
from user_sub_missions
group by username
order by incorrect_submission_ur_one desc


-- Q.5 Find the top 10 performers for each week.

select
username,
	Extract(week from submitted_at) as weeks,
	sum(points) as total_points
from user_sub_missions
group by Extract(week from submitted_at),username
order by sum(points) desc
limit 10

-- Using Windows Functions ---

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
where den_rk <=10
-- /////
