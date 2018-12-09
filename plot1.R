file_path <- "household_power_consumption.txt"

data <- read.table(file_path, stringsAsFactors = FALSE, sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
selector <- data$Date == "2007-02-01" | data$Date == "2007-02-02"
subdata <- data[selector, ]

subdata$Global_active_power <- as.numeric(subdata$Global_active_power)

png("plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()