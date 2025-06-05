hpc <- read.csv("exdata/household_power_consumption.txt", sep=";")
library(lubridate)
# Working with time format
hpcdata<-subset(hpc, Date=="1/2/2007" | Date=="2/2/2007")
hpcdata$timedate<-dmy_hms(paste(hpcdata$Date, hpcdata$Time))

#Numeric data
hpcdata$Global_active_power<-as.numeric(hpcdata$Global_active_power)

# Plot 1
png("plot1.png", width = 480, height=480, units="px")
hist(hpcdata$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()