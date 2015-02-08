## Before start, set the working directory to the place where all R scripts and
## the datafile (household_power_consumption.txt) are. All the scripts and the
## txt must be in the same path.

## Load the large dataset.
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   colClasses = c("character", "character", 
                                  rep("numeric",7)), na = "?")
## Keep only the relevant dates
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
## Add a proper format to the time variable
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
## Rename the rows of the data to match the "real" value in the new dataset
rownames(data) <- 1:nrow(data)

## Make the plot 1
png(filename = "plot1.png", 
    width = 480, 
    height = 480, 
    units = "px", 
    bg = "transparent")
hist(data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     breaks = 12, 
     ylim = c(0, 1200))
dev.off()

## Make the plot 2
png(filename = "plot2.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

## Make the plot 3
png(filename = "plot3.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")
plot(data$DateTime, 
     data$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
dev.off()

## Make the plot 4
png(filename = "plot4.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(data$DateTime, 
     data$Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")
## Top-right
plot(data$DateTime, 
     data$Voltage,
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")
## Bottom-left
plot(data$DateTime, 
     data$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(data$DateTime, 
     data$Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", 
     ylab = colnames(data)[4])
dev.off()
