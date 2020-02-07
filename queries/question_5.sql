/*
    QUESTION ::
        Find the average number of strikeouts per game by decade since 1920. Round the numbers you report 
		to 2 decimal places. Do the same for home runs per game. Do you see any trends?
    SOURCES ::
        Batting table.

    DIMENSIONS ::
        SO, HR per game 

    FACTS ::
        AVG(SO), AVG(HR)

    FILTERS ::
        Strikeouts per game by decade since 1920.

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

SELECT 
	so, 
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
			ELSE 'Not of interest' END AS decade
FROM batting
GROUP BY decade, so
ORDER BY decade
;
