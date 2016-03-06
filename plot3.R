# Downloading the files and reading the data 

url_file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url_file ,temp)
house <- read.table(unzip(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Preparing the data

house$Date <- as.Date(house$Date, format = "%d/%m/%Y") # Formatting the dates
housesub <- house[house$Date >= as.Date("2007-02-01") & house$Date <= as.Date("2007-02-02"),] # Subsetting the data between dates
housesub$datetime <- as.POSIXct(paste(housesub$Date, housesub$Time, sep = " ")) # Creating a new field "datetime"

# Plotting

png(filename = "Plot3.png",
    width = 480, height = 480, units = "px", bg = "transparent") # starting the PNG device


plot(housesub$Sub_metering_1 ~ as.POSIXct(housesub$datetime),
     type = "l", ylab = "Energy sub metering", xlab = "")

lines(housesub$Sub_metering_2 ~ as.POSIXct(housesub$datetime),
      col = "red")

lines(housesub$Sub_metering_3 ~ as.POSIXct(housesub$datetime),
      col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

dev.off() # Closing the plotting device