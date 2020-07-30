/*
    QUESTION ::
        Using the attendance figures from the homegames table, find the teams and parks which had the 
		top 5 average attendance per game in 2016 (where average attendance is defined as total 
		attendance divided by number of games). Only consider parks where there were at least 10 games 
		played. Report the park name, team name, and average attendance. Repeat for the lowest 5 
		average attendance.

    SOURCES ::
        * Homegames table, parks table, teams table

    DIMENSIONS ::
        * Park name, team name, average attendance

    FACTS ::
        * 

    FILTERS ::
        * WHERE number of games > 10, year = 2016, top 5 and lowest 5 average attendance

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

/* 
:::::
Here I am able to get the team and park foreign keys, 
and order the data by the five higest average attendance. 
:::::
*/

SELECT 
	team, 
	park,
	attendance / games AS avg_attendance
FROM homegames
WHERE games > 10 AND year = 2016
ORDER BY avg_attendance DESC
LIMIT 5;


SELECT 
	t.park,
	t.name,
	h.attendance / h.games AS avg_attendance
FROM teams AS t
LEFT JOIN homegames AS h
ON t.teamid = h.team
WHERE t.yearid = 2016 
ORDER BY avg_attendance DESC;

SELECT g, name, park, attendance
FROM teams
WHERE yearid = 2016;


/* 

THIS QUERY ISN'T DOING WHAT I WANT IT TO.

SELECT
	teams.name, 
	parks.park_name, 
	homegames.attendance / homegames.games AS average_attendance
FROM teams, parks, homegames
WHERE homegames.games > 10 AND homegames.year = 2016;
*/
