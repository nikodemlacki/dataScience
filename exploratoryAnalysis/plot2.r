# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 2 (Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?)
pm25_all$year <- factor(pm25_all$year)
pm25_all$fips <- factor(pm25_all$fips)
years <- unique(pm25_all$year)
# Extract Baltimore data
pm25_total_baltimore <- subset(pm25_all, pm25_all$fips=="24510")
# and summarise it by year
pm25_total_baltimore_per_year <- tapply(pm25_total_baltimore$Emissions, pm25_total_baltimore$year, sum)
pm25_totals_baltimore <- data.frame(years, pm25_total_baltimore_per_year)

plot(pm25_totals_baltimore, main="Total PM25 Emissions per year in Baltimore", xlab="Years", ylab="Emmissions")
lines(pm25_totals_baltimore)
