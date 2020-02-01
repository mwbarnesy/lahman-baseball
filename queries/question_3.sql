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
 
/* 
This WHERE clause meant to find Vanderbilt University from the schools table
===
SELECT DISTINCT(schoolname)
FROM schools
WHERE schoolname ILIKE 'Vanderbilt%';
===
*/

/*

*/

-- Create a CTE that SELECTS schoolid and schoolname WHERE schoolname = 'Vanderbilt University'.
-- Create a CTE that SELECTS the playerid and salary 
WITH vandy AS
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
		playerid,
		SUM(salary)
	FROM salaries
	) -- End of salary CTE
-- End of WITH clause
	
-- In the outer query, select the schoolname from vandy, and playerid from collegeplaying.
SELECT vandy.schoolname, c.playerid
FROM vandy
-- Create an INNER JOIN to join vandy and collegeplaying ON schoolid
INNER JOIN collegeplaying AS c --
ON vandy.schoolid = c.schoolid
;

/*SELECT
	playerid
FROM collegeplaying AS c;






/*SELECT 
	p.namefirst, 
	p.namelast, 
	s.schoolname
FROM people AS p
INNER JOIN collegeplaying AS c
	ON p.playerid = c.playerid
INNER JOIN schools AS s
	ON c.schoolid = s.schoolid
	WHERE schoolname = 'Vanderbilt'
GROUP BY p.namefirst, p.namelast, s.schoolname
;*/
