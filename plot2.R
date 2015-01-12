#Downloading and unzipping the file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=temp,method = "curl")
#Reading Data
data<-read.table(unz(temp, "household_power_consumption.txt"),
                 sep=";", header=T)
unlink(temp)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
subdata <-subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")



subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage))
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))

subdata$DateTime <-as.POSIXct(paste(subdata$Date, subdata$Time), format="%Y-%m-%d %H:%M:%S")


# Second Plot
dev.off()
with(subdata, plot(DateTime,Global_active_power,type="l",xlab="",
                   ylab="Global Active Power (kilowatts)" ))
dev.copy(png, file = "plot2.png", width = 480, height = 480 )
dev.off()