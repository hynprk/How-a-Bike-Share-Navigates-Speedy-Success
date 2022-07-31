#### Data Cleaning ####

## Libraries ##
library(tidyverse) # for data wrangling, data vis, etc.
library(lubridate) # for dates
library(geosphere) # for distance

## Import Data ##
# Combined csv datasets based on instructions from:
# https://statisticsglobe.com/merge-csv-files-in-r
bikeshare <- list.files(path="data", full.names = T) %>% 
  lapply(read_csv) %>% 
  bind_rows()

#write.csv(bikeshare, "bikeshare_raw.csv") takes too much space

## Data Wrangling ##
# Creating new variables
# `travel_time`: total travel time for a ride
# `started_date_only`: extracted start date (yyyy-mm-dd)
# `travel_dist`: total distance traveled for a ride
bikeshare <- bikeshare %>% 
  mutate(started_date_only = as.Date(started_at),
         travel_time = seconds_to_period(ended_at - started_at), # in minutes
         travel_dist = distGeo(cbind(start_lng, start_lat), 
                               cbind(end_lng, end_lat))/1000) # in kilometers

# New data set: Number of travels per day
num_travels <- bikeshare %>% group_by(started_date_only, member_casual) %>% 
  summarize(num = n()) # Number of travels per day by rider type stored
# Average number of travels
num_travels %>% group_by(member_casual) %>% summarize(mean = mean(num))

write.csv(bikeshare, "bikeshare.csv")





## How are casual riders different from annual members? ##
### Time of the year they ride the bike

### Rideable type
bikeshare %>% group_by(member_casual, rideable_type) %>% 
  summarize(n = n())

### How long they ride the bike


