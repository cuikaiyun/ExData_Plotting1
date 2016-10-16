##read only the data for 2007-02-01 and 2007-02-02

skipcount <-
    grep("1/2/2007", readLines("household_power_consumption.txt"))[1] - 1

householdpower <- read.table(
    "household_power_consumption.txt",
    skip = skipcount,
    nrows = 2880,
    sep = ";"
)

##add column names to the dataset
colnames(householdpower) <-
    read.table(
        "household_power_consumption.txt",
        nrows = 1,
        sep = ";",
        stringsAsFactors = FALSE
    )

##open the png graphics device
png(filename = "plot3.png", width = 480, height = 480)

##make a plot
plot(
    1:dim(householdpower)[1],
    householdpower$Sub_metering_1,
    xlab = "",
    ylab = "Energy sub metering",
    type = "l",
    xaxt = "n"
)

##add additional two lines
lines(1:dim(householdpower)[1], householdpower$Sub_metering_2, col = "red")
lines(1:dim(householdpower)[1], householdpower$Sub_metering_3, col = "blue")

##add the xaxis and legend
axis(1,
     at = c(1, 1440, 2880),
     labels = c("Thu", "Fri", "Sat"))

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = 1
)

##close the png graphics device
dev.off()
