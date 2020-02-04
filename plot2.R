## This first line will likely take a few seconds. So check if it is already loaded in 
## environment variables so we do not reload with every run
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Problem Statement - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

fipsNEI  <- NEI[NEI$fips=="24510", ]

agg_total_by_year <- aggregate(Emissions ~ year, fipsNEI, sum)
color_list = c("red", "blue", "green", "yellow")

png('plot2.png')
barplot(height=agg_total_by_year$Emissions, names.arg=agg_total_by_year$year, 
        xlab="years", ylab=expression('total PM'[2.5]*' emission'), ylim = c(0,4000),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'), col = color_list)
dev.off()