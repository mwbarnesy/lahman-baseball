/*
    QUESTION ::
        Find all players in the database who played at Vanderbilt University. 
		Create a list showing each player’s first and last names as well as the total 
		salary they earned in the major leagues. Sort this list in descending order by 
		the total salary earned. Which Vanderbilt player earned the most money in the majors?

    SOURCES ::
        * people, collegeplaying, schools, salaries

    DIMENSIONS ::
        * people = playerid, namefirst, namelast 
		* collegeplaying = playerid, schoolid 
		* schools = schoolid, schoolname
		* salaries = playerid, salary

    FACTS ::
        SUM(salary) to get the total salary. 

    FILTERS ::
        WHERE schoolname = 'Vanderbilt University'.

    DESCRIPTION ::
        It was pointed out to me that the collegeplaying table had duplicate entries for a single playerid, 
		so this was doubling or tripling my results. At one point, I had the highest earner making $250 million or so.
		Taylor helped me with a handy subquery that returned DISTINCT playerids from the collegeplaying table. 

    ANSWER ::
        David Price made $81,851,296.00 total in the major leagues.

*/

SELECT 
		p.namefirst,
		p.namelast,
		CAST(CAST(SUM(s.salary) AS numeric) AS money) AS total_earned,
		schools.schoolname
	FROM schools
		INNER JOIN ( -- Here we used a subquery inside of a JOIN that allows us to pull playerid from collegeplaying
					 -- without any duplicates. Note: DISTINCT playerid, schoolid!
			SELECT DISTINCT playerid, schoolid
				FROM collegeplaying
			) AS cp USING (schoolid)
		INNER JOIN people AS p
			USING (playerid)
		INNER JOIN salaries AS s
			USING (playerid)
WHERE schoolname = 'Vanderbilt University'
GROUP BY p.namefirst, p.namelast, schools.schoolname
ORDER BY total_earned DESC
;





-- Begin old queries


-- PART ONE: Find all players in the database who played at Vanderbilt University.
-- PART TWO: List all players, first and last name, and the total salary earned in the major leagues.

/*
WITH 
	vandy AS -- Create a CTE that SELECTs schoolid and schoolname WHERE schoolname = 'Vanderbilt University'.
	(
		SELECT 
			schoolid,
			schoolname
		FROM schools
		WHERE schoolname = 'Vanderbilt University'
	) -- End of vandy CTE
	-- , ==========> DON'T FORGET TO COMMENT IN/OUT COMMAS!!! <==========
/*	
	salary AS -- Create a CTE that returns the playerid, and the total monies earned from the salaries table.
	(
		SELECT 
			playerid, -- This column was only included to test the salary CTE.
			SUM(salary) AS total_monies
		FROM salaries
		GROUP BY playerid -- Must GROUP BY a non aggregated column.
		-- ORDER BY total_monies DESC -- This allows me to see the highest earner at a glance.
		-- The previous two lines were commented out because I wanted to test the query to make sure it worked. 
	) -- End of salary CTE
*/

-- End of WITH clause

-- In the outer query, select the schoolname from vandy, and playerid from collegeplaying.
SELECT 
	-- vandy.schoolname, -- I only needed this to be sure that all returned players went to Vanderbilt.
	p.namefirst, 
	p.namelast
FROM vandy
-- Create an INNER JOIN to join vandy to collegeplaying ON schoolid.
INNER JOIN collegeplaying AS c
ON vandy.schoolid = c.schoolid
-- Create another INNER JOIN to join people to collegeplaying ON playerid.
INNER JOIN people AS p
ON p.playerid = c.playerid
-- GROUP BY last name gets rid of duplicate rows.
GROUP BY p.namelast, p.namefirst, vandy.schoolname
;
*/

-- Let's take a look at the salaries table with the highest salary at the top.
-- This is not tied into Vandy players yet.

/*
SELECT people.playerid, SUM(salary) AS salary
FROM salaries
	INNER JOIN people
	ON salaries.playerid = people.playerid
WHERE people.playerid = 'priceda01'
GROUP BY people.playerid
ORDER BY salary DESC;
*/

-- Let's create a CTE that joins the schools table to the collegeplaying table.

/*
WITH vandy AS
	(
		SELECT 
			DISTINCT(c.playerid), 
			s.schoolname
		FROM schools as s
			INNER JOIN collegeplaying AS c
				ON s.schoolid = c.schoolid
		WHERE s.schoolname = 'Vanderbilt University'
		GROUP BY c.playerid, s.schoolname
	)
-- Begin main query
SELECT 
	vandy.playerid,
	p.namefirst,
	p.namelast,
	vandy.schoolname, 
	SUM(s.salary) AS total_salary
FROM vandy
		INNER JOIN salaries AS s
			ON s.playerid = vandy.playerid
		INNER JOIN people AS p
			ON vandy.playerid = p.playerid
GROUP BY vandy.playerid, vandy.schoolname, s.salary, p.namefirst, p.namelast
ORDER BY total_salary DESC
;


-- Let's start with the salaries table instead.

WITH 
total_earned AS 
	(
		SELECT
			s.playerid,
			p.namefirst,
			p.namelast,
			SUM(salary) AS total_earned
		FROM salaries AS s
			INNER JOIN people AS p
				ON s.playerid = p.playerid
		GROUP BY s.playerid, p.namefirst, p.namelast
		ORDER BY total_earned DESC;
	)
,
vandy AS 
	(
		SELECT 
			c.playerid,
			s.schoolid,
			s.schoolname
		FROM schools AS s
			INNER JOIN collegeplaying AS c
			ON s.schoolid = c.schoolid
		WHERE schoolname = 'Vanderbilt University';
	)
SELECT
	namefirst,
	namelast
FROM people	
;





SELECT
	sal.playerid,
	salary,
	sch.schoolname
FROM salaries AS sal
		INNER JOIN collegeplaying AS c
		ON sal.playerid = c.playerid
		INNER JOIN schools AS sch
		ON c.schoolid = sch.schoolid
WHERE sch.schoolname = 'Vanderbilt University'
GROUP BY sal.playerid, salary, sch.schoolname
ORDER BY salary DESC;





WITH 
player_salary AS
	(
		SELECT 
			DISTINCT(p.playerid)
			namefirst,
			namelast,
			SUM(s.salary) AS total_earned
		FROM people AS p
			INNER JOIN salaries AS s
				ON p.playerid = s.playerid
		GROUP BY p.playerid
		ORDER BY total_earned DESC
		-- ;
	)
player_school AS 
	(
		SELECT 
			c.playerid,
			s.schoolname
		FROM schools AS s
			INNER JOIN collegeplaying AS c
			ON s.schoolid = c.schoolid
		WHERE schoolname = 'Vanderbilt University'
		-- ;
	)

/*
SELECT 
	p.namefirst,
	p.namelast,
	s.schoolname,
	SUM(sal.salary) AS total_earned
FROM people AS p
	
	INNER JOIN schools AS s
		ON c.schoolid = s.schoolid
	INNER JOIN collegeplaying AS c
		ON p.playerid = c.playerid
		AND s.schoolname = 'Vanderbilt University'
	INNER JOIN salaries AS sal
		ON p.playerid = sal.playerid

GROUP BY namefirst, namelast, s.schoolname
ORDER BY total_earned DESC
;
*/

/*
SELECT
	DISTINCT(s.playerid),
	schoolid,
	SUM(s.salary) AS total_earned,
	'Vanderbilt University' As schoolname
FROM collegeplaying AS c

	INNER JOIN salaries AS s
		ON c.playerid = s.playerid
WHERE schoolid = 'vandy'
GROUP BY s.playerid, schoolid
ORDER BY total_earned DESC
;

SELECT 
	DISTINCT(playerid),
	schoolid
FROM collegeplaying AS cp
WHERE schoolid = 'vandy';

SELECT 
	DISTINCT(playerid),
	SUM(salary) AS total_earned
FROM salaries
GROUP BY playerid
ORDER BY total_earned DESC;
*/ 

/* 

===================TAYLOR'S CODE===================

SELECT
       p.namefirst || ' ' || p.namelast as name,
       sum(s.salary)::numeric::money as total_salary
  FROM schools
       -- the goal here is to return one player per school
       INNER JOIN (
             SELECT DISTINCT playerid, schoolid
               FROM collegeplaying
       -- this guy makes sure we are only pulling vandy players
       ) cp USING(schoolid) 
       -- now, we can join to people and salaries knowing we dont have duplicate players
       INNER JOIN people p USING(playerid)
       INNER JOIN salaries s USING(playerid)
 -- keeping vandy filter in the where clause (pretending we don't know the id)
 WHERE schoolname = 'Vanderbilt University'
 GROUP BY p.namefirst,  p.namelast
 ORDER BY total_salary DESC
 LIMIT 1;

*/