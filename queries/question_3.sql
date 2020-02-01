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
        * SUM(salary)

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

-- PART ONE: Find all players in the database who played at Vanderbilt University.
-- PART TWO: List all players, first and last name, and the total salary earned in the major leagues.

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

-- Let's take a look at the salaries table with the highest salary at the top.
-- This is not tied into Vandy players.
SELECT playerid, MAX(salary) AS salary
FROM salaries
GROUP BY playerid
ORDER BY salary DESC;







