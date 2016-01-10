## Read Power consumption data delimited by ; into a table
power_raw <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

## Covert values in Date column into Date format
power_raw$Date <- as.Date(power_raw$Date, "%d/%m/%Y")

## Filter data confined to 01-Feb-2007 and 02-Feb-2007
power <- subset(power_raw, Date >= "2007-02-01" & Date <= "2007-02-02")

## Convert Global active power to numeric and create a new column for it
power$GAP <- as.numeric(as.character(power$Global_active_power))

## create a timestamp column by appending Date and Time columns
power$ts <- as.POSIXct(paste(power$Date, power$Time), format="%Y-%m-%d %H:%M:%S")

## convert Sub_metering_1/2/3 columns into numeric and all columns in power
power$sm1 <- as.numeric(as.character(power$Sub_metering_1))
power$sm2 <- as.numeric(as.character(power$Sub_metering_2))
power$sm3 <- as.numeric(as.character(power$Sub_metering_3))

## create a png file of 480*480 px
png("plot3.png", width = 480, height = 480, units = "px")

## create a plot of submetering columns in a single plot distinguished
## by colors along with a legend
plot(power$ts, power$sm1,type="l", xlab = "", ylab = "Energy sub metering")
lines(power$ts, power$sm2, col = "red")
lines(power$ts, power$sm3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()