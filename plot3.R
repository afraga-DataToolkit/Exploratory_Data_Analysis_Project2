#--------------------------------
# Coursera - Exploratory Data Analysis
# Project 2 - Plot 3
# Alejandro Fraga
#--------------------------------

library(ggplot2)

setwd("./R-Scripts/Exploratory_Data_Analysis/Week3")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3 - Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#              Which have seen increases in emissions from 1999-2008?
# Use ggplot2

# Subset for Baltimore City, Maryland using fips value
Maryland <- subset(NEI, fips == 24510)
# Define the years as factors
Maryland$year <- factor(Maryland$year, levels=c('1999', '2002', '2005', '2008'))


# Generate the graph in the same directory as the source code
png(filename='plot3.png', width=800, height=500, units='px')

ggplot(data=Maryland, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
        geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
        ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
        ggtitle('Emissions per Type in Baltimore City, Maryland') +
        geom_jitter(alpha=0.25)

ggplot2(data=Maryland, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
        geom_boxplot(aes(fill=type)) +
        ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
        ggtitle('Emissions per Type in Baltimore City, Maryland') +
        geom_jitter(alpha=0.25)

dev.off()