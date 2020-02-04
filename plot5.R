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

# Problem Statement - How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# from plot2, Baltimore fips is 24510
# Searching for ON-ROAD type in NEI
fipsNEItypeSubset <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

agg_total_by_year <- aggregate(Emissions ~ year, fipsNEItypeSubset, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(agg_total_by_year, aes(factor(year), Emissions, fill=year))
g <- g + geom_bar(stat="identity") + xlab("year") + 
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()