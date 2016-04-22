#Assignment:  Course Project 1
#Code for Plot 1

#Install the following package. 
install.packages("sqldf")
library(sqldf)


#This reads in only the Date and Global_active_power for the date range February 1, 2007 to February 2, 2007.
#2880 records
partialData <- read.csv.sql("household_power_consumption.txt", sql = "select Date, Global_active_power from file Where Date = '1/2/2007' OR Date = '2/2/2007'", sep = ";") 

#Create plot1
png(filename = "plot1.png", width = 480, height = 480)

hist(partialData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.off()