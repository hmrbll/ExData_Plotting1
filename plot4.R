file_path <- "household_power_consumption.txt"

data <- read.table(file_path, stringsAsFactors = FALSE, sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
selector <- data$Date == "2007-02-01" | data$Date == "2007-02-02"
subdata <- data[selector, ]


Date_time <- paste(subdata$Date, subdata$Time)
subdata <- subdata[ ,c(-1,-2)]
subdata <- cbind(Date_time, subdata, stringsAsFactors = FALSE)
subdata$Date_time <- strptime(subdata$Date_time, format = "%Y-%m-%d %H:%M:%S")

subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
subdata$Voltage <- as.numeric(subdata$Voltage)
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
subdata$Global_reactive_power <- as.numeric(subdata$Global_reactive_power)


png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4, 4.1, 2, 2))
plot(subdata$Date_time, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(subdata$Date_time, subdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(subdata$Date_time, subdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(subdata$Date_time, subdata$Sub_metering_2, col = "red")
lines(subdata$Date_time, subdata$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n", cex = 0.75)
plot(subdata$Date_time, subdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()