/*
    QUESTION ::
        What range of years does the provided database cover?

    SOURCES ::
        * Teams table

    DIMENSIONS ::
        * yearid

    FACTS ::
        * The minimum year is 1871

    FILTERS ::
        * GROUP BY yearid, ORDER BY yearid ASC

    DESCRIPTION ::
        ...

    ANSWER ::
        1871

*/

SELECT MIN(yearid)
FROM teams
GROUP BY yearid
ORDER BY yearid;
