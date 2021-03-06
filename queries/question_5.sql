/*
    QUESTION ::
        Find the average number of strikeouts per game by decade since 1920. Round the numbers you report 
		to 2 decimal places. Do the same for home runs per game. Do you see any trends?
    SOURCES ::
        Batting table.

    DIMENSIONS ::
        SO, HR per game 

    FACTS ::
        SUM(SO) / SUM(G), SUM(HR) / SUM(G)

    FILTERS ::
        Strikeouts per game by decade since 1920.

    DESCRIPTION ::

		I wound up using this code toward the end, but realized I was taking the AVG of strikeouts and homeruns
		per decade, when I needed to be finding the SUM(s) of strikeouts per game SUM(G)
		CAST(SUM(g) / 2 AS numeric) AS total_games_decade, -- Returns the sum of games divided by two
		ROUND(AVG(so), 2) AS avg_so_decade, -- Average strikeout per decade
		ROUND(AVG(hr), 2) AS avg_hr_decade, -- Average homerun per decade


    ANSWER ::
        The average strikeouts per game have tripled, and it is unclear whether it has topped out.The average 
		homerun per game has nearly doubled; although it topped out in the 2000's. 

*/

SELECT 	 
			
			
			ROUND(SUM(so) / CAST(SUM(g) / 2 AS numeric), 2) AS avg_so_game,
			ROUND(SUM(hr) / CAST(SUM(g) / 2 AS numeric), 2) AS avg_hr_game,
			CASE
				WHEN yearid BETWEEN 1920 AND 1929 THEN 'Twenties'
				WHEN yearid BETWEEN 1930 AND 1939 THEN 'Thirties' 
				WHEN yearid BETWEEN 1940 AND 1949 THEN 'Forties'
				WHEN yearid BETWEEN 1950 AND 1959 THEN 'Fifties' 
				WHEN yearid BETWEEN 1960 AND 1969 THEN 'Sixties' 
				WHEN yearid BETWEEN 1970 AND 1979 THEN 'Seventies' 
				WHEN yearid BETWEEN 1980 AND 1989 THEN 'Eighties' 
				WHEN yearid BETWEEN 1990 AND 1999 THEN 'Nineties' 
				WHEN yearid BETWEEN 2000 AND 2009 THEN 'Two Thousands' 
				WHEN yearid BETWEEN 2010 AND 2020 THEN 'Twenty Tens' 
					ELSE 'Not of interest' END AS decade
FROM teams
WHERE yearid >= 1920
GROUP BY decade
;



/*

SELECT 
			CAST(SUM(g) / 2 AS numeric) AS total_games,
			CAST(ROUND(AVG(so), 2) AS numeric) / CAST(SUM(g) / 2 AS numeric) AS avg_so,
			CAST(ROUND(AVG(hr), 2) AS numeric) / CAST(SUM(g) / 2 AS numeric) AS avg_hr,
			CASE
				WHEN yearid BETWEEN 1920 AND 1929 THEN 'Twenties'
				WHEN yearid BETWEEN 1930 AND 1939 THEN 'Thirties' 
				WHEN yearid BETWEEN 1940 AND 1949 THEN 'Forties'
				WHEN yearid BETWEEN 1950 AND 1959 THEN 'Fifties' 
				WHEN yearid BETWEEN 1960 AND 1969 THEN 'Sixties' 
				WHEN yearid BETWEEN 1970 AND 1979 THEN 'Seventies' 
				WHEN yearid BETWEEN 1980 AND 1989 THEN 'Eighties' 
				WHEN yearid BETWEEN 1990 AND 1999 THEN 'Nineties' 
				WHEN yearid BETWEEN 2000 AND 2009 THEN 'Two Thousands' 
				WHEN yearid BETWEEN 2010 AND 2020 THEN 'Twenty Tens' 
					ELSE 'Not of interest' END AS decade
		FROM teams
		WHERE yearid >= 1920
		GROUP BY decade

;

*/






/*

-- Initial query

SELECT 
	ROUND(AVG(so),2) AS avg_so, 
		CASE
			WHEN yearid BETWEEN 1920 AND 1929 
			THEN 'Twenties'
			WHEN yearid BETWEEN 1930 AND 1939
			THEN 'Thirties' 
			WHEN yearid BETWEEN 1940 AND 1949
			THEN 'Forties'
			WHEN yearid BETWEEN 1950 AND 1959
			THEN 'Fifties' 
			WHEN yearid BETWEEN 1960 AND 1969
			THEN 'Sixties' 
			WHEN yearid BETWEEN 1970 AND 1979
			THEN 'Seventies' 
			WHEN yearid BETWEEN 1980 AND 1989
			THEN 'Eighties' 
			WHEN yearid BETWEEN 1990 AND 1999
			THEN 'Nineties' 
			WHEN yearid BETWEEN 2000 AND 2009
			THEN 'Two Thousands' 
			WHEN yearid BETWEEN 2010 AND 2020
			THEN 'Twenty Tens' 
			ELSE 'Not of interest' END AS decade_so,
	ROUND(AVG(hr),2) AS avg_hr,
	SUM(g) AS 
		CASE
			WHEN yearid BETWEEN 1920 AND 1929 
			THEN 'Twenties'
			WHEN yearid BETWEEN 1930 AND 1939
			THEN 'Thirties' 
			WHEN yearid BETWEEN 1940 AND 1949
			THEN 'Forties'
			WHEN yearid BETWEEN 1950 AND 1959
			THEN 'Fifties' 
			WHEN yearid BETWEEN 1960 AND 1969
			THEN 'Sixties' 
			WHEN yearid BETWEEN 1970 AND 1979
			THEN 'Seventies' 
			WHEN yearid BETWEEN 1980 AND 1989
			THEN 'Eighties' 
			WHEN yearid BETWEEN 1990 AND 1999
			THEN 'Nineties' 
			WHEN yearid BETWEEN 2000 AND 2009
			THEN 'Two Thousands' 
			WHEN yearid BETWEEN 2010 AND 2020
			THEN 'Twenty Tens' 
			ELSE 'Not of interest' END AS decade_hr
FROM batting
GROUP BY decade_so
;

*/





