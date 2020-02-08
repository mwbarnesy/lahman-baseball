/*
    QUESTION ::
        From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
		What is the smallest number of wins for a team that did win the world series? Doing this will probably 
		result in an unusually small number of wins for a world series champion – determine why this is the case. 
		Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team 
		with the most wins also won the world series? What percentage of the time?

    SOURCES ::
        SeriesPost table, Teams table, TeamFranchises table?

    DIMENSIONS ::
        World series losses, world series wins, number of wins in a season, problem year

    FACTS ::
        * ...

    FILTERS ::
        year 1970 to 2016

    DESCRIPTION ::
        ...

    ANSWER ::
        Seattle had 116 wins and lost the world series in 2001, and the Los Angeles Dodgers won 63 games
		and won the world series in 1981. The sum of the Dodgers games added to 110, not 162 like the other
		rows. This was due to a player's strike, as reported by Wikipedia. 
		
		https://en.wikipedia.org/wiki/1981_Major_League_Baseball_season
		
		

*/

-- ======== QUERY TO FIND LEAST WINS FOR WS WIN W/ REDO ========

SELECT 
	yearid, 
	teamid,
	name,
	w,
	l,
	wswin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
	AND yearid <> 1981
	--AND wswin = 'Y'
	AND wswin IS NOT NULL
GROUP BY yearid, teamid, name, w, l, wswin
ORDER BY w ASC
;


-- ======== QUERY TO FIND MOST WINS FOR WS LOSS ========

SELECT 
	yearid, 
	teamid,
	name,
	w,
	l,
	wswin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
	AND wswin = 'N'
GROUP BY yearid, teamid, name, w, l, wswin
ORDER BY w DESC
;



SELECT 
	DISTINCT(s.yearid), 
	s.teamidwinner,
	s.teamidloser
FROM seriespost AS s
WHERE s.yearid BETWEEN 1970 AND 2016
	AND s.yearid <> 1981
	AND s.round = 'WS'
GROUP BY s.yearid, s.teamidwinner, s.teamidloser
ORDER BY s.yearid
;