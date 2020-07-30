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

SELECT 
	h.team, 
	h.park, 
	h.attendance / h.games AS avg_attendance,
	t.name
FROM homegames AS h
INNER JOIN teams AS t
ON t.teamid = h.team
WHERE games > 10 AND year = 2016;

SELECT *
FROM homegames;

SELECT p.park_name, t.name, h.attendance / h.games AS average_attendance
FROM homegames AS h
JOIN teams AS t
ON h.team = t.teamid
JOIN parks AS p
ON h.park = p.park_name; 

SELECT team, park, attendance / games AS average_attendance 
FROM homegames
WHERE games > 10 AND year = 2016;

/*
SELECT
	teams.name, 
	parks.park_name, 
	homegames.attendance / homegames.games AS average_attendance
FROM teams, parks, homegames
WHERE homegames.games > 10 AND homegames.year = 2016;
*/


SELECT t.name, p.park_name, h.attendance / h.games AS avg_attendance
FROM homegames AS h
INNER JOIN teams AS t
ON t.teamid = h.team
INNER JOIN parks AS p
ON p.park = h.park
WHERE h.games > 10 AND h.year = 2016;

SELECT *
FROM homegames;

SELECT *
FROM teams;

SELECT *
FROM parks;

/*This is a test for Github */