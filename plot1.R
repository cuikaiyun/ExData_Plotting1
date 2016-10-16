##read only the data for 2007-02-01 and 2007-02-02

skipcount <-
    grep("1/2/2007", readLines("household_power_consumption.txt"))[1] - 1

householdpower <-
    read.table(
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

##open a png graphics device
png(filename = "plot1.png", width = 480, height = 480)

##plot the histogram
hist(
    householdpower$Global_active_power,
    main = "Global Active Power",
    col = "red",
    xlab = "Global Active Power (kilowatts)"
)

##close the graphics device
dev.off()
