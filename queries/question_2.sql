/*
    QUESTION ::
        Find the name and height of the shortest player in the database. 
		How many games did he play in? What is the name of the team for which he played?

    SOURCES ::
        * People, appearances, teams

    DIMENSIONS ::
        * namefirst, namelast, namegiven, height, g_all, team_id

    FACTS ::
        * MIN(height) = 43

    FILTERS ::
        * 

    DESCRIPTION ::
        ...

    ANSWER ::
        Eddie Gaedel aka Edward Carl at 43 inches. 

*/

SELECT 
	namegiven, 
	namefirst, 
	namelast, 
	MIN(height) AS height,
	g_all
FROM people AS p
INNER JOIN appearances AS a
ON p.playerid = a.playerid
GROUP BY namefirst, namelast, namegiven, height, g_all
ORDER BY height ASC
LIMIT 10;
