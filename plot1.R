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

png("plot1.png", width = 480, height = 480)
#Create the plot
hist(hpcfeb$Global_active_power,main = "Global Active Power",
     xlab = "Global Active Power",col = "red")
#Close the file
dev.off()

