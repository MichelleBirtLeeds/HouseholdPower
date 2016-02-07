setwd("C:/Users/Michelle/Desktop/Coursera/Exploratory_Data_Analysis/Week_1")

###########################################################################
#This file creates plot3.png, 
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

  
#Then, create plot 3.
    #It is a line graph, power subsets by datetime.
  
  #Since there are multiple lines to graph, start with a blank graph. 
      plot(powerUseData$datetime, powerUseData$Sub_metering_1,
                          type = "n",
                          ylab = "Energy sub metering",
                          xlab = "")
      
  #Now add the lines with points()
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
      
  #Put in a legend.
      legend("topright", 
             lty = 1,
             col = c("black", "red", "blue"), 
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             y.intersp = .75) 
          #I'm trying to resize the legend to match the picture shown in the example.
            #I've not fully suceeded, but I've run out of ideas.
      
    #export the plot:
      dev.copy(png, file = "plot3.png")  
      dev.off()
  
  
  
  
  


  
  