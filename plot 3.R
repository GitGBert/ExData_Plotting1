#Plot #3 from Week 1 of Exploratory Data course

library (lubridate)

library (data.table) # reading source as data.table helped remove errors later in converting to Date format.


# download and read in data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file( fileURL, destfile="zippedFile.zip", mode ="wb")

fileN <- unzip("zippedFile.zip")                # unzip downloaded file

hpData = read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))


# format the date and time 

hpD2 <- hpData   

hpD2[,1] <- as.Date(hpD2$Date, "%d/%m/%Y")

hpD2 <- within(hpD2, Date_Time <- paste(hpD2$Date, hpD2$Time))     # creates a new column with data and time joined, but new column is character

hpD2$Date_Time <- ymd_hms(hpD2$Date_Time) # Appropriate time format , "%Y-%m-%d %H:%M:%S"


# subset out the first two days of February 2007

hpSub <- subset(hpD2, Date == "2007-02-01" | Date == "2007-02-02", select=c(Sub_metering_1,Sub_metering_2, Sub_metering_3, Date_Time))


# Now create graph

png(file = "plot3.png")

yLabel <- "Energy sub metering"

plot  (hpSub$Date_Time, hpSub$Sub_metering_1, type = "l", xlab = "", ylab = yLabel, col = "Black")

points(hpSub$Date_Time, hpSub$Sub_metering_2, type = "l", xlab = "", ylab = yLabel, col = "Red")

points(hpSub$Date_Time, hpSub$Sub_metering_3, type = "l", xlab = "", ylab = yLabel, col = "Blue")

plotColors <- c("black", "red", "blue")

plotLegend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

legend("topright", lty = 1, col = plotColors, legend = plotLegend)

dev.off()

