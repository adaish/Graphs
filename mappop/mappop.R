#Mapping London (Code dojo london 11/02/2015)
rm(list=ls()) #Remove 

#Using http://spatial.ly/2013/12/introduction-spatial-data-ggplot2/

#set up packages
install.packages("ggplot2")
install.packages("reshape2")
install.packages("ggmap")
install.packages("rgdal")

require(ggplot2)
require(reshape2)
require(ggmap)
require(rgdal)


#Set working directory and load files
setwd("C:/Users/sarah inspiron/Documents/GitHub/Graphs/mappop") #set up location of file
london.data<-read.csv("C:/Users/sarah inspiron/Documents/GitHub/Graphs/mappop/census-historic-population-borough.csv")
london.data.melt <- melt(london.data, id = c("Area.Code", "Area.Name"))
#melt is a useful reshape tool

#load shape files
sport <- readOGR(dsn = ".", "london_sport")
sport.f <- fortify(sport, region = "ons_label")

#make the prepares plot data
plot.data <- merge(sport.f, london.data.melt, by.x = "id", by.y = "Area.Code")
#plot.data ordered
plot.data <- plot.data[order(plot.data$order), ]

#plots population of london on map
ggplot(data = plot.data, aes(x = long, y = lat, fill = value, group = group)) + 
  geom_polygon() + geom_path(colour = "grey", lwd = 0.1) + coord_equal() 
  
  #+facet_wrap(~variable) #remove this to give one map rather than multiple per "variable" which is year 

#add new column which is a substring due to variable being non-numeric
plot.data$varable2<-as.numeric(substring(plot.data$variable,5))
head(plot.data) #give the top part of the data

#This creates the map but we want to create a shiner for the different year on one map

####################Shiny slider########## 
#
install.packages("shiny")
require(shiny)
library(shiny)

#This runs the example 
runExample("05_sliders") 

#where we got the run code from http://shiny.rstudio.com/reference/shiny/latest/runApp.html
runApp("C:/Users/sarah inspiron/Documents/GitHub/Graphs/mappop/shiny")
