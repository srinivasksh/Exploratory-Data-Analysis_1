## Read Power consumption data delimited by ; into a table
power_raw <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

## Covert values in Date column into Date format
power_raw$Date <- as.Date(power_raw$Date, "%d/%m/%Y")

## Filter data confined to 01-Feb-2007 and 02-Feb-2007
power <- subset(power_raw, Date >= "2007-02-01" & Date <= "2007-02-02")

## create a numeric vector for numeric Global active power
kw_GAP <- as.numeric(as.character(power$Global_active_power))

## create a png file of 480*480 px
png("plot1.png", width = 480, height = 480, units = "px")

## create a histogram plot of Global active power in Red
hist(kw_GAP, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")
dev.off()