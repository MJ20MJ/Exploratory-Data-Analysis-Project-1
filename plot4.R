#Assignment:  Course Project 1
#Code for Plot 4

#Install the following package. 
install.packages("sqldf")
library(sqldf)


#Plot 4
#This reads in the data  for the date range February 1, 2007 to February 2, 2007.
#2880 records
partialData <- read.csv.sql("household_power_consumption.txt", sql = "select Date, Time, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3 from file Where Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";") 

#Change the format of the date. This helps with the graphing.

partialData$Date[partialData$Date == "1/2/2007"] <- "2007/02/01"
partialData$Date[partialData$Date == "2/2/2007"] <- "2007/02/02"

#Combine the date and time into a new column called Date_Time
partialData["Date_Time"] <- paste(partialData$Date, partialData$Time)
partialData$Date_Time <- as.POSIXct(partialData$Date_Time)


#Plot
png(filename = "plot4.png", width = 480, height = 480)

#Create 4 plots (2 in each row)
par(mfrow = c(2, 2))

x <- partialData$Date_Time
yPlot1 <- partialData$Global_active_power

yPlot2 <- partialData$Voltage

yPlot3_1 <- partialData$Sub_metering_1
yPlot3_2 <- partialData$Sub_metering_2
yPlot3_3 <- partialData$Sub_metering_3

yPlot4 <- partialData$Global_reactive_power


plot(x, yPlot1, type = "l", ylab = "Global Active Power", xlab = "")

plot(x, yPlot2, type = "l", ylab = "Voltage", xlab = "datetime")


plot(x, yPlot3_1, type = "l", ylab = "Engegy sub metering", xlab = "", col = "black")
points(x, yPlot3_2, col = "red", type = "l")
points(x, yPlot3_3, col = "blue", type = "l")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(x, yPlot4, type = "l", ylab = "Global_reative_power", xlab = "datetime")

dev.off()


