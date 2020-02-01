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

--Find all players in the database who played at Vanderbilt University.
SELECT 
	playerid,
	schoolid
FROM collegeplaying;


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
