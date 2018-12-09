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

png("plot2.png", width = 480, height = 480)
plot(subdata$Date_time, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()