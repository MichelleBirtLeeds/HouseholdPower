setwd("C:/Users/Michelle/Desktop/Coursera/Exploratory_Data_Analysis/Week_1")

###########################################################################
#This file creates plot4.png, 
  #a file submitted to my github account
  #as part of Homework 1 for Exploratory Data Analysis.

#This file was created by Michelle Birt Leeds on February 4, 2016
  #It was last edited by Michelle Birt Leeds on February 4, 2016

#NOTE:
  #This code assumes that par() is set to default at the beginning of the script.
###########################################################################

#start by downloading the data from the zip file and creating the data frame.
  temp<-tempfile()
  URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, temp)
  zip_list<-unzip(temp,list=TRUE)#produces a list of the contents of the zipfile.
  unzip(temp)#unzips all the files in the working directory
  unlink(temp)
  
  #This will run a bit slowly, as it is a big data set.
  powerUseData<-read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?") 
  
  
#Fix up the dataset a bit:
  #fix dates and times
  powerUseData$datetime <- paste(powerUseData$Date,powerUseData$Time, sep = "/")
  powerUseData$Date<-as.Date(powerUseData$Date, "%d/%m/%Y")
  powerUseData$datetime<-strptime(powerUseData$datetime, "%d/%m/%Y/%H:%M:%S")
  
  #select only dates of interest.
  powerUseData<-subset(powerUseData, Date =="2007-02-01"| Date =="2007-02-02")
  
  #Delete Date and Time variables, as they are combined in datetime
  powerUseData$Date<-NULL
  powerUseData$Time<-NULL

  
#Then, create plot 4.
    #It's actually 4 plots, and the first two are plot2 and plot3.
    
    #change par() to fit 4 plots on the page.
  par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  
  #first plot: adapted from plot2.R
          plot(powerUseData$datetime, powerUseData$Global_active_power,
                          col = "black",
                          type = "o",
                          pch = "", 
                          ylab = "Global Active Power",
                          xlab = "")
  
  #second plot: adapted from plot3.R
          plot(powerUseData$datetime, powerUseData$Sub_metering_1,
                          type = "n",
                          ylab = "Energy sub metering",
                          xlab = "")
          points(powerUseData$datetime, powerUseData$Sub_metering_1,
                         col = "black",
                         type = "o",
                         pch = "")
          points(powerUseData$datetime, powerUseData$Sub_metering_2,
                         col = "red",
                         type = "o",
                         pch = "")
          points(powerUseData$datetime, powerUseData$Sub_metering_3,
                         col = "blue",
                         type = "o",
                         pch = "")
          legend("topright",
                         lty = 1,
                         col = c("black", "red", "blue"), 
                         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                         cex = .5,
                         y.intersp = .75,
                         bty = "n")
          
  #Third plot: Voltage by datetime
          plot(powerUseData$datetime, powerUseData$Voltage,
               col = "black",
               type = "o",
               pch = "", 
               ylab = "Voltage",
               xlab = "datetime")
          
  #Fourth plot: Voltage by datetime
          plot(powerUseData$datetime, powerUseData$Global_reactive_power,
               col = "black",
               type = "o",
               pch = "", 
               ylab = "Global_reactive_power",
               xlab = "datetime")
          #The legend in the second plot is still imperfect, but I've run out of ideas.
      
    #export the plot:
      dev.copy(png, file = "plot4.png")  
      dev.off()
  
  
  
  
  


  
  