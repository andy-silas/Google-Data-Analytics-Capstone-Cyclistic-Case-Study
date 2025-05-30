# Google-Data-Analytics-Capstone-Cyclistic-Case-Study


## Introduction

This case study is based on the Google Data Analytics Capstone Course from Coursera, where I selected the Cyclistic Bike-Share Analysis Case Study as per Track A to complete the Capstone course towards earning my Google Data Analytics Professional Certificate. I will be discussing the data compilation and preliminary checks, followed by cleaning, as well as the analysis itself. The tools used in this case study will be SQL (PostgreSQL) and Tableau (Public).

You can check out the full case-study article on Medium [here](https://medium.com/@andriyasrw/google-data-analytics-capstone-cyclistic-bike-share-case-study-e4e6dc42d169).


## About Cyclistic

We are given the role of a data analyst at a fictional company - 'Cyclistic', where we work along with other key team members. Cyclistic has a bike-share program that features more than 5,800 bicycles and 600 docking stations in Chicago, Illinois. Cyclistic users are categorised into 2 types: 

1. Casual Riders
2. Annual Members

The company's marketing executives suggest that the company’s future success depends on maximizing the number of annual memberships, and want to convert more casual riders to annual members. Therefore, the team wants to understand how casual riders and annual members use Cyclistic bikes differently. The goal is to provide compelling and meaningful data insights supported with professional and clear data visualizations to the executive team, so they can work on the next steps towards their marketing strategy.

In order to answer the business questions, we will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.


## Ask

In the Ask phase, we lay down the objectives of the case study, the target question and the business task.

**Target Question: How do annual members and casual riders use Cyclistic bikes differently?**

**Business Task: To identify the differences between members and casual riders on how they use Cyclistic's bike-share services differently in order to build strategies to convert casual riders to annual members.**


## Prepare

In the Prepare phase, we start to gather relevant and credible data for our analysis from a trusted source. We want to answer the following questions in this phase:


### 1. Where is the data located?

We will be using Cyclistic's historical data to analyse and identify trends. The data for the case study can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html).


### 2. How is the data organized?

The data is organized by months, quarters and years. At the time of completion, the latest data available for the last 12 months being considered is March 2024 to February 2025.


### 3. Are there issues with bias or credibility in this data? Does the data ROCCC?

The data meets the ROCCC criteria and is officially [licensed](https://www.divvybikes.com/data-license-agreement) and authorized for use. The data is Reliable, Original, Comprehensive, Current, and Cited.


### 4. How do we address licensing, privacy, security, and accessibility?

The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). It can be confirmed that this is public data that can be used to explore how different customer types are using Cyclistic bikes. 

**Data Privacy Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and allow us to answer the business questions. Also, due to data-privacy concerns, no personally identifiable information is available/used in this data set.**


### 5. How do we verify the data’s integrity?

The data used satisfies its data integrity criteria as it is unbiased. No personal information on riders is available, and its comprised of all bike trips recorded during a given time period.


### 6. Are there any problems with the data?

The data contains several NULL values which shall be addressed during the data cleaning process.


## Process 

In this phase, the data was downloaded for the last 12 months. At the time of completion, the latest data available for the last 12 months being considered is March 2024 to February 2025.

### For combining the data in each file, PostgreSQL is used and the following steps are carried out:

1. A database titled **'divvy_bikes'** is created
2. A table titled **'bikes_new'** is created within the database by specifying each column name and its data type.
3. The 12 .csv files are imported into the **'bikes-new'** table one by one to merge the data into a single table.

**NOTE: The SQL code for all the queries in the Process Phase can be found [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql).**

**Upon merging the files together, we move on to the cleaning phase where we first perform preliminary actions on the data through SQL (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L1)), including:**

1. Adding a **'ride_length'** column to the table.
2. Add values to **'ride_length'** column by subtracting **'ended_at'** values from **'started_at'**. This will calculate the total trip duration in **hh:mm:ss** format.
3. Add columns titled **'day_of_week'** and **'day_of_week_name'** to the table.
4. Add values to the **'day_of_week'** and **'day_of_week_name'** columns - Here, **'day_of_week'** will contain numeric values (i.e. for Sunday, it would contain 0, for Monday = 1, and so on), while **'day_of_week_name'** will contain the name of the day itself (Eg: Sunday, Monday, and so on).
5. Add a column titled **'month_name'** to the table.
6. Add values to the **'month_name'**. These would be - February, March, April, and so on.
7. Add a column titled **'year_name'** to the table.
8. Add values to the **'year_name'** column - i.e. 2024 and 2025, based on the trip start dates in the **'started_at'** column.


**After the above steps, a series of comprehensive data cleaning processes (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L59)) are performed as follows:**

1. Checking the number of letters in **'ride_id'** column to make sure it is unique. All ride IDs are confirmed to be 16 characters long.
2. Identification and deletion* of duplicate rows (if any) from the **'bikes_new'** table based on the **'ride_id'**.
3. Checking for NULL values where **start_station_name**, **start_station_id**, **end_station_name** and **end_station_id** are all NULL.
4. Checking and removing any rows where **start/end_lat** or **start/end_lng** are NULL, since each ride record (row) should have location coordinates.
5. Checking null values in **start_station_name**.
6. Checking null values in **start_station_id**.
7. Checking null values in **end_station_name**.
8. Checking null values in **end_station_id**.
9. Checking if there are only 2 user types in the **user_type** column. It is confirmed that only **'casual'** and **'member'** user types exist.

***NOTE: Upon inspecting the data, 422 duplicates are identified, where common trip records exist only in the months of May and June. These 422 records are removed accordingly using the query in the code, and the unique 211 records are reuploaded to the table after performing a VLOOKUP check on ride_id between the May and June data sets.** 

**We then move on to check for outliers to make sure the data analysis is not skewed due to them (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L156)):**

1. Checking for rides that are less than or equal to 1 minute in **ride_length**. It is found that a total of 129085 rows meet this criteria. Hence they are removed from the table. 
2. Checking for rides that are greater than or equal to 1 day in **ride_length**. It is found that a total of 295 rows meet this criteria. Hence they are removed from the table.

**We then check the start/end_station_name/id columns for naming inconsistencies (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L184)).**

It is found that 1805 such rows exist with 'null' being the most common value with a count of 1010771.

**We then check how many of these nulls are in **end_station_name** column for **classic_bike** trips (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L193)).**

Since classic bike trips must end at a docking station, the **end_station_name** should not be null. Electric bikes having a bike lock option do not have this problem, as they do not have to start/end the ride at a docking station.

It is found that 27 such rows exist in the table, and they are removed.

**New Total Rows: 5646778**

**Original number of rows were: 5783100**

**Total 136322 rows removed**

### Now we check again for the previous query, but this time with **end_station_id** being NULL (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L214)). 

No results are found.

### We then check again for the previous query, but this time with **start_station_name** being NULL

No results are found. It appears that we have cleaned the data for all classic bikes. To double check this, we run a query to check the distinct ride types where start_station_name is NULL. It should only return **electric_bike/electric_scooter**. 

Result: electric_bike and electric_scooter -- Just as we expected.

### We then check again for the previous query, but this time with **start_station_id** being NULL

Result: electric_bike and electric_scooter -- Just as we expected. So it can be confirmed that we have cleaned the data for classic and electric bikes/scooters.


**Now, we proceed to update the NULL values in start_station_name and end_station_name for electric_bike and electric_scooter ride types to "On Bike Lock State" and "On Scooter Lock State" respectively (see code [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/8967204d2673ad0194f14fb7b82290fd200917f7/Process%20Phase%20Code.sql#L244)).**

1. First we check **start_station_name**, for **electric_bike**

Total Rows Found: 946482

Now, we update these rows to set **start_station_name** to **'On Bike Lock State'**


2. Next we check the same for **end_station_name**, for **electric_bike**

Total Rows Found: 948718

Now, we update these rows to set **end_station_name** to **'On Bike Lock State'**


3. Next, we check the same for **start_station_name**, for **electric_scooter**

Total Rows Found: 64289

Now, we update these rows to set **start_station_name** to **'On Scooter Lock State'**


4. Finally, we check the same for **end_station_name**, for **electric_scooter**

Total Rows Found: 64767

We update these rows to set **end_station_name** to **'On Scooter Lock State'**


Finally, we check if there are any nulls left in **start_station_name** or **end_station_name**. No rows meeting this criteria are found, so it is safe to conclude that all null station names have been replaced with relevant values.


**We also check the no. of rides of each type and the no. of rides of each type per user type. The results can be seen below:**

--SCREENSHOTS TO BE INSERTED HERE--


**After the above cleaning procedures, we draw the following observations:**

1. Original number of rows were: 57,83,100
2. Total 1,36,322 rows removed
3. Final New Total Rows: 56,46,778


## Analyse 

In this phase, we conduct our analysis of the data using SQL queries by checking the following statistics to compare casual users and annual members based on the ride-type, trip duration and location:

1. Users by ride type
2. Number of rides per month
3. Number of rides per weekday
4. Number of rides per hour
5. Average ride duration per weekday
6. Average ride duration per month
7. Start station location for casuals
8. Start station location for members
9. End station for location for casuals
10. End station for location for members

**NOTE: The SQL code for all the queries in the Analyse Phase can be found [here](https://github.com/andy-silas/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/5c66638adefb926532c8aa0a96f68103bc60b0e4/Analyse%20Phase%20Code.sql).**


## Share

In this phase, we create visualizations using Tableau (Public). 

### Visualization 1: Users by ride type

For Viz no. 1 - we create a pie chart: [Total Rides - By User & Ride Type - Mar 24 to Feb 25](https://public.tableau.com/views/TotalRides-ByUserRideType-Mar24toFeb25-PieChart/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

We also create a bar chart for an alternate perspective: [Users By Ride Type - Mar 24 to Feb 25](https://public.tableau.com/views/UsersByRideType-Mar24toFeb25/UsersByRideType-Mar24toFeb25?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

Looking at the pie chart, it puts things into clear perspective for us to draw the following observations:

1. Members constitute of 63.5% of the total rides, while casual users comprise of 36.5%
2. It can be said that both casual users and members prefer electric bikes, where ~20% of total rides are electric rides by casual users (including both electric bike and electric scooter), while ~36% of total rides are electric rides by members (including both electric bike and electric scooter).
3. The classic bike share in casual users is 16.67% of total rides, while for members it is 29.44%.
4. Thus it can be said that members hold the majority in usage of both types of bikes.

### Visualization 2: Number of rides per month

For Viz no. 2, we create a bar chart: [Number of Rides Per Month - Mar 24 to Feb 25](https://public.tableau.com/views/NumberofRidesPerMonth-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

It can be observed that during peak summers of June, July, August and September, the casual riders maintain a fairly consistent usage share, but as we move towards the winter seasons of October and beyond, the usage share drops quite substantially in casual users, when compared to members.

### Visualization 3: Number of rides per weekday

For Viz no. 3, we create a bar chart: [Number of Rides Per Weekday - Mar 24 to Feb 25](https://public.tableau.com/views/NumberofRidesPerWeekday-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

A clear trend can be seen where the ride share is higher in members durring the working days, while it becomes more evenly matched between casuals and members during the weekends on Saturdays and Sundays.

### Visualization 4: Number of rides per hour

For Viz no. 4, we create a bar chart: [Number of Rides Per Hour - Mar 24 to Feb 25](https://public.tableau.com/views/NumberofRidesPerHour-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

1. Usage by members increases sharply between the office/college commute hours of 6:00 AM - 8:00 AM and 4:00 PM - 6:00 PM, followed by a steady drop in usage during the rest of the day.
2. Usage by casuals increases and decreases at much more steady and consistent rates, suggesting most of their usage for leisure instead of work/college commute. 

### Visualization 5: Average ride duration per weekday

For Viz no. 5 - Average ride duration per weekday, we calculate the total ride duration in minutes by converting seconds to minutes in excel:

1. First we extract the minutes from the 'avg_trip_duration' column using the MINUTE() function in excel, in the 'mins' column
2. Second, we extract the seconds from the 'avg_trip_duration' column using the SECOND() function in excel, in the 'seconds' column
3. Then we convert the seconds to minutes by dividing them by 60 and rounding them to 2 decimal places, in the 'seconds_to_mins' column.
4. Finally, we calculate the total minutes in 'total_mins' column by adding 'mins' column with 'seconds_to_mins'.
5. Then we create the viz in Tableau using a horizontal bar chart: [Average Ride Duration Per Weekday - Mar 24 to Feb 25](https://public.tableau.com/views/AverageRideDurationPerWeekday-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

Clearly, it can be observed that the annual members' average trip durations are very much consistent and similar during the working days, while the casual users have consistently much longer trips, specially on the weekends when the difference in average trip duration becomes much more considerable (nearly 2x).

### Visualization 6: Average ride duration per month

For Viz no. 6 - Average ride duration per month, we do the same steps as above: [Average Ride Duration Per Month - Mar 24 to Feb 25](https://public.tableau.com/views/AverageRideDurationPerMonth-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

In this viz, it can once again be clearly seen that the usage is based on the weather conditions for both user types, where trip durations remain consistent among annual members, once again signaling their usage for work or college commute throughout the year, while casual users are seen taking much longer rides, nearly 2x longer than annual members during peak summer months of May, June and July, most likely for leisure.

**For the following visualizations, we use maps to look only at the top 10 locations to get an idea of the most popular locations among each user type:**

### Visualization 7: Start station location for casuals

For Viz no. 7, see the map [here](https://public.tableau.com/views/Top10MostPopularStartStationsforCasualRiders-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

This highlights the top 10 start stations for casuals, where all of them are noteworthy locations for leisure and tourism, such as Theater on the Lake, Shedd Aquarium, Adler Planetarium and more.

### Visualization 8: Start station location for members

For Viz no. 8, see the map [here](https://public.tableau.com/views/Top10MostPopularStartStationsforMemberRiders-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

We can observe that members are utilising these stations primarily for work, school or college commute due to the landmarks in the vicinity of the stations such as apartments, banks, colleges and commercial businesses and offices in the city's financial district hotels etc. in the district near Wells St & Concord Ln, Clark St & Elm St, Wells St & Elm St, Kingsbury St & Kinzie St and more.

### Visualization 9: End station for location for casuals

For Viz no. 9, see the map [here](https://public.tableau.com/views/Top10MostPopularEndStationsforCasualRiders-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The observations are again consistent with the analysis that casual riders are more focussed on popular tourist spots, shopping centers, city views, etc. as highlighted in Viz no. 7.

### Visualization 10: End station for location for members

For Viz no. 10, see the map [here](https://public.tableau.com/views/Top10MostPopularEndStationsforMemberRiders-Mar24toFeb25/Sheet1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

The observations are again consistent with the analysis that annual members are using the services for their daily commute, as highlighted in Viz no. 8. 


### From our detailed analysis above using the visualizations, we can draw the following conclusions:

### Casual Users:

1. They are mainly focussed on using the bike-sharing services for leisure and recreational purposes.
2. Their main choices are the city's popular tourist spots, shopping centers, etc. Their average ride duration (19.12 minutes) is consitently nearly 2x when compared to annual members.
3. Their usage peaks during spring (March - May) and summers (June - August) when its ideal for such activities.
4. Most of their rides start between 10:00 AM - 12:00 PM, growing consistently in the following hours and reaching a peak between 4:00 PM - 6:00 PM 

### Annual Members:

1. They are more focussed on using the bike-sharing services for their daily commute rides to work/school/college.
2. Their average ride duration (11.84 minutes) is also much more consistent throughout the year and nearly half when compared to that of casual users, again reinforcing the previous observation.
3. The number of rides taken is much more consistent throughout the year when compared to casual users.
4. The usage is notably higher during the winter months of November - February, where a sharp decline in total rides is observed among casual users.


## Act

Given the above observations and conclusions on the differences in usage of the bike-sharing services between casual users and annual members, the following recommendations can be provided to the marketing team in order to develop strategies to convert more casual users to annual members:

1. The top 10 stations as shown can be targeted for advertising annual membership benefits.
2. The company can also advertise near popular tourist spots for better visibility. 
3. Advertisements in public transport can be increased around both popular commute routes for work/schools/colleges as well as tourist spots in order to target potential casual users who may not be using the service yet, and then in turn target them for annual memberships.
4. Additional perks, such as weekend free passes and free membership trials can be provided to try and convert the casual users.
5. A bonus number of rides/increased ride limits can be offered as additional benifts for current members to retain them and keep them engaged.
6. A survey campaign can be launched with perks associated, such as ride passes or a percentage discount for membership purchase/renewals, in order to gather user feedback from both casual users and annual members on how the services can be improved.


This case study was a great opportunity for learning and developing my data analytics skills, as well as putting them to good use. Thank you for valuable time in going through my analysis on this case-study. 
