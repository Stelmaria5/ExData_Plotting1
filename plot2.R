## Exploratory data analysis Coursework 1. Electric power consumption. 
## Aim is to examine how household energy usage varies over a 2-day period in February, 2007


# It is a big table to read in so first I will work out what
# each of the column classes are, then feed this into colClasses

tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5)
classes <- sapply(tab5rows, class)

# We are only using the dates 2007-02-01 and 2007-02-02, 
# so extract values only from these dates.
# One minute sampling rate starting from 16/12/2006 17:25:00; we only want from 01/02/2007
# (47 days difference; minutes in 24hrs = 1440; times 47 = 67680. Minus 17 hrs 25 min to t
# take to midnight (60 x 17 = 1020 + 25 = 1045) 6780 - 1045  = 66635. So start 
# 66635 rows from beginning.
# Covers 2 days so 1440 times 2 = 2880; this will be num rows.
# Read in a smaller range than the whole thing using skip and
# nrows, to reduce memory demands.
# 44640
# Missing values are coded as "?" (so NA = "?")
powerdata <- read.table("household_power_consumption.txt", header = FALSE,
                        col.names = c("Date", "Time", "Global_active_power",
                                      "Global_reactive_power", "voltage",
                                      "Global_intensity", "Sub_metering_1", 
                                      "Sub_metering_2", "Sub_metering_3"),
                        sep=";", na.strings = "?", colClasses = classes, 
                        nrows = 2880 , skip = 66637)


# Convert the date and time variables into date/time classes
# using strptime() and as.Date()
x <- paste(powerdata$Date, powerdata$Time)
powerdata$Time <- strptime(x, "%d/%m/%Y %H:%M:%S")

powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
## Plot 2

png('plot2.png', width = 480, height = 480)

plot(powerdata$Time,powerdata$Global_active_power, type = "l", 
     xlab = " ", ylab = "Global Active Power (kilowatts)")

dev.off()