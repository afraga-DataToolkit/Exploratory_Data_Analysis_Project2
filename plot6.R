#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 6
# Alejandro Fraga
#--------------------------------

library(ggplot2)

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#              Which city has seen greater changes over time in motor vehicle emissions?

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland
# Los Angeles County, California
Maryland.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
California.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
Maryland.DF <- aggregate(Maryland.onroad[, 'Emissions'], by=list(Maryland.onroad$year), sum)
colnames(Maryland.DF) <- c('year', 'Emissions')
Maryland.DF$City <- paste(rep('MD', 4))

California.DF <- aggregate(California.onroad[, 'Emissions'], by=list(California.onroad$year), sum)
colnames(California.DF) <- c('year', 'Emissions')
California.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(Maryland.DF, California.DF))

# Generate the graph in the same directory as the source code
png('plot6.png')

ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()