##read only the data for 2007-02-01 and 2007-02-02

skipcount <-
    grep("1/2/2007", readLines("household_power_consumption.txt"))[1] - 1

householdpower <- read.table(
    "household_power_consumption.txt",
    skip = skipcount,
    nrows = 2880,
    sep = ";",
    stringsAsFactors = FALSE
)

##add column names to the dataset
colnames(householdpower) <-
    read.table(
        "household_power_consumption.txt",
        nrows = 1,
        sep = ";",
        stringsAsFactors = FALSE
    )

Datetime <- strptime(paste(householdpower$Date, householdpower$Time), "%d/%m/%Y %H:%M:%S")

householdpower <- cbind(householdpower, Datetime)

##open the png graphics device
png(filename = "plot3.png", width = 480, height = 480)

##make a plot
plot(
    householdpower$Datetime,
    householdpower$Sub_metering_1,
    xlab = "",
    ylab = "Energy sub metering",
    type = "l"
)

##add additional two lines
lines(householdpower$Datetime, householdpower$Sub_metering_2, col = "red")
lines(householdpower$Datetime, householdpower$Sub_metering_3, col = "blue")

##add the legend
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = 1
)

##close the png graphics device
dev.off()
