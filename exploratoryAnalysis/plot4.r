# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Plot number 4
# (
#   Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# )
pm25_all$year <- factor(pm25_all$year)
pm25_all$fips <- factor(pm25_all$fips)
scc$Data.Category <- factor(scc$Data.Category)
source_types <- unique(scc$Data.Category)

# Merge SCC data into the subset as it will be needed to generate chart
pm25_all_extended <- merge(pm25_all, scc, by = "SCC")
pm25_all_extended <- subset(pm25_all_extended, grepl(x = pm25_all_extended$Short.Name, pattern = "* Coal*"))
# remove Event and Biogenic data points
pm25_total_baltimore <-
  subset(
    pm25_total_baltimore,
    pm25_total_baltimore$Data.Category %in% c("Nonpoint", "Nonroad", "Onroad", "Point"))


