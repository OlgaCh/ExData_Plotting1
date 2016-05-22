# URL of Electric power consumption dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Getting data to temporary file and read to Data variable
temp <- tempfile()
download.file(url, temp)
unzip(temp, "household_power_consumption.txt")
data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subsetting the Data
data_subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
unlink(temp)

# Plotting
hist(data_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()