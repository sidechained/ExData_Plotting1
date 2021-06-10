# Plot 4: Comparative Line Plots
# Consisting of four plots, as follows:
# TOPLEFT:     x = datetime (unlabelled), y = global active power [identical to Plot 2]
# BOTTOMLEFT:  x = datetime (unlabelled), y = sub metering (3 plots) [identical to Plot 3]
# TOPRIGHT:    x = datetime (labelled), y = voltage
# BOTTOMRIGHT: x = datetime (labelled), y = global reactive power
# if total plot = 480 * 480 px, each plot should = 120 * 120 px

# a. read-in dataset
power_data <- read.table("../ExData_Data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# b. filter/tidy the dataset (using chained dplyr library functions)
library("dplyr")
power_data <- filter(power_data, Date == "1/2/2007" | Date == "2/2/2007") %>%
  unite(DateTime, Date, Time) %>% # combine the Date and Time columns (concatenate two strings into one, separated by an underscore)
  mutate(DateTime = as.POSIXct(DateTime, format = "%d/%m/%Y_%H:%M:%S")) %>% # covert the new string into a valid POSIXct date/time data type
  mutate(across(2:8, as.numeric)) # convert all other columns from 'character' to 'numeric'

# c. plot the data (to a file)
png(filename="plot4.png", width = 480,height = 480, unit = "px") # open the file
par(mfcol=c(2,2)) # create two-column plotting matrix
plot(power_data$DateTime, power_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power") # TOPLEFT
plot(power_data$DateTime, power_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black") # BOTTOMLEFT
lines(power_data$DateTime, power_data$Sub_metering_2, col = "red")
lines(power_data$DateTime, power_data$Sub_metering_3, col = "blue")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "blue", "red"), box.lwd = 0)
plot(power_data$DateTime, power_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") # TOPRIGHT
plot(power_data$DateTime, power_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power") # BOTTOMRIGHT
dev.off() # close the file