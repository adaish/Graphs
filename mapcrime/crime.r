crime<-read.csv("C:/Users/sarah inspiron/Documents/GitHub/Graphs/2014-12-city-of-london-street.csv")
require(data.table)
require(ggplot2)
head(crime)
plot(crime$Longitude,crime$Latitude)

crime1<-data.table(crime)
attach(crime1)
typecrime<-crime1[,sum(ID),by="Crime.type"]
type<-length(unique(Crime.type))
barplot(typecrime$V1,names.arg=type)

ty<- typecrime[order(-V1),] 
barplot(ty,type)#names.arg=Crime.type)
text()