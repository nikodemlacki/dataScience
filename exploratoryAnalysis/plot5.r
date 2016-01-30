# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 4
# (
#   How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# )
pm25_all$year <- factor(pm25_all$year)
pm25_all$fips <- factor(pm25_all$fips)
scc$Data.Category <- factor(scc$Data.Category)
source_types <- unique(scc$Data.Category)
years <- unique(pm25_all$year)

# Merge SCC data into the subset as it will be needed to generate chart
pm25_all_extended <- merge(pm25_all, scc, by = "SCC")
pm25_all_extended <-
  subset(pm25_all_extended, grepl(x = pm25_all_extended$Short.Name, pattern = "motor vehicle"))

pm25_all_extended_baltimore <- subset(pm25_all_extended, pm25_all_extended$fips=="24510")

pm25_total_mv <- tapply(
  pm25_all_extended$Emissions,
  pm25_all_extended$year,
  sum)
pm25_totals_coal <- data.frame(years, pm25_total_coal)

plot(pm25_totals_coal, main="Total PM25 Emissions per year", xlab="Years", ylab="Emmissions")
lines(pm25_totals_coal)

