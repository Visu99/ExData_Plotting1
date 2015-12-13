# Author: Vish Yella
# Date  : 12/12/2015
# Description:   Generates Plot 1 per assignment instructions. Plots histogram of Global Active Power.
#       
# Pre-requisites:  
#       Required Libaries:  this script uses functions from below packages.  Please install and load before running this script:
#               library(dplyr)
#               library(sqldf)


plot1 <-function() {
        #Read selected data from file using sql
        mydata <- read.csv.sql("household_power_consumption.txt", 
                               sql = "select * from file where Date='1/2/2007'  or Date = '2/2/2007' " , 
                               sep = ";"  , header = TRUE )
        closeAllConnections()
        
        #Format the date
        mydata$Date <- as.Date(mydata$Date, format = "%d/%m/%Y")
        
        #Direct the output to a png file
        png(filename="plot1.png", width = 480, height = 480 ) 
        
        #Generate a histogram
        hist(as.numeric(as.character(mydata$Global_active_power)), col = "red" , main = "Global Active Power", xlab="Global Active Power (kilowatts)")
        
        #close the device
        invisible(dev.off())

}
plot1()