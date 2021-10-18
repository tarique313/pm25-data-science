library(downloader)

# create the data folder if not exists
if (!file.exists("./data")) {
  dir.create("./data")
}

#Download the data file
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="./data/electric-power-consumption.zip", mode="wb") 

#Unzip the file
unzip("./data/electric-power-consumption.zip", exdir="./data", overwrite = TRUE)

# remove the downloaded zip file
unlink("./data/electric-power-consumption.zip")
