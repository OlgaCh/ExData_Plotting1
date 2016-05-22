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

# Converting dates
datetime <- paste(as.Date(data_subset$Date), data_subset$Time)
data_subset$Datetime <- as.POSIXct(datetime)

# Plotting
plot(data_subset$Global_active_power~data_subset$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()