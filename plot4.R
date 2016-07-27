## Assignment for week 1 of the Exploratory Data Analisys Course

#Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the following 
# plots below, all of which were constructed using the base plotting system.



fileName <- "power_consumption.zip"

if (!file.exists(fileName)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file (url = fileURL, destfile = fileName)
}  
if (!file.exists("power_consumption")) { 
      unzip(fileName) 
}


## Reading data
## The data frame will have 430 MB, so, make sure you have this amount of memory available

pc <- read.table("power_consumption/household_power_consumption.txt",  
                 sep = ";", header = TRUE, na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"))

## Converting to date class
pc$Date <- as.Date(pc$Date, format="%d/%m/%Y")

## Subsetting the records needed
pcFebruary2007 <- pc[pc$Date == "2007-02-01" | pc$Date == "2007-02-02", ]

## Day and time to plot
pcFebruary2007$Time <- strptime(paste(pcFebruary2007$Date, pcFebruary2007$Time), format="%Y-%m-%d %H:%M:%S")

## Plot 4
Sys.setlocale("LC_TIME", "English")
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 4, 4))
##Top left
plot(pcFebruary2007$Time, pcFebruary2007$Global_active_power, type = "l", ylab="Global Active Power")

## Top right
plot(pcFebruary2007$Time, pcFebruary2007$Voltage, type="l", ylab="Voltage", xlab = "datetime")

## Bottom left
plot(pcFebruary2007$Time, pcFebruary2007$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab="", col = "black")
lines(pcFebruary2007$Time, pcFebruary2007$Sub_metering_1, col = "black")
lines(pcFebruary2007$Time, pcFebruary2007$Sub_metering_2, col="red")
lines(pcFebruary2007$Time, pcFebruary2007$Sub_metering_3, col="blue")
## Legend
lg <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = lg, col = c("black", "red", "blue"), lwd = "1")

## Bottom right
plot(pcFebruary2007$Time, pcFebruary2007$Global_reactive_power, type = "l", 
     ylab="Global_reactive_power", xlab="datetime")


dev.off()
