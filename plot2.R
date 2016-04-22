#Assignment:  Course Project 1
#Code for Plot 2

#Install the following package. 
install.packages("sqldf")
library(sqldf)

#This reads in only the Date, Time, and Global_active_power for the date range February 1, 2007 to February 2, 2007.
#2880 records
partialData <- read.csv.sql("household_power_consumption.txt", sql = "select Date, Time, Global_active_power from file Where Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";") 


#Change the format of the dates.  This helps with the graphing

partialData$Date[partialData$Date == "1/2/2007"] <- "2007/02/01"
partialData$Date[partialData$Date == "2/2/2007"] <- "2007/02/02"


#Combine the date and time columns into a new column called Date_Time
partialData["Date_Time"] <- paste(partialData$Date, partialData$Time)
partialData$Date_Time <- as.POSIXct(partialData$Date_Time)

#Plot the graph
png(filename = "plot2.png", width = 480, height = 480)
x <- partialData$Date_Time
y <- partialData$Global_active_power
plot(x, y, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
