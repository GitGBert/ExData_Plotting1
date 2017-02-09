
library (lubridate)

library (data.table) # reading source as data.table helped remove errors later in converting to Date format.

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file( fileURL, destfile="zippedFile.zip", mode ="wb")

fileN <- unzip("zippedFile.zip")                # unzip downloaded file

hpData = read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))

hpD2 <- hpData   

hpD2[,1] <- as.Date(hpD2$Date, "%d/%m/%Y")

hpD2 <- within(hpD2, Date_Time <- paste(hpD2$Date, hpD2$Time))     # creates a new column with data and time joined, but new column is character

hpD2$Date_Time <- ymd_hms(hpD2$Date_Time) # Appropriate time format , "%Y-%m-%d %H:%M:%S"


# subset out the first two days of February 2007

hpGAP <- subset(hpD2, Date == "2007-02-01" | Date == "2007-02-02", select=c(Global_active_power, Date_Time))


# Now create graph

png(file = "plot2.png")

plot(hpGAP$Date_Time, hpGAP$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

