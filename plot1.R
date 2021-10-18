library(ggplot2)
library(RColorBrewer)

# Create Data folder if not exist.
if (!file.exists("./data")) {
  dir.create("./data")
}

# Download the data file and extract it to data folder.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data.zip")
unzip("./data.zip", exdir = "./data")

#Delete the zip file after extraction.
unlink("./data.zip")

# Load the data:
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

str(NEI)
str(SCC)

totalNEI <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png", width = 450, height = 450)

plot(
  totalNEI$year,
  totalNEI$Emissions,
  type = "o",
  col = "steelblue3",
  main = expression("Total US "~ PM[2.5]~ "Emissions by Year"),
  ylab = expression("Total US "~   PM[2.5] ~ "Emissions"), 
  xlab = "Year"
  )
dev.off()
