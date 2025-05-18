--- ANALYSE PHASE ---

/* In this phase, we conduct our analysis of the data using SQL queries by checking the following statistics to compare casual users and annual members based on the ride-type, trip duration and location:

1. Users by ride type
2. Number of rides per month
3. Number of rides per weekday
4. Number of rides per hour
5. Average ride duration per weekday
6. Average ride duration per month
7. Start station location for casuals
8. Start station location for members
9. End station location for casuals
10. End station location for members 

*/

-- 1. Users by ride type:

SELECT user_type, ride_type, COUNT(*) AS total_rides
FROM bikes_new
GROUP BY user_type, ride_type
ORDER BY user_type, total_rides DESC;

-- Result saved in .csv file named 'Users-by-ride-type'

-- 2. Number of rides per month:

SELECT user_type, month_name, year_name, COUNT(*) AS no_of_rides
FROM bikes_new
GROUP BY user_type, month_name, year_name;

-- Result saved in .csv file named 'Num-rides-per-month'

-- 3. Number of rides per weekday:

SELECT user_type, day_of_week_name, day_of_week, COUNT(*) AS no_of_rides
FROM bikes_new
GROUP BY user_type, day_of_week_name, day_of_week;

-- Result saved in .csv file named 'Rides-per-day'

-- 4. Number of rides per hour:

SELECT user_type, EXTRACT(HOUR FROM started_at) AS time_of_day, COUNT(*) as num_of_rides
FROM bikes_new
GROUP BY user_type, time_of_day;

-- Result saved in .csv file named 'Rides-per-hour'

-- 5. Average ride duration per weekday:

SELECT user_type, day_of_week_name, day_of_week, AVG(ended_at - started_at) AS avg_trip_duration
FROM bikes_new
GROUP BY user_type, day_of_week_name, day_of_week;

-- Result saved in .csv file named 'Average-ride-duration-per-day'

-- 6. Average ride duration per month:

SELECT user_type, month_name, year_name, AVG(ended_at - started_at) AS avg_trip_duration
FROM bikes_new
GROUP BY user_type, month_name, year_name;

-- Result saved in .csv file named 'Average-ride-duration-per-month'

-- 7. Start station location for casuals:

SELECT user_type, start_station_name,
ROUND(AVG(start_lat), 4) AS start_lat,
ROUND(AVG(start_lng), 4) AS start_lng,  
COUNT(*) AS num_rides
FROM bikes_new
WHERE user_type = 'casual' AND start_station_name <> 'On Bike Lock State'
GROUP BY user_type, start_station_name;

-- Total rows: 1654. Result saved in .csv file named 'Start-station-location-for-casuals'

-- 8. Start station location for members:

SELECT user_type, start_station_name,
ROUND(AVG(start_lat), 4) AS start_lat,
ROUND(AVG(start_lng), 4) AS start_lng,  
COUNT(*) AS num_rides
FROM bikes_new
WHERE user_type = 'member' AND start_station_name <> 'On Bike Lock State'
GROUP BY user_type, start_station_name;

-- Total rows: 1746. Result saved in .csv file named 'Start-station-location-for-members'

-- 9. End station location for casuals:

SELECT user_type, end_station_name,
ROUND(AVG(end_lat), 4) AS end_lat,
ROUND(AVG(end_lng), 4) AS end_lng,  
COUNT(*) AS num_rides
FROM bikes_new
WHERE user_type = 'casual' AND end_station_name <> 'On Bike Lock State'
GROUP BY user_type, end_station_name;

-- Total rows: 1680. Result saved in .csv file named 'End-station-location-for-casuals'

-- 10. End station location for members:

SELECT user_type, end_station_name,
ROUND(AVG(end_lat), 4) AS end_lat,
ROUND(AVG(end_lng), 4) AS end_lng,  
COUNT(*) AS num_rides
FROM bikes_new
WHERE user_type = 'member' AND end_station_name <> 'On Bike Lock State'
GROUP BY user_type, end_station_name;

-- Total rows: 1746. Result saved in .csv file named 'End-station-location-for-members'
