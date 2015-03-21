#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 2
# Alejandro Fraga
#--------------------------------

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?  
# Use Base system

# Subset data from Maryland
Maryland <- subset(NEI, fips=='24510')

# Generate the graph in the same directory as the source code
png(filename='plot2.png')

barplot(tapply(X=Maryland$Emissions, INDEX=Maryland$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()


