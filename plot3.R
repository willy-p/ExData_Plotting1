library(tidyverse)

# Load file into R
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp)
files <- unzip(temp, list = T)
data <- read_delim(unz(temp, files$Name[1]), delim = ";", col_names = T)
unlink(temp)


# Convert "Date" column from character to date class and add weekday column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")


#Generate a PNG plot of the frequency of Global Active Power levels
png(file = "plot3.png")
with(data, plot(datetime, Sub_metering_1, type = "n", 
                ylab = "Energy sub metering", xlab = ""))
points(data$datetime, data$Sub_metering_1, col = "black", type = "l")
points(data$datetime, data$Sub_metering_2, col = "red", type = "l")
points(data$datetime, data$Sub_metering_3, col = "blue", type = "l")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()

