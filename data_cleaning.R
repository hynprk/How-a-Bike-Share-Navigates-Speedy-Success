#### Data Cleaning ####

## Libraries ##
library(tidyverse) # for data wrangling, data vis, etc.
library(lubridate) # for dates
library(geosphere) # for distance
library(knitr)     # for kable 


## Import Data ##
# Combined csv datasets based on instructions from:
# https://statisticsglobe.com/merge-csv-files-in-r
bikeshare <- list.files(path="data", full.names = T) %>% 
  lapply(read_csv) %>% 
  bind_rows()

# Check number of NA values in each columns
# approximately 20.7% had NA values
lapply(bikeshare, function(x){sum(is.na(x))}) %>% as.tibble() %>% kable()

## Data Wrangling ##
# Creating new variables:
# `travel_time`: total travel time for a ride
# `weekday`: the weekday a rider rented a bike
# `started_date_only`: extracted start date (yyyy-mm-dd)
# `travel_dist`: total distance traveled for a ride
bikeshare <- bikeshare %>% 
  mutate(started_date_only = as.Date(started_at),
         day_of_week = weekdays(started_at),
         travel_time = difftime(ended_at, started_at), # in minutes
         travel_dist = distGeo(cbind(start_lng, start_lat), 
                               cbind(end_lng, end_lat))/1000) %>% # in kilometers
  filter(!is.na(travel_dist))

# Random sample 
set.seed(408)
bikeshare_samp <- bikeshare[sample(nrow(bikeshare), size = nrow(bikeshare)*0.7), ]


# New data set: Number of travels per day
daily_travels <- bikeshare_samp %>% group_by(started_date_only, member_casual) %>% 
  summarize(num = n(), avg_time = mean(travel_time), avg_dist = mean(travel_dist)) %>%
  as_tibble() # Number of travels per day by rider type stored



## Export into csv file ##
write.csv(bikeshare_samp, "data/bikeshare_samp.csv")
write.csv(daily_travels, "data/daily_travels.csv")

