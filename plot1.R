## This first line will likely take a few seconds. So check if it is already loaded in 
## environment variables so we do not reload with every run
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Problem Statement - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

agg_total_by_year <- aggregate(Emissions ~ year, NEI, sum)
color_list <- c("red", "blue", "green", "yellow")

png('plot1.png')
barplot(height=agg_total_by_year$Emissions, names.arg=agg_total_by_year$year, 
        xlab="years", ylab=expression('total PM'[2.5]*' emission'), ylim = c(0,8000000),
        main=expression('Total PM'[2.5]*' emissions at various years'), col = color_list)
dev.off()
