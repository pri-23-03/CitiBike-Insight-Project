# Load necessary libraries
install.packages("dplyr")  # If not already installed
library(dplyr)

file_path <- "C:\\Users\\Priyanshu Rathee\\Documents\\JC-202306-citibike-tripdata.csv"

# Read the data from the CSV file into a data frame
citi_bike_data <- read.csv(file_path)

# View the first few rows of the data to verify it's loaded correctly
head(citi_bike_data)
col_names <- colnames(citi_bike_data)
print(col_names)



citi_bike_data_cleaned <- citi_bike_data[complete.cases(citi_bike_data), ]

# View the first few rows of the cleaned data to verify it
head(citi_bike_data_cleaned)
citi_bike_data$started_at <- as.POSIXct(citi_bike_data$started_at, format = "%Y-%m-%d %H:%M:%S")
citi_bike_data$ended_at <- as.POSIXct(citi_bike_data$ended_at, format = "%Y-%m-%d %H:%M:%S")

# Extract the day of the week and hour from the 'started_at' timestamp
citi_bike_data$day_of_week <- weekdays(citi_bike_data$started_at)
citi_bike_data$hour_of_day <- format(citi_bike_data$started_at, format = "%H")

# Group the data by day of the week and hour of the day and count the number of rides
rides_by_time <- citi_bike_data %>%
  group_by(day_of_week, hour_of_day) %>%
  summarize(total_rides = n())

# Find the peak riding times (e.g., top 3 hours with the highest number of rides)
peak_times <- rides_by_time %>%
  arrange(desc(total_rides)) %>%
  top_n(3)

# Display the peak riding times
print(peak_times)

# Implement targeted promotions or deals during peak riding times
# Your business logic and promotion strategies can be implemented here

# Example: Print a message for the top 3 peak hours
for (i in 1:nrow(peak_times)) {
  message(paste("Peak riding time on", peak_times$day_of_week[i], "at", peak_times$hour_of_day[i], "with", peak_times$total_rides[i], "rides."))
}

