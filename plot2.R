# Author: Vish Yella
# Date  : 12/12/2015
# Description:   Generates Plot 2 per assignment instructions. Plots Global Active Power versus date-time
#       
# Pre-requisites:  
#       Required Libaries:  this script uses functions from below packages.  Please install and load before running this script:
#               library(dplyr)
#               library(sqldf)


plot2 <-function() {
        #Read selected data from file using sql
        mydata <- read.csv.sql("household_power_consumption.txt", 
                               sql = "select * from file where Date='1/2/2007'  or Date = '2/2/2007' " , 
                               sep = ";"  , header = TRUE )
        closeAllConnections()
        
        #Format the date and time
        mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
        mydata2 <- mutate(mydata, datetime = paste(Date, Time))
        mydata2$datetime <- strptime( mydata2$datetime, "%Y-%m-%d %H:%M:%S") 
        
        #Direct the output to a png file
        png(filename="plot2.png", width = 480, height = 480 ) 
        
        #generate a line plot 
        plot(mydata2$datetime, mydata$Global_active_power , type = "l", ylab="Global Active Power (kilowatts)", xlab="")
         
        #close the device
        invisible(dev.off())
        
}
plot2()