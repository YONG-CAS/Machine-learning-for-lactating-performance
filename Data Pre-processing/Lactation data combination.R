library(dplyr)
library(readr)
a<-read.csv("C://Users/Evan/Desktop/1.csv")
b<-read.csv("C://Users/Evan/Desktop/2.csv")
c<-read.csv("C://Users/Evan/Desktop/3.csv")
d<-read.csv("C://Users/Evan/Desktop/4.csv")
e<-read.csv("C://Users/Evan/Desktop/5.csv")
f<-read.csv("C://Users/Evan/Desktop/a.csv")
g<-read.csv("C://Users/Evan/Desktop/b.csv")
h<-read.csv("C://Users/Evan/Desktop/dk.csv")
i<-read.csv("C://Users/Evan/Desktop/e1.csv")
j<-read.csv("C://Users/Evan/Desktop/g.csv")
k<-read.csv("C://Users/Evan/Desktop/h.csv")
l<-read.csv("C://Users/Evan/Desktop/i1.csv")





lactation_period<-read.csv("C://Users/Evan/Desktop/k.csv")





a$time <- as.Date(a$time)
b$time <- as.Date(b$time)
c$time <- as.Date(c$time)
d$time <- as.Date(a$time)
e$time <- as.Date(a$time)
f$time <- as.Date(a$time)
g$time <- as.Date(a$time)
h$time <- as.Date(a$time)
i$time <- as.Date(a$time)
j$time <- as.Date(a$time)
k$time <- as.Date(a$time)
l$time <- as.Date(a$time)
m$time <- as.Date(a$time)

lactation_period$begin <- as.Date(lactation_period$begin)
lactation_period$end <- as.Date(lactation_period$end)






all.1<-rbind(a,b,c,d,e,f,g,h,i,j,k,l)

all.2 <- all.1 %>%
  left_join(lactation_period, by = "uid", relationship = "many-to-many") %>%
  filter(time >= begin, time <= end)







