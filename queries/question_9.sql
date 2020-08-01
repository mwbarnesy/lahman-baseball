/*
    QUESTION ::
        Which managers have won the TSN Manager of the Year award in both the National 
		League (NL) and the American League (AL)? Give their full name and the teams that 
		they were managing when they won the award.

    SOURCES ::
        * teams (for team names), managers (for manager names), awardsmanagers (for winning
		managers)

    DIMENSIONS ::
        * teams.name, teams.teamid, managers.playerid, managers.teamid, awardsmanagers.playerid,
		awardsmanagers.lgid

    FACTS ::
        * ...

    FILTERS ::
        * WHERE awardsmanagers.awardid = TSN Manager of the Year AND awardsmanagers.lgid = NL AND AL

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

SELECT *
FROM managershalf;

SELECT *
FROM awardsmanagers;

SELECT *
FROM teams;
