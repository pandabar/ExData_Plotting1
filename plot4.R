hpc <- read.csv("exdata/household_power_consumption.txt", sep=";")
library(lubridate)
library(dplyr)

#Date & time jazz. Added Sat at 00:00 to match the plot
hpcdata<-subset(hpc, Date=="1/2/2007" | Date=="2/2/2007" | (Date=="3/2/2007" & Time=="00:00:00"))
hpcdata$timedate<-dmy_hms(paste(hpcdata$Date, hpcdata$Time))

#Language
Sys.setlocale("LC_TIME", "English.UTF-8")
hpcdata$weekday<-wday(hpcdata$timedate, label = TRUE, abbr = TRUE)

#As numeric
hpcdata <- hpcdata %>% mutate_at(c("Sub_metering_1", "Sub_metering_1", "Sub_metering_3", "Voltage", "Global_reactive_power"), as.numeric)

#plot 4
png("plot4.png", width = 480, height=480, units="px")
par(mfrow = c(2,2))
##1
plot(hpcdata$timedate, hpcdata$Global_active_power,xlab="", ylab="Global Active Power (kilowatts)", xaxt = "n", type="l")
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), labels = unique(hpcdata$weekday))
##2
plot(hpcdata$timedate, hpcdata$Voltage, xlab="datetime", ylab="Voltage", xaxt="n", type="l")
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), labels = unique(hpcdata$weekday))
##3
cols=c("black", "red", "blue")
plot(hpcdata$timedate, hpcdata$Sub_metering_1,xlab="", ylab="Energy sub metering", xaxt = "n", type="l", col=cols[1])
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), labels = unique(hpcdata$weekday))
lines(hpcdata$timedate, hpcdata$Sub_metering_2, col=cols[2])
lines(hpcdata$timedate, hpcdata$Sub_metering_3, col=cols[3])
legend(x=as.POSIXct("2007-02-01 17:00:00"), y=38, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex= .9, col=cols, lty=1, bty = "n")

##4
plot(hpcdata$timedate, hpcdata$Global_reactive_power,xlab="datetime", ylab="Global_reactive_power", xaxt = "n", type="l")
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), labels = unique(hpcdata$weekday))
dev.off()
