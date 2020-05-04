library(dplyr)
library(data.table)
library(chron)

#preprocessing of data
hpc<- fread("household_power_consumption.txt")
hpc=hpc[!startsWith(hpc$Global_active_power,"?")]
hpc[,3:8]=as.data.frame(sapply(hpc[,3:8],as.numeric))
hpc$Date<- as.Date(hpc$Date,format = "%d/%m/%Y")
hpc$Time=chron(times. = hpc$Time)
str(hpc)

hpcfeb=hpc[hpc$Date>="2007-02-01" & hpc$Date<="2007-02-2"]
hpcfeb$Date=as.POSIXct(paste(hpcfeb$Date,hpcfeb$Time), format="%Y-%m-%d %H:%M:%S")

png("plot4.png", width = 480, height = 480)
#Create the plot
par(mfrow=c(2,2))
plot(hpcfeb$Date,hpcfeb$Global_active_power,main = "",xlab = "",
     ylab = "Global active power (in kilowatt)",type = "l")
plot(hpcfeb$Date,hpcfeb$Voltage,main = "",xlab = "datetime",
     ylab = "Voltage",type = "l")
plot(hpcfeb$Date,hpcfeb$Sub_metering_1,
     main = "",xlab = "",ylab = "Energy Sub Metering",type = "l",col="black")
lines(hpcfeb$Date,hpcfeb$Sub_metering_2,
      main = "",xlab = "",ylab = "Energy Sub Metering",type = "l",col="red")
lines(hpcfeb$Date,hpcfeb$Sub_metering_3,
      main = "",xlab = "",ylab = "Energy Sub Metering",type = "l",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty = 1)
plot(hpcfeb$Date,hpcfeb$Global_reactive_power,main = "",xlab = "datetime",
     ylab = "Global_reactive_power",type = "l")

#Close the file
dev.off()
