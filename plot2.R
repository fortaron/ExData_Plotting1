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

png(filename = "Plot2.png",
    width = 480, height = 480, units = "px") # starting the PNG device

plot(housesub$Global_active_power ~ as.POSIXct(housesub$datetime),
     type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off() # Closing the plotting device