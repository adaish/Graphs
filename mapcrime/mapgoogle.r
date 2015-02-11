#Maps google

# loading the required packages#################################
require(ggplot2)
install.packages("ggmap")
require(ggmap)

# creating a sample data.frame with your lat/lon points
lon <- c(-152.6660156,-141.5039063,-129.9023438)
lat <- c(56.65139488,43.89789239,-38.41055825)
df <- as.data.frame(cbind(lon,lat))

#MSC CO-OD################
#All fisheries (cert, sus, in a, fail, withdrawn etc)  #only with co-ordinate available from tracker tools on 04/11/2014
df1<-read.csv("C:/barracuda/users/alice.daish/My Documents/world.csv")

# getting the map
#WORKS http://stackoverflow.com/questions/23130604/r-plot-coordinates-on-map
mappy <- get_map(location = c(0,0), zoom = "auto",maptype = "satellite", scale = "auto")

#damn it whole world not supported
mappy <- get_map(location = c(lon = mean(df1$lon), lat = mean(df1$lat)),maptype = "satellite", zoom = 4, scale = 1)

# plotting the map with some points on it
ggmap(mappy) +geom_point(data = df1, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 10, shape = 21)+ guides(fill=FALSE, alpha=FALSE, size=FALSE)

################################################################

#not pretty enough##############################################
install.packages("OpenStreetMap")
library(OpenStreetMap)
library(ggplot2)
map <- openmap(c(70,-179),
               c(-70,179),zoom=1)
map <- openproj(map)


reclat <- c(50,20,30,40)
reclong <- c(30,40,30,50)         
autoplot(map) + geom_point(aes(x=reclong,y=reclat))
##########################################################

###########rWorldmap- works 
install.packages("rworldmap")
library(rworldmap)
df2<-getMap(resolution = "low")
plot(df2)
points(df1, col="#0081c6",cex=1, pch=16)


install.packages ("RODBC")
install.packages ("data.table")
require(RODBC)
require(data.table)

dataplaice<- odbcConnect("dataplaice")#sqlTables(Anglerfish) 
mscfish<-sqlFetch(dataplaice, "FISHERY_Track_Search")
#mscfish<-data.table(mscfish)

#All fisheries lat and long minus the failed #data.table struggled with multiple where statements
fish<-mscfish[mscfish$Status!="Failed",c("Longitude","Latitude","Status"),]

#Plot the different status's
#certified fisheries
cert<-mscfish[mscfish$Status=="Certified",c("Longitude","Latitude","Status"),]
points(cert, col="#0081cd",cex=2, pch=16)
#suspended
sus<-mscfish[mscfish$Status=="Suspended",c("Longitude","Latitude","Status"),]
points(sus, col="#00b6de",cex=2, pch=16)
#in assessment 
inA<-mscfish[mscfish$Status=="InAssessment",c("Longitude","Latitude","Status"),]
points(inA, col="#fdb913",cex=2, pch=16)
#Withdrawn
wit<-mscfish[mscfish$Status=="Withdrawn",c("Longitude","Latitude","Status"),]
points(wit, col="#58595b",cex=2, pch=16)
#Stopped
stopp<-mscfish[mscfish$Status=="Stopped",c("Longitude","Latitude","Status"),]
points(stopp, col="#f47d30",cex=2, pch=16)
#Failed
fail<-mscfish[mscfish$Status=="fail",c("Longitude","Latitude","Status"),]
points(stopp, col="#f89728",cex=2, pch=16)

legend("bottomleft", c("Certified","Failed"), )






