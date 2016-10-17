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

##open a png graphics device
png(filename = "plot2.png", width = 480, height = 480)

##make a plot
plot(
    householdpower$Datetime,
    householdpower$Global_active_power,
    xlab = "",
    ylab = "Global Active Power (kilowatts)",
    type = "l"
)

##close the graphics device
dev.off()
