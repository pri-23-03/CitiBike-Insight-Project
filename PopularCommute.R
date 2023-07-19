install.packages(c("dplyr", "lubridate", "ggplot2", "kableExtra"))  # If not already installed
library(dplyr)
library(lubridate)
library(ggplot2)
library(kableExtra)


file_path <- "C:\\Users\\Priyanshu Rathee\\Documents\\JC-202306-citibike-tripdata.csv"

citi_bike_data <- read.csv(file_path)

# Convert date and time columns to appropriate data types
citi_bike_data$started_at <- as.POSIXct(citi_bike_data$started_at, format = "%Y-%m-%d %H:%M:%S")
citi_bike_data$ended_at <- as.POSIXct(citi_bike_data$ended_at, format = "%Y-%m-%d %H:%M:%S")

# Filter the data for morning (6am-9am) and evening (5pm-7pm) commuting hours
morning_commuting <- citi_bike_data %>%
  filter(hour(started_at) >= 6, hour(started_at) <= 9)

evening_commuting <- citi_bike_data %>%
  filter(hour(started_at) >= 17, hour(started_at) <= 19)

# Calculate the most commonly used start stations during morning commuting hours
popular_morning_stations <- morning_commuting %>%
  group_by(start_station_name) %>%
  summarize(total_rides = n()) %>%
  arrange(desc(total_rides)) %>%
  head(10)

# Calculate the most commonly used start stations during evening commuting hours
popular_evening_stations <- evening_commuting %>%
  group_by(start_station_name) %>%
  summarize(total_rides = n()) %>%
  arrange(desc(total_rides)) %>%
  head(10)

# Display the popular stations for morning and evening commuting hours
print(kable(popular_morning_stations, caption = "Top 10 Popular Start Stations during Morning Commuting Hours", col.names = c("Start Station", "Total Rides"), format = "html"))
print(kable(popular_evening_stations, caption = "Top 10 Popular Start Stations during Evening Commuting Hours", col.names = c("Start Station", "Total Rides"), format = "html"))
