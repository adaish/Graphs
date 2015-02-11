##############################Maps google ######################
#install.packages("ggplot2")
#install.packages("ggmap")
require(ggplot2)
require(ggmap)

# creating a sample data.frame with your lat/lon points
citycrimelondon<-read.csv("C:/Users/sarah inspiron/Documents/GitHub/Graphs/Graphs/2014-12-city-of-london-street.csv")
lon <- citycrimelondon$Longitude
lat <- citycrimelondon$Latitude
df <- as.data.frame(cbind(lon,lat))

# getting the map
mapgilbert <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 14,
                      maptype = "satellite", scale = 2)

# plotting the map with some points on it
ggmap(mapgilbert) +
  geom_point(data = citycrimelondon, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 4, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)


