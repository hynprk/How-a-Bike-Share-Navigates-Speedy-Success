#### Data visualization ###

## How are casual riders different from annual members? ##

### Weekday they ride the bike
weekday_order <- c("Monday", "Tuesday", "Wednesday", 
                   "Thursday", "Friday", "Saturday", "Sunday")
weekday_plot <- bikeshare_samp %>% 
  ggplot(aes(x = factor(weekday, level = weekday_order),
             fill = member_casual)) + 
  geom_bar() + 
  theme_minimal() +
  theme(axis.text.x  = element_text(angle = 45)) +
  labs(title = "Bike-Share Users per Weekday",
       subtitle = "Period: 2021/07 - 2022/06",
       x = "Weekday",
       y = "Count")
weekday_plot + scale_fill_brewer(palette = "Dark2", name= " ")
## Observations: 
### 1. Saturday has the max count
### 2. During the weekdays, members use bikes more than causal users
### - This could be related to commute
### 3. During the weekends, there are more casual riders

### Time of the year they ride the bike
month_order <- c("July", "August", "September", "October", 
                 "November", "December", "January", "February", 
                 "March", "April", "May", "June")
bikeshare_samp %>% 
  ggplot(aes(x = factor(months(started_at), level = month_order),
             fill = member_casual)) + 
  geom_bar() + 
  theme_minimal() +
  theme(axis.text.x  = element_text(angle = 45)) +
  labs(title = "Bike shares per month",
       subtitle = "2021/07 - 2022/06",
       x = "Month",
       y = "Count")
## Observations:
### 1. Riders drastically decrease during winter
### - However, there are proportionally more annual members than casual users
### - Can be related to type of bikes
### 2. A lot of riders during summer

### Rideable type
bikeshare %>% group_by(member_casual, rideable_type) %>% 
  summarize(n = n()/nrow(bikeshare))

### How long they ride the bike

### How far they ride the bike
