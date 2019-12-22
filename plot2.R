-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
#IMPORTING SOME PACKAGES TO HELP WITH DATE AND TIME TRANSFORMATION
library(lubridate)
library(chron)

-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
  #READING IN THE DATA AND CONVERTING THE DATE AND TIME COLUMNS TO DATETIME FORMAT
power <- read.table("./Data/exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE)
  
power$Date <- dmy(power$Date)
power$Time <- strptime(power$Time, format = "h:m:s")
power$Time <- chron(times=power$Time)
  
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
 # SELECTING ONLY DAYS OF CONCERN FROM THE DATA AND CONVERTING OTHER COLUMNS TO NUMERIC
power_trunc <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")
  
power_trunc$Global_active_power <- as.numeric(as.character(power_trunc$Global_active_power))
power_trunc$Sub_metering_1 <- as.numeric(as.character(power_trunc$Sub_metering_1))
power_trunc$Sub_metering_2 <- as.numeric(as.character(power_trunc$Sub_metering_2))
power_trunc$Sub_metering_3 <- as.numeric(as.character(power_trunc$Sub_metering_3))
  
--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
# CREATING A COMBINED DATETIME COLUMN FOR SECOND CHART
power_trunc$datetime <- as.POSIXct(paste(power_trunc$Date,power_trunc$Time))

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
# CONSTRUCTING SECOND CHART AND SAVING AS PNG (plot2.png)
dev.new(width = 480, height = 480, unit = "px")
plot(power_trunc$datetime,power_trunc$Global_active_power,type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file="./Data/exdata_data_household_power_consumption/plot2.png") 
dev.off()
