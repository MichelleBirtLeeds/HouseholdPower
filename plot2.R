setwd("C:/Users/Michelle/Desktop/Coursera/Exploratory_Data_Analysis/Week_1")

###########################################################################
#This file creates plot2.png, 
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

  
#Then, create plot 2.
    #It is a line graph, global active power by datetime.
      #we get this with plot(), setting type = "o"
  
      plot(powerUseData$datetime, powerUseData$Global_active_power,
                          col = "black",
                          type = "o",
                          pch = "", 
                          ylab = "Global Active Power (kilowatts)",
                          xlab = "")
      #That looks about right.
      
    #export the plot:
      dev.copy(png, file = "plot2.png")  
      dev.off()
  
  
  
  
  


  
  