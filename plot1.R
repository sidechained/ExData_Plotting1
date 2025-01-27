# Plot 1: Histogram of "Global Active Power"
# x axis = Global Active Power (kilowatts), y axis = Frequency (of occurrences in data)

# a. read-in dataset
power_data <- read.table("../ExData_Data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# b. filter/tidy the dataset (using chained dplyr library functions)
library("dplyr")
power_data <- filter(power_data, Date == "1/2/2007" | Date == "2/2/2007") %>% # keep only rows where date matches ones we're interested in
  unite(DateTime, Date, Time) %>% # combine the Date and Time columns (concatenate two strings into one, separated by an underscore)
  mutate(DateTime = as.POSIXct(DateTime, format = "%d/%m/%Y_%H:%M:%S")) %>% # covert the new string into a valid POSIXct date/time data type
  mutate(Global_active_power = as.numeric(Global_active_power)) # convert the Global_active_power column from 'character' to 'numeric'

# c. plot the data (to a file)
png(filename="plot1.png", width = 480,height = 480, unit = "px") # open the file
hist(power_data$Global_active_power[!is.na(power_data$Global_active_power)], xlab = "Global Active Power (kilowatts)", main ="Global Active Power", col = "red") # NA's removed within first argument (hist has no na.rm argument!)
dev.off() # close the file