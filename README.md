# Google-Data-Analytics-Capstone-Cyclistic-Case-Study


## Introduction

This case study is based on the Google Data Analytics Capstone Course from Coursera, where I selected the Cyclistic Bike-Share Analysis Case Study as per Track A to complete the Capstone course towards earning my Google Data Analytics Professional Certificate. I will be discussing on the data compilation and pre-cleaning activities, followed by cleaning, as well as the analysis itself. The tools used in this case study will be SQL (PostgreSQL) and Tableau (Public).


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

It is confirmed that the data used satisfies the ROCCC criteria since its officially permitted for use under proper authorized [license](https://www.divvybikes.com/data-license-agreement). The data is Reliable, Original, Comprehensive, Current, and Cited.


### 4. How do we address licensing, privacy, security, and accessibility?

The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). It can be confirmed that this is public data that can be used to explore how different customer types are using Cyclistic bikes. 

**Data Privacy Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and allow us to answer the business questions. Also, due to data-privacy concerns, no personally identifiable information is available/used in this data set.**


### 5. How do we verify the data’s integrity?

The data used satisfies its data intergrity criteria as it is unbiased. No personal information on riders is available, and its comprised of all bike trips recorded during a given time period.


### 6. Are there any problems with the data?

The data contains several NULL values which shall be addressed during the data cleaning process.


## Process 

In this phase, the data was downloaded for the last 12 months. At the time of completion, the latest data available for the last 12 months being considered is March 2024 to February 2025.


### For combining the data in each file, PostgreSQL is used and the following steps are carried out:

1. A database titled **'divvy_bikes'** is created
2. A table titled **'bikes_new'** is created within the database by specifying each column name and its data type.
3. The 12 .csv files are imported into the **'bikes-new'** table one by one to merge the data into a single table.


### Upon merging the files together, we move on to the cleaning phase where we first perform preliminary actions on the data through SQL, including:

1. Adding a **'ride_length'** column to the table.
2. Add values to **'ride_length'** column by subtracting **'ended_at'** values from **'started_at'**. This will calculate the total trip duration in **hh:mm:ss** format.
3. Add columns titled **'day_of_week'** and **'day_of_week_name'** to the table.
4. Add values to the **'day_of_week'** and **'day_of_week_name'** columns - Here, **'day_of_week'** will contain numeric values (i.e. for Sunday, it would contain 0, for Monday = 1, and so on), while **'day_of_week_name'** will contain the name of the day itself (Eg: Sunday, Monday, and so on).
5. Add a column tilted **'month_name'** to the table.
6. Add values to the **'month_name'**. These would be - February, March, April, and so on.
7. Add a column titlted **'year_name'** to the table.
8. Add values to the **'year_name'** column - i.e. 2024 and 2025, based on the trip start dates in the **'started_at'** column.


### After the above steps, a series of comprehensive data cleaning processes are performed as follows:

1. Checking the number of letters in **'ride_id'** column to make sure it is unique. It is concluded that all results here are 16, i.e. all ride IDs are 16 characters long.
2. Identification and deletion of duplicate rows (if any) from the **'bikes_new'** table based on the **'ride_id'**.
3. Checking for NULL values where **start_station_name**, **start_station_id**, **end_station_name** and **end_station_id** are all NULL.
4. Checking and removing any rows where **start/end_lat** or **start/end_lng** are NULL, since each ride record (row) should have location coordinates.
5. Checking null values in **start_station_name**.
6. Checking null values in **start_station_id**.
7. Checking null values in **end_station_name**.
8. Checking null values in **end_station_id**.
9. Checking if there are only 2 user types in the **user_type** column. It is confirmed that only **'casual'** and **'member'** user types exist.


### We then move on the check for outliers;

1. Checking for rides that are less than or equal to 1 minute in **ride_length**. It is found that a total of 129085 rows meet this criteria. Hence they are removed from the table. 
2. Checking for rides that are greater than or equal to 1 day in **ride_length**. It is found that a total of 295 rows meet this criteria. Hence they are removed from the table.

### We then check the start/end_station_name/id columns for naming inconsistencies. 

It is found that 1805 such rows exist with 'null' being the most common value with a count of 1010771. We also notice some station names are similar, with some ending with *. We will investigate this later. 

### We then check how many of these nulls are in **end_station_name** column for **classic_bike** trips. 

Since classic bike trips must end at a docking station, the **end_station_name** should not be null. Electric bikes having a bike lock option do not have this problem, as they do not have to start/end the ride at a docking station.

It is found that 27 such rows exist in the table, and they are removed.

### New Total Rows: 56,46,778

### Original number of rows were: 57,83,100

### Total 1,36,322 rows removed


### Now we check again for the previous query, but this time with **end_station_id** being NULL. 

No results are found.

### We then check again for the previous query, but this time with **start_station_name** being NULL

No results are found. It appears that we have cleaned the data for all classic bikes. To double check this, we run a query to check the distinct ride types where start_station_name is NULL. It should only return **electric_bike/electric_scooter**. 

Result: electric_bike and electric_scooter -- Just as we expected.

### We then check again for the previous query, but this time with **start_station_id** being NULL

Result: electric_bike and electric_scooter -- Just as we expected. So it can be confirmed that we have cleaned the data for classic and electric bikes/scooters.


### Now, we proceed to update the NULL values in start_station_name and end_station_name for electric_bike and electric_scooter ride types to "On Bike Lock State" and "On Scooter Lock State" respectively.

1. First we check **start_station_name**, for **electric_bike**

Total Rows Found: 946482

Now, we update these rows to set **start_station_name** to **'On Bike Lock State'**


2. Next we check the same for **end_station_name**, for **electric_bike**

Total Rows Found: 948718

Now, we update these rows to set **end_station_name** to **'On Bike Lock State'**


3. Next, we check the same for **start_station_name**, for **electric_scooter**

Total Rows Found: 64289

Now, we update these rows to set **start_station_name** to **'On Scooter Lock State'**


4. Finally, we we check the same for **end_station_name**, for **electric_scooter**

Total Rows Found: 64767

We update these rows to set **end_station_name** to **'On Scooter Lock State'**


Finally, we check if there are any nulls left in **start_station_name** or **end_station_name**. No rows meeting this criteria are found, so it is safe to conclude that all null station names have been replaced with relevant values.


### We also check the no. of rides of each type and the no. of rides of each type per user type. The results can be see below:

--SCREENSHOTS TO BE INSERTED HERE--


**After the above cleaning procedures, we draw the following observations:**

1. Original number of rows were: 57,83,100
2. Total 1,36,322 rows removed
3. Final New Total Rows: 56,46,778


## Analyse 

In this phase, we begin our analysis of the data.






