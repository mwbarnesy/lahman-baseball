/*
    QUESTION ::
        Which managers have won the TSN Manager of the Year award in both the National 
		League (NL) and the American League (AL)? Give their full name and the teams that 
		they were managing when they won the award.

    SOURCES ::
        * teams (for team names), managers (for manager names), awardsmanagers (for winning
		managers)

    DIMENSIONS ::
        * teams.name, teams.teamid, managers.playerid, managers.teamid, awardsmanagers.playerid,
		awardsmanagers.lgid

    FACTS ::
        * ...

    FILTERS ::
        * WHERE awardsmanagers.awardid = TSN Manager of the Year AND awardsmanagers.lgid = NL AND AL

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

/*
:::::
This code will return every manager who won the 'TSN Manager of the Year' award. Now I need to figure
out how to pull up the playerid where the lgid is NL and AL.
:::::
*/

SELECT playerid, lgid, yearid
FROM awardsmanagers
WHERE awardid = 'TSN Manager of the Year';

/* 
:::::
I want to try defining two CTEs and joining them to get playerids that contain both NL and AL.
:::::
*/ 

WITH nl_awardsmanagers(playerid) AS (
	SELECT playerid
	FROM awardsmanagers
	WHERE lgid = 'NL' 
	AND awardid = 'TSN Manager of the Year')
,
al_awardsmanagers(playerid) AS (
	SELECT playerid
	FROM awardsmanagers
	WHERE lgid = 'AL' 
	AND awardid = 'TSN Manager of the Year')
	
SELECT *
FROM nl_awardsmanagers AS nl
INNER JOIN al_awardsmanagers AS al
ON nl.playerid = al.playerid;

/*
:::::
Let's check the work by plugging in the playerids from above query.
:::::
*/

SELECT playerid, lgid, yearid
FROM awardsmanagers
WHERE playerid = 'leylaji99' OR playerid = 'johnsda02';

SELECT *
FROM managershalf;

SELECT *
FROM teams;
