## This first line will likely take a few seconds. So check if it is already loaded in 
## environment variables so we do not reload with every run
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Problem Statement - Compare emissions from motor vehicle sources in Baltimore City with emissions from  
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# from plot2, Baltimore fips is 24510 ... 06037 is LA
# Searching for ON-ROAD type in NEI
fipsNEItypeSubset <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

agg_total_by_year_fips <- aggregate(Emissions ~ year + fips, fipsNEItypeSubset, sum)
agg_total_by_year_fips$fips[agg_total_by_year_fips$fips=="24510"] <- "Baltimore, MD"
agg_total_by_year_fips$fips[agg_total_by_year_fips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(agg_total_by_year_fips, aes(factor(year), Emissions, fill=year))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  + xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()