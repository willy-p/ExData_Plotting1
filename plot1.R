library(tidyverse)

# Load file into R
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp)
files <- unzip(temp, list = T)
data <- read_delim(unz(temp, files$Name[1]), delim = ";", col_names = T)
unlink(temp)


# Convert "Date" column from character to date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Generate a PNG plot of the frequency of Global Active Power levels
png(file = "plot1.png")
hist(data$Global_active_power, main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
