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

## create a png file of 480*480 px
png("plot2.png", width = 480, height = 480, units = "px")

## create a plot of timestamp and Global active power
plot(power$ts, power$GAP,type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()