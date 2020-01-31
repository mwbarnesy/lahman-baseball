/*
    QUESTION ::
        Find the name and height of the shortest player in the database. 
		How many games did he play in? What is the name of the team for which he played?

    SOURCES ::
        * People, appearances, teams

    DIMENSIONS ::
        * namefirst, namelast, namegiven, height, g_all, name

    FACTS ::
        * MIN(height) = 43

    FILTERS ::
        * LIMIT 10

    DESCRIPTION ::
        ...

    ANSWER ::
        Eddie Gaedel aka Edward Carl, 43 inches tall, played in 1 game for the St. Louis Browns.

*/

SELECT 
	namegiven, 
	namefirst, 
	namelast, 
	MIN(height) AS height,
	g_all,
	t.name
FROM people AS p
INNER JOIN appearances AS a
ON p.playerid = a.playerid
INNER JOIN teams AS t
ON a.teamID = t.teamID
GROUP BY namefirst, namelast, namegiven, height, g_all, t.name
ORDER BY height ASC
LIMIT 10; 