rm(list = ls())
# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Merge SCC data into the subset
pm25_all <- merge(pm25_all, scc, by = "SCC")
# remove Event and Biogenic data categories
pm25_all <-
  subset(
    pm25_all,
    pm25_all$Data.Category %in% c("Nonpoint", "Nonroad", "Onroad", "Point"))


# Plot number 1 (Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?)
years <- unique(pm25_all$year)
pm25_all$year <- factor(pm25_all$year)
pm25_total_per_year <- tapply(pm25_all$Emissions, pm25_all$year, sum)
pm25_totals <- data.frame("year" = years, "Emissions" = pm25_total_per_year)

#boxplot(pm25_total_per_year ~ years, pm25_totals, main="Total PM25 Emissions per year", xlab="Years", ylab="Emmissions")
#plot(pm25_totals, main="Total PM25 Emissions per year", xlab="Years", ylab="Emmissions")
par(mfrow = c(1,1))
plot(pm25_totals$year, pm25_totals$Emissions,
     type = "p",
     main="Total PM25 Emissions per year",
     xlab="Years", ylab="Emmissions")
lines(pm25_totals)
dev.copy(png, filename = "plot1.png")
dev.off()
