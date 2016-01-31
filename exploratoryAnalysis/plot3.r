library(ggplot2)

rm(list = ls())
# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 3
# (
#   Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#   Which have seen increases in emissions from 1999-2008?
# )
pm25_all$year <- factor(pm25_all$year)
pm25_all$fips <- factor(pm25_all$fips)
scc$Data.Category <- factor(scc$Data.Category)
source_types <- unique(scc$Data.Category)

# Extract Baltimore data
pm25_total_baltimore <- subset(pm25_all, pm25_all$fips=="24510")
# Merge SCC data into the subset as it will be needed to generate chart
pm25_total_baltimore <- merge(pm25_total_baltimore, scc, by = "SCC")
# remove Event and Biogenic data categories
pm25_total_baltimore <-
  subset(
    pm25_total_baltimore,
    pm25_total_baltimore$Data.Category %in% c("Nonpoint", "Nonroad", "Onroad", "Point"))

# and summarise it by type of source
pm25_total_baltimore[, "year.data.category"] <- 
  paste(pm25_total_baltimore$year, pm25_total_baltimore$Data.Category, sep = ".")

pm25_total_baltimore_per_source <- tapply(
  pm25_total_baltimore$Emissions,
  pm25_total_baltimore$year.data.category,
  sum)
year_source_types <- unique(pm25_total_baltimore$year.data.category)
pm25_totals_baltimore <- data.frame(year_source_types, pm25_total_baltimore_per_source)
pm25_totals_baltimore[,"year"] <- sapply(pm25_totals_baltimore$year_source_types, substr, 1, 4)
pm25_totals_baltimore[,"source"] <- sapply(pm25_totals_baltimore$year_source_types, substr, 6, 15)

qplot(y=pm25_total_baltimore_per_source,
      x=year,
      data = pm25_totals_baltimore,
      facets = source ~ .,
      main = "Emissions in Baltimore per year and per source")

