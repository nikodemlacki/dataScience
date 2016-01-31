rm(list = ls())
# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 6
# (
#   Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
#     in Los Angeles County, California (fips == "06037").
#   Which city has seen greater changes over time in motor vehicle emissions?
# )

# Prepare data (convert to factors) and add auxiliary variables
pm25_all$year <- factor(pm25_all$year)
pm25_all$fips <- factor(pm25_all$fips)
scc$Data.Category <- factor(scc$Data.Category)
source_types <- unique(scc$Data.Category)
years <- unique(pm25_all$year)

# Extract data from Baltimore and Los Angeles counties into separate variables
pm25_all_extended_baltimore <- subset(pm25_all, pm25_all$fips=="24510")
pm25_all_extended_la <- subset(pm25_all, pm25_all$fips=="06037")
# Merge values from Baltimore and Los Angeles with SCC data to filter by SCC.Level.Two value later
pm25_baltimore <- merge(pm25_all_extended_baltimore, scc, by = "SCC")
pm25_la <- merge(pm25_all_extended_la, scc, by = "SCC")
# Filter vaues that only relate to vehicles
pm25_baltimore <-
  subset(pm25_baltimore, grepl(x = pm25_baltimore$SCC.Level.Two, pattern = "vehicle", ignore.case = TRUE))
pm25_la <-
  subset(pm25_la, grepl(x = pm25_la$SCC.Level.Two, pattern = "vehicle", ignore.case = TRUE))


pm25_total_per_year_baltimore <- tapply(
  pm25_baltimore$Emissions,
  pm25_baltimore$year,
  sum)
pm25_totals_baltimore <- data.frame(years, pm25_total_per_year_baltimore)

pm25_total_per_year_la <- tapply(
  pm25_la$Emissions,
  pm25_la$year,
  sum)
pm25_totals_la <- data.frame(years, pm25_total_per_year_la)

par(mfrow = c(2,1))
plot(pm25_totals_baltimore, main="Total PM25 Vehicle Emissions per year",
     xlab="Years", ylab="Emmissions in Baltimore")
lines(pm25_totals_baltimore)
plot(pm25_totals_la, main="Total PM25 Vehicle Emissions per year", xlab="Years", ylab="Emmissions in LA")
lines(pm25_totals_la)

dev.copy(png, filename = "plot6.png")
dev.off()