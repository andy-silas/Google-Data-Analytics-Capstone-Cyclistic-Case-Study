--- PRELIMINARY ACTIONS ---

-- 1. To add a ride_length column to the table in PostgreSQL:

ALTER TABLE bikes_new
ADD COLUMN ride_length interval;

-- 2. Add values to 'ride_length' column by subtracting 'ended_at' values from 'started_at':

UPDATE bikes_new
SET ride_length = ended_at - started_at;

-- 3. To add day_of_week column to the table in PostgreSQL:

ALTER TABLE bikes_new
ADD COLUMN day_of_week integer;

--- Also to add day_of_week_name column to the table in PostgreSQL:

ALTER TABLE bikes_new
ADD COLUMN day_of_week_name text;

-- 4. To add values to day_of_week column by extracting day of the week from date time stamp:

UPDATE bikes_new
SET day_of_week = EXTRACT(DOW FROM started_at);

-- NOTE: Sunday = 0, Monday = 1, so on...

--- To add values to day_of_week_name column by extracting day of the week from date time stamp:

UPDATE bikes_new
SET day_of_week_name = TO_CHAR (started_at, 'DAY');

-- NOTE: 'day_of_week_name' will contain the name of the day itself (Eg: Sunday, Monday, and so on).

-- 5. To add a new column titled month_name with text data type:

ALTER TABLE bikes_new
ADD COLUMN month_name text;

-- 6. To add values to month_name column:

UPDATE bikes_new
SET month_name = TO_CHAR(started_at, 'Month');

-- 7. To add a new column titled year_name with integer data type:

ALTER TABLE bikes_new
ADD COLUMN year_name integer;

-- 8. To add values to year_name column:

UPDATE bikes_new
SET year_name = EXTRACT(year from started_at);

--- END OF PRELIMINARY ACTIONS ---

--- COMPREHENSIIVE DATA CLEANING PROCESSES ---

-- 1. To check the number of letters in ride_id column to make sure it is unique:

SELECT LENGTH(ride_id) AS letters_in_ride_id 
FROM bikes_new
ORDER BY letters_in_ride_id DESC; -- All results here are 16

-- OR WE CAN RUN:

SELECT LENGTH(ride_id) AS letters_in_ride_id 
FROM bikes_new
WHERE LENGTH(ride_id) > 16
ORDER BY letters_in_ride_id DESC; -- No results here

-- Now we know each ride_id has 16 letters.

-- 2. Delete rows from the 'bikes_new' table where there are duplicates (IF ANY):

DELETE FROM bikes_new
WHERE ride_id IN (
    -- Subquery to find duplicate rows based on ride_ids
    SELECT ride_id
    FROM bikes_new
    GROUP BY ride_id
    HAVING COUNT(*) > 1
);

-- Any duplicate rows are removed.

-- 3. To check for NULL values:

SELECT * FROM bikes_new
WHERE
	start_station_name is NULL
	AND start_station_id is NULL
	AND end_station_name is NULL
	AND end_station_id is NULL;

-- 4. We check for any rows where start/end_lat or start/end_lng are NULL:

SELECT *
FROM bikes_new
WHERE start_lat is NULL
OR start_lng is NULL
OR end_lat is NULL
OR end_lng is NULL;

-- Total rows: 6704 - We will remove these rows in the next step, since each row should have location coordinates:

-- We remove any rows where start/end_lat or start/end_lng are NULL:

DELETE FROM bikes_new
WHERE start_lat is NULL
OR start_lng is NULL
OR end_lat is NULL
OR end_lng is NULL;

-- NO RESULTS. So we can say that the data now has start and end coordinates for all rides

-- 5. To check null values in start_station_name

SELECT * FROM bikes_new
WHERE start_station_name is NULL;

-- Total rows: 1080125

-- 6. To check null values in start_station_id

SELECT * FROM bikes_new
WHERE start_station_id is NULL;

-- Total rows: 1080125 --> SAME AS THE ROWS WHERE start_station_name is NULL

-- 7. To check null values in end_station_name

SELECT * FROM bikes_new
WHERE end_station_name is NULL;

-- Total rows: 1103291

-- 8. To check null values in end_station_id

SELECT * FROM bikes_new
WHERE end_station_id is NULL;

-- Total rows: 1103291 --> SAME AS THE ROWS WHERE end_station_name is NULL

-- 9. We check if there are only 2 user types in the user_type column:

SELECT DISTINCT user_type
FROM bikes_new;

-- Result: Confirmed that only 'casual' and 'member' user types exist

--- END OF COMPREHENSIIVE DATA CLEANING PROCESSES --

--- CHECKING FOR OUTLIERS ---

-- 1. We now check for rides that are less than or equal to 1 min in ride_length:

SELECT *
FROM bikes_new
WHERE ride_length <= '00:01:00';

-- Result: Total rows: 129085. We will now remove these rows with ride_length <= 1 min:

DELETE FROM bikes_new
WHERE ride_length <= '00:01:00';

-- 2. We now check for rides that are greater than or equal to 1 day in ride_length:

SELECT *
FROM bikes_new
WHERE ride_length >= '1 day';

-- Result: Total rows: 295. We will now remove these rows with ride_length greater than or equal to 1 day:

DELETE FROM bikes_new
WHERE ride_length >= '1 day';

-- Now total rows are 5646805

--- END OF CHECKING FOR OUTLIERS ---

-- We check the start/end_station_name/id columns for naming inconsistencies:

SELECT start_station_name, count(*) AS count_name
FROM bikes_new
GROUP BY start_station_name
ORDER BY start_station_name DESC;

-- We find 1805 rows, with 'null' being the most common value with a count of 1010771. We also notice some station names are similar, with some ending with *. We will investigate this later.

-- We now check how many of these nulls are in end_station_name column for classic_bike. Since classic bike trips must end at a docking station, the end_station_name should not be null. Electric bikes having a bike lock option do not have this problem, as they do not have to start/end the ride at a docking station:

SELECT *
FROM bikes_new
WHERE end_station_name is NULL
AND ride_type = 'classic_bike';

-- Total rows: 27. We will remove these rows:

DELETE FROM bikes_new
WHERE end_station_name is NULL
AND ride_type = 'classic_bike';

-- Result: 27 rows removed

-- New Total Rows: 5646778

-- Original number of rows were: 5783100

-- Total 136322 rows removed

-- Now we check again for the previous query, but this time with end_station_id being NULL

SELECT *
FROM bikes_new
WHERE end_station_id is NULL
AND ride_type = 'classic_bike';

-- Result: No results found

-- Now we check again for the previous query, but this time with start_station_name being NULL

SELECT *
FROM bikes_new
WHERE start_station_name is NULL
AND ride_type = 'classic_bike';

-- No results. It appears that we have cleaned the data for all classic bikes. To double check this, we run the following query to check the distinct ride types where start_station_name is NULL. It should only return electric_bike/electric_scooter:

SELECT DISTINCT ride_type
FROM bikes_new
WHERE start_station_name is NULL;

-- Now we check again for the previous query, but this time with start_station_id being NULL

SELECT DISTINCT ride_type
FROM bikes_new
WHERE start_station_id is NULL;

-- Result: electric_bike and electric_scooter -- Just as we expected. So it can be confirmed that we have cleaned the data for classic and electric bikes/scooters.

-- Now, we will update the NULL values in start_station_name and end_station_name for electric_bike and electric_scooter ride types to "On Bike Lock State" and "On Scooter Lock State" respectively:

-- a: First we check start_station_name, for electric_bike:

SELECT *
FROM bikes_new
WHERE start_station_name is NULL
AND ride_type = 'electric_bike';

-- Total Rows: 946482. Now, we update these rows:

UPDATE bikes_new
SET start_station_name = 'On Bike Lock State'
WHERE start_station_name is NULL
AND ride_type = 'electric_bike';

-- Result: 946482 rows updated

-- b: Now we check the same for end_station_name, for electric_bike:

SELECT *
FROM bikes_new
WHERE end_station_name is NULL
AND ride_type = 'electric_bike';

-- Total Rows: 948718 -- Now, we update these rows:

UPDATE bikes_new
SET end_station_name = 'On Bike Lock State'
WHERE end_station_name is NULL
AND ride_type = 'electric_bike';

-- Result: 948718 rows updated

-- c: Next, we check the same for start_station_name, for electric_scooter:

SELECT *
FROM bikes_new
WHERE start_station_name is NULL
AND ride_type = 'electric_scooter';

-- Total Rows: 64289 -- Now, we update these rows:

UPDATE bikes_new
SET start_station_name = 'On Scooter Lock State'
WHERE start_station_name is NULL
AND ride_type = 'electric_scooter';

-- Result: 64289 rows updated

-- d: Finally, we check the same for end_station_name, for electric_scooter:

SELECT *
FROM bikes_new
WHERE end_station_name is NULL
AND ride_type = 'electric_scooter';

-- Total Rows: 64767 -- Now, we update these rows:

UPDATE bikes_new
SET end_station_name = 'On Scooter Lock State'
WHERE end_station_name is NULL
AND ride_type = 'electric_scooter';

-- Result: 64767 rows updated

-- Finally, we check if there are any nulls left in start_station_name or end_station_name:

SELECT *
FROM bikes_new
WHERE start_station_name is NULL
OR end_station_name is NULL

-- Result: 0 rows. We can safely conclude that all null station names have been replaced with relevant values.

-- We now check the no. of rides of each type:

SELECT DISTINCT COUNT(ride_type) AS count_ride_type, ride_type
FROM bikes_new
GROUP BY ride_type;

-- SCREESHOT HERE --

-- We now check the no. of rides of each type per user type:

SELECT DISTINCT COUNT(ride_type) AS count_ride_type, ride_type, user_type
FROM bikes_new
GROUP BY ride_type, user_type

-- SCREESHOT HERE --  
