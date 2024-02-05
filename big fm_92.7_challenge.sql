-- 1 Retrieve all stations in the "East" region?

SELECT StationID,StationName
FROM stations
WHERE Location = "East" ;

-- 2 List all shows hosted by "Vrajesh Hirjee"?
SELECT s.showName,h.HostName
FROM shows s
JOIN hosts h
ON h.HostID = s.HostID
WHERE HostName = 'Vrajesh Hirjee';


-- 3 Count the number of awards each show has won?

SELECT S.showName,
	   count(A.AwardId) AS Total_Awards_Won
FROM shows S
JOIN awards A
ON A.ShowID = S.ShowID
GROUP BY ShowName;


-- 4 Find shows that have partnerships with "Spotify"?

SELECT S.showName, P.partnerName
FROM showpartnerships SP
JOIN shows S USING (ShowID)
JOIN partnerships P USING (PartnershipID)
WHERE P.partnerName = 'Spotify'



-- 5 Retrieve hosts who joined before 2010?
SELECT HostName,JoinDate
FROM hosts
WHERE YEAR (JoinDate) < 2010;

-- 6 List the shows and their launch dates in descending order of launch date?

SELECT showName, LaunchDate
FROM shows 
ORDER BY LaunchDate DESC; 

 -- 7 Find the total count of shows for each host?

SELECT HostName, (ShowCount) 
FROM hosts 

-- 8 Show the online presence platforms with their links?

SELECT PlatformName, Link
FROM onlinepresence;

-- 9 Retrieve the stations in the "South" region launched after 2010?

SELECT StationName, LaunchDate
FROM stations
WHERE Location = "South" AND YEAR (LaunchDate) > 2010;

-- there is ni such RECORDS

-- 10 Rank hosts based on the number of shows they have hosted?
SELECT HostName,ShowCount,
DENSE_RANK() OVER (ORDER BY ShowCount desc) AS denserank
FROM hosts;

