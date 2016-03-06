# Downloading the files and reading the data 

url_file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url_file ,temp)
house <- read.table(unzip(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Preparing the data

house$Date <- as.Date(house$Date, format = "%d/%m/%Y") # Formatting the dates
housesub <- house[house$Date >= as.Date("2007-02-01") & house$Date <= as.Date("2007-02-02"),] # Subsetting the data between dates

# Plotting

png(filename = "Plot1.png",
    width = 480, height = 480, units = "px", bg = "transparent") # starting the PNG device

hist(housesub$Global_active_power,
     col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", bg = NA)

dev.off() # Closing the plotting device