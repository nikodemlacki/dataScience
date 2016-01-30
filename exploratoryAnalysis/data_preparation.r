# Read Source Classification Code data
scc <- readRDS(file="Source_Classification_Code.rds")
# Read PM2.5 emmissions data
pm25_all <- readRDS(file="summarySCC_PM25.rds")

# Check what years the main data set contains to see if anything needs to be filtered out
years <- unique(pm25_all$year)
pm25_all$year <- factor(pm25_all$year)
class(pm25_all$year)

# Subset and summarise data by year
pm25_1999 <- subset(pm25_all, pm25_all$year=="1999")
dim(pm25_1999)
summary(pm25_1999$Emissions)
pm25_1999_large_values <- subset(pm25_1999, pm25_1999$Emissions>0.3)
pm25_1999_without_large_values <- subset(pm25_1999, pm25_1999$Emissions<=0.3)
summary(pm25_1999_without_large_values$Emissions)
# Outliers percentage
nrow(pm25_1999_large_values)/nrow(pm25_1999)

pm25_2002 <- subset(pm25_all, pm25_all$year=="2002")
dim(pm25_2002)
summary(pm25_2002$Emissions)
pm25_2005 <- subset(pm25_all, pm25_all$year=="2005")
dim(pm25_2005)
summary(pm25_2005$Emissions)
pm25_2008 <- subset(pm25_all, pm25_all$year=="2008")
dim(pm25_2008)
summary(pm25_2008$Emissions)
