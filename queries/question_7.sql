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
        The St. Louis Cardinals had 105 wins and lost the world series in 2004, and the Los Angeles Dodgers won 63 
		games and won the world series in 1981. The sum of the Dodgers' wins and losses added to 110, not 162 like 
		the other rows. This was due to a player's strike, as reported by Wikipedia. 
		
		https://en.wikipedia.org/wiki/1981_Major_League_Baseball_season
		
		Without the 1981 world series in the report, we find that the 2006 cardinals won 83 games and also
		won the world series.
		
		

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
	AND wswin = 'Y'
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
	AND lgwin = 'Y'
GROUP BY yearid, teamid, name, w, l, wswin
ORDER BY w DESC
;



SELECT 
	DISTINCT(s.yearid), 
	s.teamidwinner,
	s.teamidloser,
	t.w AS winners_wins,
	t.l AS winners_losses
FROM seriespost AS s
	INNER JOIN teams AS t
	ON s.yearid = t.yearid
WHERE s.yearid BETWEEN 1970 AND 2016
	AND s.yearid <> 1981
	AND s.round = 'WS'
	AND t.wswin = 'Y'
	AND t.lgwin = 'Y'
	AND t.wswin IS NOT NULL
GROUP BY s.yearid, s.teamidwinner, s.teamidloser, t.w, t.l
ORDER BY s.yearid
;

SELECT 
	DISTINCT(t.yearid), 
	t.teamid,
	t.w,
	t.l
FROM teams AS t
	INNER JOIN seriespost AS s
	ON t.yearid = s.yearid
WHERE t.yearid BETWEEN 1970 AND 2016
	AND lgwin = 'Y'
ORDER BY t.yearid
;