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

# Get all records involving coal
coal_class_code <- class_code[grepl("Coal", class_code$Short.Name), ]
coal_emissions_data <- emissions_data[emissions_data$SCC %in% coal_class_code$SCC, ]

# Added of emissions by year
coal_emissions_year <- aggregate(coal_emissions_data$Emissions, 
                                 by=list(coal_emissions_data$year), FUN=sum)
colnames(coal_emissions_year) <- c("year", "emissions")

# Show the plot
png(filename = "plot4.png")
plot(coal_emissions_year$year, coal_emissions_year$emissions, type = "o",
     xlab = "Year",
     ylab = "Total Emissions (tons)",
     main = "Coal Related Emissions of PM2.5 in US from 1999-2008")

dev.off()
