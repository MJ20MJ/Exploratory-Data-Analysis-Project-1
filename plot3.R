#Assignment:  Course Project 1
#Code for Plot 3

#Install the following package. 
install.packages("sqldf")
library(sqldf)


#Plot 3
#This read in only the Date, Time, and Sub_metering_1, Sub_metering_2, Sub_metering_3  for the date range February 1, 2007 to February 2, 2007.
#2880 records
partialData <- read.csv.sql("household_power_consumption.txt", sql = "select Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3 from file Where Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";") 


#Change the format of the date.  This helps with graphing.
partialData$Date[partialData$Date == "1/2/2007"] <- "2007/02/01"
partialData$Date[partialData$Date == "2/2/2007"] <- "2007/02/02"

#Combine the date and time into a new column called Date_Time
partialData["Date_Time"] <- paste(partialData$Date, partialData$Time)
partialData$Date_Time <- as.POSIXct(partialData$Date_Time)

#Plot
png(filename = "plot3.png", width = 480, height = 480)
x <- partialData$Date_Time
y1 <- partialData$Sub_metering_1
y2 <- partialData$Sub_metering_2
y3 <- partialData$Sub_metering_3

#Plot the first series sub metering 1
plot(x, y1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")

#Plot the second and third series  sub metering 2 and 3
points(x, y2, col = "red", type = "l")
points(x, y3, col = "blue", type = "l")

#Add a legend.
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()