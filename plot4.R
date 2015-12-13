# Author: Vish Yella
# Date  : 12/12/2015
# Description:   Generates Plot 4 per assignment instructions.  
#       
# Pre-requisites:  
#       Required Libaries:  this script uses functions from below packages.  Please install and load before running this script:
#               library(dplyr)
#               library(sqldf)


plot4 <-function() {
        #Read selected data
        mydata <- read.csv.sql("household_power_consumption.txt", 
                               sql = "select * from file where Date='1/2/2007'  or Date = '2/2/2007' " , 
                               sep = ";"  , header = TRUE )
        closeAllConnections()
        
        #format date and time
        mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
        mydata2 <- mutate(mydata, datetime = paste(Date, Time))
        mydata2$datetime <- strptime( mydata2$datetime, "%Y-%m-%d %H:%M:%S") 
        
        #direct the output to png file format
        png(filename="plot4.png", width = 480, height = 480 ) 
        
        #Specify the number of rows and columns for multiple plots
        par(mfrow = c(2,2))
        
        #plot 1
        plot( mydata2$datetime , as.numeric(as.character(mydata2$Global_active_power)),   ylab  = "Global Active Power",  xlab = "" ,  type = "l")
        
        
        #plot 2
        plot(mydata2$datetime, mydata$Voltage , type = "l", ylab="Volate", xlab="datetime")
        
        
        #plot 3
        with(mydata2, plot(mydata2$datetime,mydata2$Sub_metering_1,  type="n", ylab="Energy sub metering" , xlab = ""))
        with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_2, col = "red", type="l"))
        with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_3, col = "blue", type="l"))
        with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_1, col = "black", type="l"))
        legend(cex = 0.75 , bty = "n", "topright", col = c("black", "red" , "blue"), legend = c("Sub_metering_1", "Sub_metering_2" , "Sub_metering_3") , lty = c(1,1))
        
        
        #plot 4
        plot(mydata2$datetime, mydata$Global_reactive_power , type = "l",  ylab = "Global_reactive_power" ,  xlab="datetime")
        
        #close the device
        invisible(dev.off())
}
plot4()