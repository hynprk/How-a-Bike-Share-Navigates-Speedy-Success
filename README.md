# How Does a Bike-Share Navigate Speedy Success?
## Marketing Analytics Team at Cyclistic
*Last modified: July 31, 2022*

### I-i. About the Company
**Cyclistic** is a hypothetical bike-share company in Chicago founded in 2016, featuring 5,800 bicycles and 600 docking stations. To foster inclusivity for diverse groups of customers, Cyclistic not only offers conventional two-wheeled bicycles, but also hand tricycles, reclining bicycles, and cargo bicycles. According to Cyclistic's bike trip data, approximately 30% of the bike-share users use the bikes to commute to work. 

### I-ii. Goal of the Design Marketing Strategy
The key stakeholder, Lily Moreno, or the director of marketing at Cyclistic, hypothesizes that increasing the number of annual membership bike-share users will lead to a greater success of the company. Hence, the ultimate goal of the marketing team is to recommend new marketing strategies to convert casual riders into annual members by scrutinizing data insights with captivating data visualizations. The new marketing strategies will be developed based on the three questions below:

1. How do annual members and casual riders use Cyclistic bicycles differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

The case study will focus on the first question for the data analysis.

### II. Business Task
A business task is a question we want to answer through data analysis and make data-driven decisions for business strategies. In this scenario, the business task is to analyze Cyclistic's rider data from the previous 12 months to identify the difference between casual riders and annual members.

### III. Data Source
Cyclistic's historical trip data from the past 27 months is accessible [here](https://divvy-tripdata.s3.amazonaws.com/index.html). This is a public, open dataset provided by Motivate International Inc. under the [Data License Agreement](https://ride.divvybikes.com/data-license-agreement). Note that the purchases in the data set are not linked to credit card information to ensure privacy of users.

### IV. Data Cleaning and Manipulation

We mainly used R in R Studio to clean and manipulate the data. Although SQL is more appropriate when dealing with large data bases like the large file size of the aggregated data we have, the SQL tools we have access to were unable to deal with the large file size. All the data cleaning and manipulating process is saved as [`data_cleaning.R`](https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_cleaning.R) with comments. The libraries we used are the following:

```{r}
library(tidyverse) # for data wrangling, data vis, etc.
library(lubridate) # for dates
library(geosphere) # for distance
library(knitr)     # for kable 
```

After unzipping the data of twelve most recent months from [here](https://divvy-tripdata.s3.amazonaws.com/index.html), we aggregated them into one single dataframe and stored it into `bikeshare`. At this stage, we notice that there are several missing values, i.e., NA, within the aggregated data, as shown in Table 1 below. Missing values are not an issue for station names since we are not planning to incorporate specific station names into our analysis; however, missing latitudes and longitudes can rise problems when we calculate the total distance traveled per ride. Hence, we will omit the 5,374 rows from our analysis with missing end latitudes and longitudes.

<p align="center">
Table 1: Missing Values for Each Column
</p>

Ride ID | Bike type | Started | Ended | Start Station | Start Station ID | End Station | End Station ID | Start Latitude | Start Longitude | End Latitude | End Longitude | Member or Casual 
--- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- |--- |---
0 | 0 | 0 | 0 | 836018 | 836015 | 892103 | 892103 | 0 | 0 | 5374 | 5374 | 0

To prepare for our analysis, we created four new variables:

* `travel_time`: Total travel time per ride (in seconds); Calculated by `difftime(ended_at, started_at)`
* `weekday`: The weekday of the ride (Mon-Sun)
* `started_date_only`: extracted start date from `started_at` without specific time (yyyy-mm-dd format)
* `travel_dist`: total distance traveled for a ride (in kilometres); Calculated by `distGeo(cbind(start_lng, start_lat), cbind(end_lng, end_lat))/1000` 

For the sake of time efficiency, we randomly sampled 70% of the population by using the `sample()` function. This ensures sampling bias does not take place in our analysis and we can safely make inferences for the population from our results. 

### V. Summary of Analysis

### VI. Data Visualizations and Key Findings

Below is a preview of the dashboard I created. The interactive version can be viewed [here](https://public.tableau.com/app/profile/hyoeunpark99/viz/Annualmembersvs_CasualridersinBikeShare/DifferencebetweenBike-ShareofAnnualmembersandCasualriders_1). You can hover over the graphs, click on graphs, or use the filter on the bottom-right to see any specific values.

![Dashboard Preview](https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/dashboard.png)

### VII. Recommendations

#### VII-i. Recommendation no.1

#### VII-ii. Recommendation no.2

#### VII-iii. Recommendation no.3

### Limitations of the Analysis


