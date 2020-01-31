/*
    QUESTION ::
        Find the name and height of the shortest player in the database. 
		How many games did he play in? What is the name of the team for which he played?

    SOURCES ::
        * People, appearances, teams

    DIMENSIONS ::
        * namefirst, namelast, namegiven, height

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
	MIN(height)
FROM people
GROUP BY namefirst, namelast, namegiven, height
ORDER BY height;
