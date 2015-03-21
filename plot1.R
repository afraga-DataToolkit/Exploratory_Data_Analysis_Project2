#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 1
# Alejandro Fraga
#--------------------------------

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Use Base system

# Prepare the Data for graph, add the emissions by year & apply some rounding
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Generate the graph in the same directory as the source code
png(filename='plot1.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()