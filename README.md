# How Does a Bike-Share Navigate Speedy Success?
## Marketing Analytics Team at Cyclistic
*Last modified: July 31, 2022*

### I-i. About the Company
**Cyclistic** is a hypothetical bike-share company in Chicago founded in 2016, featuring 5,800 bicycles and 600 docking stations. To foster inclusivity for diverse groups of customers, Cyclistic not only offers conventional two-wheeled bicycles, but also hand tricycles, reclining bicycles, and cargo bicycles. According to Cyclistic's bike trip data, approximately 30% of the bike-share users use the bikes to commute to work. 

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/images/bikeshareinchicago.jpg"></b><br>
  <a href="https://connect.bcbsil.com/health-and-wellness/b/weblog/posts/on-a-roll-bike-share-programs-expand-across-the-country">Image Source</a>
</p>

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

After unzipping the data of twelve most recent months from [here](https://divvy-tripdata.s3.amazonaws.com/index.html), we aggregated them into one single dataframe and stored it into `bikeshare`. At this stage, we notice that there are several missing values, i.e., NA, within the aggregated data, as shown in Table 1 below. Missing values can potentially raise issues when determining the most frequently used station names and calculating the total distance traveled per ride by using latitudes and longitudes. Hence, we will omit the 5,374 rows from our analysis with missing end latitudes and longitudes.


Table 1: Missing Values for Each Column


Ride ID | Bike type | Started | Ended | Start Station | Start Station ID | End Station | End Station ID | Start Latitude | Start Longitude | End Latitude | End Longitude | Member or Casual 
--- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- |--- |---
0 | 0 | 0 | 0 | 836018 | 836015 | 892103 | 892103 | 0 | 0 | 5374 | 5374 | 0

To prepare for our analysis, we created four new variables:

* `travel_time`: Total travel time per ride (in seconds); Calculated by `difftime(ended_at, started_at)`
* `day_of_week`: Day of a week of the ride (Mon-Sun)
* `started_date_only`: extracted start date from `started_at` without specific time (yyyy-mm-dd format)
* `travel_dist`: total distance traveled for a ride (in kilometres); Calculated by `distGeo(cbind(start_lng, start_lat), cbind(end_lng, end_lat))/1000` 

For the sake of time efficiency, we randomly sampled 70% of the population by using the `sample()` function. This ensures sampling bias does not take place in our analysis and we can safely make inferences for the population from our results. Please make sure to set.seed(##your favourite number##) so that the sample does not change every time you run the code.

### V. Data Visualizations and Key Findings

Recall that our business task is to identify the differences between casual riders and annual members and make data-driven recommendations. Based on our objective, we can first calculate the average daily percentage of number, time, and distance of travels for the two customer groups, as shown in Table 2.

Table 2: Average Daily Percentage for Casual Riders and Annual Members

Rider Type | Number of Travels | Time Spent | Distance Traveled
--- | --- | --- | ---
Casual | 43% | 65% | 52%
Member | 57% | 35% | 48%

We notice that:

* Annual members use the bikes 14% more on average than casual riders. 
* On the other hand, casual riders spend 30% more time and travel 4% further than annual members, on average.

Moving forward, we will take a look at the distribution of users per day of week, as shown in Figure 1.

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/fig1.jpeg">
</p>

We observe that:

* There are more annual members during the weekdays (Mon-Fri), which could potentially be related to commuting to work/school, etc.
* There are more casual riders over the weekends (Sat-Sun)
* Saturday has the maximum number of bike-share users (i.e., mode), followed by Sunday

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/fig2.jpeg">
</p>

Next, we can take a look at the rider distribution by month, from July 2021 to June 2022.

* Number of users drastically decrease during winter (Dec-Feb) and the proportion of annual members relatively increase compared to casual users.
* Number of users gradually start increasing in March, and peaks in summer and early fall (June-Sep) with the mode of month being July, followed by August. This could be due to the warm weather and vacation season. 

When comparing the types of bicycles used between casual users and annual members (See Figure 3), we see that both casual and annual riders use classic bikes more than electric bikes, although the difference between classic and electric bikes is subtle within the casual group. Also, it seems that docked bicycles are only offered for casual riders since there seems to be no docked bike users within annual members.

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/fig3.jpeg">
</p>

Then, another data we want to take a look at is the Top 10 start stations used by all riders. According to Figure 4, Streeter Dr & Grand Ave has the highest number of users, where approximately 79% of them are casual riders. Having various sight seeing locations and a lot of parks nearby Streeter Dr & Grand Ave, such as Milton Lee Olive Park, Lake View Park, Maggie Daley Park, and Millennium Park could be the reason for this. 

![Figure 4](https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/fig4.png)

Finally, we would like to present a dashboard we created. Below is a preview of the dashboard, and the interactive version can be viewed [here](https://public.tableau.com/app/profile/hyoeunpark99/viz/Annualmembersvs_CasualridersinBikeShare/DifferencebetweenBike-ShareofAnnualmembersandCasualriders_1) (Right click to view in a new tab). You can hover over the graphs, click on graphs, or use the filter on the bottom-right to see any specific values. 

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/dashboard.png">
</p>

### VI. Summary of Analysis

* There are more casual riders than annual members during the weekends (Sat-Sun) and summer (Jul-Aug).
* Annual members use bikes more during the weekdays.
* On average, casual riders travel longer (time) and further (distance) than annual members.
* Both casual and annual riders use classic bikes more than docked or electric bikes.
* Streeter Dr & Grand Ave has the highest number of users, where approximately 79% are casual riders.

### VII. Recommendations

#### VII-i. Recommendation 1: Exclusive Promotions during the Summer 🌞😎🍦

We have clearly seen from Figure 2 and the line graph from the dashboard that users, especially casual riders, drastically increase during the summer. The season would be a great opportunity to promote annual subscriptions via Instagram, Facebook, Tik Tok, or Google Maps with irresistible digital food coupons, like ice-creams or fresh drinks from a fast-food restaurant. This would require Cyclistic to partner with the restaurant. However, note that this could potentially cause an increase in environmental pollution from disposable products. 

Considering the fact that tourists increase during the summer and that there are various tourist attractions (e.g., parks, museums, universities, beaches, harbours) around the most popular start station, Streeter Dr & Grand Ave, we can offer summer coupons affiliated with such attractions as an alternative. Moreover, a digital map with various tourist attractions and bike stations nearby would help the potential bike users understand that these attractions can be visited with bicycles. This digital map can be accessible through Cyclistic's social media or QR codes at every station to decrease the amount of physical copies. Although tourists might have a lower chance of subscribing as an annual member, promoting such ideas would still increase the chance of them using Cyclistic's bikes, and hence increase the revenue of Cyclistic.

#### VII-ii. Recommendation 2: Weekend / Weekday Deals 🚴🏻👯🌤

Since a lot of casual riders use bikes during the weekends, we can provide an exclusive weekend discount for the annual subscription if they subscribe instead of an one-time ride. We can also create an annual weekend package, which would be cheaper than the original annual subscription so that the users that only bike-share for the weekends would not feel overwhelmed with the usual annual subscription price. After they make the subscription, Cyclistic can offer them a chance to enter a raffle for prizes if they refer the annual subscription to their friends. That way, the company can reach a larger audience and attract more potential annual members. 

According to Figure 1, we have seen that the proportion of annual members are greater than casual riders during the weekdays. This implies that they could be using it for work-related purposes, such as commuting. Hence, we can promote an annual weekday subscription that is cheaper than a typical annual payment for using public transportation. However, note that we would have to further investigate the specific time frames the bikes were used during the weekdays to ensure that our assumption is valid regarding work and commute.

#### VII-iii. Recommendation 3: Campaign for Saving the Earth 🌍🌳🍃

A company with a good purpose will captivate more customers. Using Cyclistic's social media accounts and bike-share stations, we can promote the benefits of bike-share. The bike stations for advertising this campaign can be chosen based on the number of parks around stations, number of casual riders per station, or the top 10 start stations we have seen in Figure 4. The benefits of bike-share would majorly include protecting our planet by reducing gas emissions or less air pollution from cars and developing a healthier life style. Conjoining the two ideas, we can promote a campaign for saving the earth. This includes hosting an event of picking up trash on the streets while riding Cyclistic's bikes, or planting a tree for every certain number of posts with Cyclistic's bike-share on social media. During events, participants will be asked to fill out optional surveys regarding bike-share and the campaign, which would allow them to enter in raffles for environment-friendly prizes. This could potentially increase the number of new annual subscribers.

<p align="center">
  <img src="https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/images/bike.png"></b><br>
  <a href="https://www.flaticon.com">Image Source</a>
</p>


### VIII. Limitations and Next Steps

As mentioned in *Section IV*, there were numerous missing values for station names and latitudes or longitudes. This could have potentially led to missing out on some significant information in the data. However, considering the fact that the stations and their corresponding latitudes or longitudes are almost fixed, we can possibly use the station names to fill in the missing latitudes or longitudes, and vice versa. This would need to be further investigated, but this would be a great way to improve the missing values during the data cleaning process. 

On top of that, we can investigate what time the bikes were used by annual members during the weekdays. This can help us identify the potential purposes of annual members using bike-share, which would be beneficial in developing new marketing strategies for annual subscriptions. As an alternative, we can ask annual subscribers to opt in for a follow-up survey to ask about their preferences. Here, we have to make sure that we respect their privacy and consent in collecting their survey data. Moreover, choice of words for the survey questions should be careful enough to eliminate any bias that might arise in the answers.

Finally, we can use SQL next time for cleaning and manipulating the data. This would potentially make the process faster since SQL tools are typically made for handling large databases. 

### IX. Appendix

#### IX-i. Figure a: Proportion of Annual Members and Casual Riders

![Figure a.](https://github.com/hynprk/How-a-Bike-Share-Navigates-Speedy-Success/blob/main/data_vis/user_ratio.png)



