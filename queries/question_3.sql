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
        After many attempts to write a CTE to help solve the problem, I decided to rely solely on JOINS.
		I could make each query of the CTE work independently, but not together. Once I realized I could 
		get the results I wanted using INNER JOINS, it came down to figuring out where the WHERE filter 
		would be happy. 

    ANSWER ::
        David Price made $245,553,888 in the majors.

*/

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
*/

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


SELECT 
	p.namefirst,
	p.namelast,
	s.schoolname,
	SUM(sal.salary) AS total_earned
FROM people AS p
	INNER JOIN collegeplaying AS c
		ON p.playerid = c.playerid
	INNER JOIN schools AS s
		ON c.schoolid = s.schoolid
	INNER JOIN salaries AS sal
		ON p.playerid = sal.playerid
WHERE schoolname = 'Vanderbilt University'
GROUP BY namefirst, namelast, s.schoolname
ORDER BY total_earned DESC
;






