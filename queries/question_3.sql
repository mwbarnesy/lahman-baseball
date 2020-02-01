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

-- Create a CTE that SELECTS schoolid and schoolname WHERE schoolname = 'Vanderbilt University'.
-- Create a CTE that returns the playerid, and the total monies earned from the salaries table.
WITH 
vandy AS
	(
	SELECT 
		schoolid,
		schoolname
	FROM schools
	WHERE schoolname = 'Vanderbilt University'
	) -- End of vandy CTE
,
salary AS 
	(
	SELECT 
		playerid, -- This column was only included to test the salary CTE.
		SUM(salary) AS total_monies
	FROM salaries
	GROUP BY playerid -- Must GROUP BY a non aggregated column.
	-- ORDER BY total_monies DESC -- This allows me to see the highest earner at a glance.
	-- The previous two lines were commented out because I wanted to test the query to make sure it worked. 
	) -- End of salary CTE
-- End of WITH clause

-- In the outer query, select the schoolname from vandy, and playerid from collegeplaying.
SELECT vandy.schoolname, c.playerid, p.namefirst, p.namelast
FROM vandy
-- Create an INNER JOIN to join vandy and collegeplaying ON schoolid
INNER JOIN collegeplaying AS c
ON vandy.schoolid = c.schoolid
INNER JOIN people AS p
ON p.playerid = c.playerid
;








