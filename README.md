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


## 1. Where is the data located?

We will be using Cyclistic's historical data to analyse and identify trends. The data for the case study can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html).


## 2. How is the data organized?

The data is organized by months, quarters and years. At the time of completion, the latest data available for the last 12 months being considered is March 2024 to February 2025.


## 3. Are there issues with bias or credibility in this data? Does the data ROCCC?

It is confirmed that the data used satisfies the ROCCC criteria since its officially permitted for use under proper authorized [license](https://www.divvybikes.com/data-license-agreement). The data is Reliable, Original, Comprehensive, Current, and Cited.


## 4. How do we address licensing, privacy, security, and accessibility?

The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). It can be confirmed that this is public data that can be used to explore how different customer types are using Cyclistic bikes. 

**Data Privacy Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and allow us to answer the business questions. Also, due to data-privacy concerns, no personally identifiable information is available/used in this data set.**


## 5. How do we verify the data’s integrity?

The data used satisfies its data intergrity criteria as it is unbiased. No personal information on riders is available, and its comprised of all bike trips recorded during a given time period.


## 6. Are there any problems with the data?

The data contains several NULL values which shall be addressed during the data cleaning process.



