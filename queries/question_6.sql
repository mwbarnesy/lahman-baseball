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
      	I started strong by filtering by year, and adding the stolen bases and caught stealing amounts together to
		find the attempts, but I struggled to figure out how to put everything together to find the percentage. 
		Finally I realized that I need to convert the data types in sb and cs to numeric before I could perform any
		division.

    ANSWER ::
        Chris Owings had the most success stealing bases with a 91.3% success rate.

*/

SELECT 
	p.namefirst || ' ' || p.namelast AS player_name, 
	sb,
	cs,
	sb + cs AS sb_attempts,
	ROUND(CAST(sb AS numeric) / (CAST(sb AS numeric) + CAST(cs AS numeric)), 4) * 100 AS success
FROM batting AS b
	INNER JOIN people AS p
	ON b.playerid = p.playerid
WHERE yearid = 2016
	AND sb + cs >= 20
GROUP BY player_name, sb, cs, sb_attempts, success
ORDER BY success DESC
;



-- Initial attempt --

SELECT
	p.namefirst || ' ' || p.namelast AS player_name, -- CONCAT shorthand with a space between ' '
	SUM(sb) + SUM(cs) AS sb_attempts,
	sb,
	cs
FROM batting AS b
		INNER JOIN people AS p
		ON b.playerid = p.playerid
WHERE yearid = 2016
	AND sb IS NOT NULL
	AND cs IS NOT NULL
GROUP BY p.namefirst, p.namelast, sb, cs
ORDER BY sb_attempts DESC -- REMEMBER, you are looking for the best percentage, not the most attempts.
;
