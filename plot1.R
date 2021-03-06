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


## Plot 1

png(filename = "plot1.png", width = 480, height = 480)
hist(pcFebruary2007$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

