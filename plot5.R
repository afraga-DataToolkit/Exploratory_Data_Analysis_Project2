#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 5
# Alejandro Fraga
#--------------------------------

library(ggplot2)

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 5 - How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
Maryland.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Sum the onroad Emission data from the Maryland subset by year usign Aggregate
Maryland.df <- aggregate(Maryland.onroad[, 'Emissions'], by=list(Maryland.onroad$year), sum)
colnames(Maryland.df) <- c('year', 'Emissions')

# Generate the graph in the same directory as the source code
png('plot5.png')

ggplot(data=Maryland.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()