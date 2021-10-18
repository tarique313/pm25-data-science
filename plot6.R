library(ggplot2)

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
emissions_data <- readRDS("./data/summarySCC_PM25.rds")
class_code <- readRDS("./data/Source_Classification_Code.rds")

# Searching for ON-ROAD type in emissions_data
subset_emissions_data <- emissions_data[(emissions_data$fips=="24510"|emissions_data$fips=="06037") & emissions_data$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subset_emissions_data, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()