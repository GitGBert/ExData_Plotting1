

# This is for Exploratory Data Analysis course. Plot 1  
# ----------------------------------------------------

library (lubridate)

library (data.table) # reading source as data.table helped remove errors later in converting to Date format.

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file( fileURL, destfile="zippedFile.zip", mode ="wb")

fileN <- unzip("zippedFile.zip")                # unzip downloaded file

hpData = read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))

hpD2 <- hpData   

# names(hpData)  # str(hpData)

hpD2[,1] <- as.Date(hpD2$Date, "%d/%m/%Y")

#  hpD2[,2] <- as.Date(as.character(hpD2$Time), format = "%H:%M:%S") ## no good....?

#  hpD2[,1] <- ymd(hpD2$Date) ## no good...?

hpD2[,2] <- hms(hpD2$Time) # lubridate format

hpGAP <- subset(hpD2, Date == "2007-02-01" | Date == "2007-02-02", select=Global_active_power)

# Now create graph
png(file = "plot1.png")

hist(hpGAP$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()


