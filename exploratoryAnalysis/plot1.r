# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 1 (Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?)
pm25_all$year <- factor(pm25_all$year)
pm25_total_per_year <- tapply(pm25_all$Emissions, pm25_all$year, sum)
years <- unique(pm25_all$year)
pm25_totals <- data.frame(years, pm25_total_per_year)

plot(pm25_totals, main="Total PM25 Emissions per year", xlab="Years", ylab="Emmissions")
lines(pm25_totals)
