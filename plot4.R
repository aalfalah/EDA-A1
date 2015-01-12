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


# Fourth Plot
dev.off()
par(mfrow = c(2,2), mar = c(4,4,2,1), oma=c(0,0,2,0))
with(subdata, {
  plot(DateTime,Global_active_power,type="l",xlab="",
       ylab="Global Active Power (kilowatts)" )
  
  plot(DateTime,subdata$Voltage,type="l",
       xlab="datetime" )
  
  plot(subdata$DateTime,subdata$Sub_metering_1, type="l",col = "black", 
       ylab="Energy sub metering",
       xaxp = c(0, 30, 10), xlab="")
  lines(subdata$DateTime,subdata$Sub_metering_2,type="l",col="red", 
        ylab="Energy sub metering",
        xaxp = c(0, 30, 10), xlab="")
  lines(subdata$DateTime,subdata$Sub_metering_3,type="l",col="blue",
        ylab="Energy sub metering", 
        xaxp = c(0, 30, 10), xlab="")
  legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
         lty=c(1,1,1),
         cex=.5,
         col=c("black","red", "blue"))
  
  plot(DateTime,Global_reactive_power,type="l",
       xlab="datetime" )
})
dev.copy(png, file = "plot4.png", width = 480, height = 480 )
dev.off()








