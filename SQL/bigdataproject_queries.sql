--top 10 stadiums by capacity--
SELECT TOP 10 rank, stadium, capacity
FROM stadium
ORDER BY capacity DESC

--average capacity of the stadiums by region--
SELECT region, AVG(capacity) avg_capacity
FROM stadium
GROUP BY region
ORDER BY avg_capacity desc

-- count stadiums in each country--
SELECT country, count(country) stadium_count
FROM stadium
GROUP BY country
ORDER BY stadium_count desc, country asc

-- stadiums ranking with each region --
SELECT rank, region, stadium, capacity,
    RANK() OVER(PARTITION BY region ORDER BY capacity DESC) as region_rank
FROM stadium;

-- top 3 ranking with each region
SELECT rank, region, stadium, capacity, region_rank FROM (
SELECT rank, region, stadium, capacity,
    RANK() OVER(PARTITION BY region ORDER BY capacity DESC) as region_rank
FROM stadium) as ranked_stadiums
WHERE region_rank <=3

--stadiums with capacity above the average--
SELECT stadium, t2.region, capacity, avg_capacity
FROM stadium, (SELECT region, AVG(capacity) avg_capacity FROM stadium GROUP BY region) t2
WHERE t2.region = stadiums.region
AND capacity > avg_capacity

--stadiums with closest capacity to regional median--
WITH MedianCTE AS (
    SELECT region, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY capacity) OVER (PARTITION BY region) as median_capacity
    FROM stadium
)
SELECT rank, stadium, region, capacity, ranked_stadiums.median_capacity, ranked_stadiums.median_rank
FROM (
    SELECT s.rank, s.stadium, s.region, s.capacity, m.median_capacity,
    ROW_NUMBER() OVER (PARTITION BY s.region ORDER BY ABS(s.capacity - m.median_capacity)) AS median_rank
    from stadiums s JOIN MedianCTE m ON s.region = m.region
    ) ranked_stadiums
WHERE median_rank = 1