#File path
file_path <- "household_power_consumption.txt"
#Read file
data <- read.table(file_path, stringsAsFactors = FALSE, sep = ";", header = TRUE)
#Subset the data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
selector <- data$Date == "2007-02-01" | data$Date == "2007-02-02"
subdata <- data[selector, ]
#Correct classes for related columns for this plot
Date_time <- paste(subdata$Date, subdata$Time)
subdata <- subdata[ ,c(-1,-2)]
subdata <- cbind(Date_time, subdata, stringsAsFactors = FALSE)
subdata$Date_time <- strptime(subdata$Date_time, format = "%Y-%m-%d %H:%M:%S")
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
#Plotting
png("plot3.png", width = 480, height = 480)
plot(subdata$Date_time, subdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(subdata$Date_time, subdata$Sub_metering_2, col = "red")
lines(subdata$Date_time, subdata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1))
dev.off()