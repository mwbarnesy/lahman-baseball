/*
    QUESTION ::
        What range of years does the provided database cover?

    SOURCES ::
        * Teams table

    DIMENSIONS ::
        * yearid

    FACTS ::
        * The minimum year is 1871, the maximum year is 2016

    FILTERS ::
        * N/A

    DESCRIPTION ::
        ...

    ANSWER ::
        1871 to 2016

*/

SELECT 
	MIN(yearid), 
	MAX(yearid)
FROM teams;
