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

## Convert columns Voltage, Global reactive power, submetering1, submetering2,
## submetering3 into numeric and add the new ones to power dataframe
power$vol <- as.numeric(as.character(power$Voltage))
power$GRP <- as.numeric(as.character(power$Global_reactive_power))
power$sm1 <- as.numeric(as.character(power$Sub_metering_1))
power$sm2 <- as.numeric(as.character(power$Sub_metering_2))
power$sm3 <- as.numeric(as.character(power$Sub_metering_3))

## create a png file of 480*480 px
png("plot4.png", width = 480, height = 480, units = "px")

## create a 2*2 plot that can fit 4 plots
par(mfrow = c(2, 2)) ## 2 rows 2 columns - 4 plots

## create 4 plots for Global Active power, Voltage, Energy sub metering,
## and submetering1/2/3
with(power, {
    plot(power$ts, power$GAP,type="l", xlab = "", ylab = "Global Active power")
    plot(power$ts, power$vol,type="l", xlab = "", ylab = "Voltage")
    plot(power$ts, power$sm1,type="l", xlab = "", ylab = "Energy sub metering")
    lines(power$ts, power$sm2, col = "red")
    lines(power$ts, power$sm3, col = "blue")
    legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
    plot(power$ts, power$GRP,type="l", xlab = "", ylab = "Global_reactive_power")
})

dev.off()