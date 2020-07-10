---
title: Scratch
notebook: Database Systems
layout: note
date: 2020-07-01 20:53
tags: 
...

j
# 

[TOC]: #

```mysql
CREATE TABLE Course (
  CourseID INT,
  CourseName VARCHAR(100),
  CourseAddress VARCHAR(100),
  CourseSuburb VARCHAR(40),
  CoursePhone VARCHAR(10),
  PRIMARY KEY (CourseID)
);

CREATE TABLE Hole (
    CourseID INT,
    HoleNumber INT,
    Distance DECIMAL(5, 1),
    Par INT,
    PRIMARY KEY (CourseID, HoleNumber),
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

CREATE TABLE Tournament (
    TournamentID INT,
    TournamentName VARCHAR(100),
    CourseID INT, 
    StartDate DATE,
    EndDate DATE,
    AgeLimit INT,
    PRIMARY KEY (TournamentID),
    FOREIGN KEY (CourseID) REFERENCES Course (CourseID)j
);
```

```mysql
SELECT Player.PlayerID, AVG(PlayerCompetes.TotalScore), MIN(PlayerCompetes.Rank)
FROM Player NATURAL JOIN PlayerCompetes
GROUP BY Player.PlayerID;
```

Assume PlayerID is a candidate key
PlayerID -> PlayerName, PlayerShirtSize, TeamName, Team mascots, Team Home Ground, Home Ground Location

Violations of 1NF: Team mascots has multi-valued attributes
TeamMascot(TeamName PFK, Mascot PK)
Player(PlayerName, PlayerShirtSize, TeamName, Team Home Ground, Home Ground Location)

Violations of 2NF: in addition to 1NF violations, no partial dependencies
Violations of 3NF: transitive dependencies
TeamName -> team home ground
TeamHomeGround -> Home Ground Location
Player(PlayerName PK, PlayerShirtSize, TeamName FK)
Team(TeamName PK, Team Home Ground FK)
TeamMascot(TeamName PFK, Mascot PK)
Location(Home Ground PK, Home Ground Location)

```mysql
CREATE TABLE B (
    bid INT NOT NULL,
    PRIMARY KEY (bid)
);

CREATE TABLE C (
    cid INT NOT NULL,
    PRIMARY KEY (cid)
);

CREATE TABLE A (
    aid INT NOT NULL,
    bid INT NOT NULL,
    cid INT NOT NULL,
    PRIMARY KEY (aid),
    FOREIGN KEY (bid) REFERENCES B (bid),
    FOREIGN KEY (cid) REFERENCES C (cid)
);
```
```mysql
# Assuming that 'Public Transport' is one of the options for transport means.  I can't
# see anything that specifies possible values
SELECT COUNT(DISTINCT PreferredTransportation.PID)
FROM PreferredTransportation NATURAL JOIN TransportMeans
WHERE TransportMeans.TName = 'Public Transport';


```
11

```mysql
SELECT TransportMeans.Name, COUNT(Person.PID)
FROM Person NATURAL JOIN PreferredTransportation NATURAL JOIN TransportMeans
WHERE PreferredTransportation.CRID IN (SELECT CRID
                                        FROM CensusRecord
                                        WHERE CRYear = 2016)                                       
GROUP BY TransportMeans.TID
ORDER BY COUNT(Person.PID) DESC;
```

12
```mysql
# num people travelling from brunswick
# num people travelling to suburb other than Epping and Port Melbourne
SELECT COUNT(DISTINCT FrequentTrip.PID)
FROM FrequentTrip INNER JOIN Suburb AS FromSuburb ON FrequentTrip.from = Suburb.SID
    INNER JOIN Suburb AS ToSuburb ON FrequentTrip.to = Suburb.SID
    INNER JOIN CensusRecord ON FrequentTrip.CRID = CensusRecord.CRYear
WHERE FromSuburb.SName = 'Brunswick' AND ToSuburb.Name NOT IN ('Epping', 'Port Melbourne') AND CensusRecord.CRYear = 2016 
```

13
```mysql
SELECT 
FROM CensusRecord NATURAL JOIN Residency NATURAL JOIN Suburb
WHERE Residency.PID IN (SELECT COUNT(DISTINCT PreferredTransportation.PID)
FROM PreferredTransportation NATURAL JOIN TransportMeans
WHERE TransportMeans.TName = 'Public Transport';

```