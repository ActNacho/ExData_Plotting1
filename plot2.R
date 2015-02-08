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
