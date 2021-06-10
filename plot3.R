# Plot 2: Line Plot
# x axis = time (over two days), y axis = global active power
# consists of multiple lines overlayed in different colours, with legend

# a. read-in dataset
power_data <- read.table("../ExData_Data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# b. filter/tidy the dataset (using chained dplyr library functions)
library("dplyr")
power_data <- filter(power_data, Date == "1/2/2007" | Date == "2/2/2007") %>% # keep only rows where date matches ones we're interested in
  unite(DateTime, Date, Time) %>% # combine the Date and Time columns (concatenate two strings into one, separated by an underscore)
  mutate(DateTime = as.POSIXct(DateTime, format = "%d/%m/%Y_%H:%M:%S")) %>% # covert the new string into a valid POSIXct date/time data type
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>% 
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>% 
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) # convert the three Sub_metering columns from 'character' to 'numeric'

# c. plot the data (to a file)
png(filename="plot3.png", width = 480, height = 480, unit = "px") # open the file
plot(power_data$DateTime, power_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(power_data$DateTime, power_data$Sub_metering_2, col = "red")
lines(power_data$DateTime, power_data$Sub_metering_3, col = "blue")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "blue", "red"))
dev.off() # close the file