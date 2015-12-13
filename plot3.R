# Author: Vish Yella
# Date  : 12/12/2015
# Description:   Generates Plot 3 per assignment instructions. Plots 3 sub_metering values versus date-time
#       
# Pre-requisites:  
#       Required Libaries:  this script uses functions from below packages.  Please install and load before running this script:
#               library(dplyr)
#               library(sqldf)


plot3 <-function() {
        #Read selected data
        mydata <- read.csv.sql("household_power_consumption.txt", 
                               sql = "select * from file where Date='1/2/2007'  or Date = '2/2/2007' " , 
                               sep = ";"  , header = TRUE )
        closeAllConnections()
        
        #format the date times
        mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
        mydata2 <- mutate(mydata, datetime = paste(Date, Time))
        mydata2$datetime <- strptime( mydata2$datetime, "%Y-%m-%d %H:%M:%S") 
        
        #direct the output to a png file
        png(filename="plot3.png", width = 480, height = 480 ) 
        
        #plot different submetering values one by one
         with(mydata2, plot(mydata2$datetime,mydata2$Sub_metering_1,  type="n", ylab="Energy sub metering" , xlab = ""))
         with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_1, col = "black", type="l"))
         with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_2, col = "red", type="l"))
         with(mydata2, lines(mydata2$datetime, mydata2$Sub_metering_3, col = "blue", type="l"))
         
        #place a legend
        legend("topright", col = c("black", "red" , "blue"), legend = c("Sub_metering_1", "Sub_metering_2" , "Sub_metering_3") , lty = c(1,1))
        
        #close the devices
        invisible(dev.off())
}

plot3()