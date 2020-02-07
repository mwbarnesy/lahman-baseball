/*
    QUESTION ::
        Find the player who had the most success stealing bases in 2016, where success is measured 
		as the percentage of stolen base attempts which are successful. (A stolen base attempt results 
		either in a stolen base or being caught stealing.) Consider only players who attempted at least 
		20 stolen bases.

    SOURCES ::
        Batting table

    DIMENSIONS ::
        Stolen base / caught stealing

    FACTS ::
        Percentage of stolen base attempts which are successful, attempts are SUM(stolen base) + SUM(caught stealing)

    FILTERS ::
        Year = 2016, players who ATTEMPTED to steal >= 20 

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

SELECT
	playerid,
	SUM(SB) + SUM(CS) AS sb_attempts
FROM batting
WHERE yearid = 2016
GROUP BY playerid
;
