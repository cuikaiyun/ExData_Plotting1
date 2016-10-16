##read only the data for 2007-02-01 and 2007-02-02

skipcount <-
    grep("1/2/2007", readLines("household_power_consumption.txt"))[1] - 1

householdpower <- read.table(
    "household_power_consumption.txt",
    skip = skipcount,
    nrows = 2880,
    sep = ";"
)

colnames(householdpower) <-
    read.table(
        "household_power_consumption.txt",
        nrows = 1,
        sep = ";",
        stringsAsFactors = FALSE
    )

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

##topleft #1 plot
plot(
    1:dim(householdpower)[1],
    householdpower$Global_active_power,
    xlab = "",
    ylab = "Global Active Power",
    type = "l",
    xaxt = "n"
)

axis(1,
     at = c(1, 1440, 2880),
     labels = c("Thu", "Fri", "Sat"))

##topright #2 plot
plot(
    1:dim(householdpower)[1],
    householdpower$Voltage,
    xlab = "datetime",
    ylab = "Voltage",
    type = "l",
    xaxt = "n"
)

axis(1,
     at = c(1, 1440, 2880),
     labels = c("Thu", "Fri", "Sat"))

##bottomleft #3 plot
plot(
    1:dim(householdpower)[1],
    householdpower$Sub_metering_1,
    xlab = "",
    ylab = "Energy sub metering",
    type = "l",
    xaxt = "n"
)

lines(1:dim(householdpower)[1], householdpower$Sub_metering_2, col = "red")
lines(1:dim(householdpower)[1], householdpower$Sub_metering_3, col = "blue")

axis(1,
     at = c(1, 1440, 2880),
     labels = c("Thu", "Fri", "Sat"))

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = 1
)

##bottomright #4 plot
plot(
    1:dim(householdpower)[1],
    householdpower$Global_reactive_power,
    xlab = "datetime",
    ylab = "Global_reactive_power",
    type = "l",
    xaxt = "n"
)

axis(1,
     at = c(1, 1440, 2880),
     labels = c("Thu", "Fri", "Sat"))

dev.off()

