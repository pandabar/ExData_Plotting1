hpc <- read.csv("exdata/household_power_consumption.txt", sep=";")
library(lubridate)
# Format time
hpcdata<-subset(hpc, Date=="1/2/2007" | Date=="2/2/2007" | (Date=="3/2/2007" & Time=="00:00:00"))
hpcdata$timedate<-dmy_hms(paste(hpcdata$Date, hpcdata$Time))

#Change language. Kein Deutsch, bitte
Sys.setlocale("LC_TIME", "English.UTF-8")
hpcdata$weekday<-wday(hpcdata$timedate, label = TRUE, abbr = TRUE)

#Turn into numeric variable
hpcdata$Global_active_power<-as.numeric(hpcdata$Global_active_power)

# Plot 2
png("plot2.png", width = 480, height=480, units="px")
plot(hpcdata$timedate, hpcdata$Global_active_power,xlab="", ylab="Global Active Power (kilowatts)", xaxt = "n", type="l")
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), labels = unique(hpcdata$weekday))
dev.off()