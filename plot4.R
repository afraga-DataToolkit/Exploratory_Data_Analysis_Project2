#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 4
# Alejandro Fraga
#--------------------------------

library(ggplot2)

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4 - Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Use ggplot2

# Grab coal data from SCC
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge the NEI and the SCC data set using SCC ID
merge <- merge(x=NEI, y=SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

# Generate the graph in the same directory as the source code
png(filename='plot4.png', width=800, height=500, units='px')

ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + 
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
        ggtitle(expression('Total Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

dev.off()