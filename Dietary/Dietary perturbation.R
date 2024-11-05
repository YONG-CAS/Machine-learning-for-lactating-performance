library(ggplot2)
library(ggpubr)
library(RImagePalette)
library(ggsci)
library("dunn.test")

a.4$NEl.Mcal.y <- as.numeric(a.4$NEl.Mcal.y)
a.4$protein.y <- ifelse(a.4$protein.y == 181, 18.1, a.4$protein.y)
a.4$N.D.F..y <- ifelse(a.4$N.D.F..y == 17.5, 27, a.4$N.D.F..y)
a.4$protein.y <- round(a.4$protein.y, 1)
a.4$NEl.Mcal.y <- round(a.4$NEl.Mcal.y, 2)
a.4$N.D.F..y <- round(a.4$N.D.F..y, 1)
a.4$A.D.F..y <- round(a.4$A.D.F..y, 1)
a.4$Fat.y <- round(a.4$Fat.y, 1)

f1<- a.4[a.4$number<40, ]
f2<- a.4[39<a.4$number&a.4$number<114, ]
f3<- a.4[113<a.4$number&a.4$number<143, ]
f4<- a.4[142<a.4$number, ]

a.4$protein.y <- factor(a.4$protein.y)
a.4$NEl.Mcal.y <- factor(a.4$NEl.Mcal.y)
a.4$N.D.F..y <- factor(a.4$N.D.F..y )
a.4$A.D.F..y <- factor(a.4$A.D.F..y)
a.4$Fat.y <- factor(a.4$Fat.y)

f2$protein.y <- factor(f2$protein.y)
f2$NEl.Mcal.y <- factor(f2$NEl.Mcal.y)
f2$N.D.F..y <- factor(f2$protein.y)
f2$A.D.F..y <- factor(f2$A.D.F..y)
f2$Fat.y <- factor(f2$Fat.y)

f3$protein.y <- factor(f3$protein.y)
f3$NEl.Mcal.y <- factor(f3$NEl.Mcal.y)
f3$N.D.F..y <- factor(f3$protein.y)
f3$A.D.F..y <- factor(f3$A.D.F..y)
f3$Fat.y <- factor(f3$Fat.y)

f4$protein.y <- factor(f4$protein.y)
f4$NEl.Mcal.y <- factor(f4$NEl.Mcal.y)
f4$N.D.F..y <- factor(f4$protein.y)
f4$A.D.F..y <- factor(f4$A.D.F..y)
f4$Fat.y <- factor(f4$Fat.y)
x_axis_levels <- c(13.7, 13.8, 13.9, 14.0, 14.1, 14.2, 14.3, 14.4, 14.5, 14.6, 14.7, 14.8, 14.9, 15.0, 15.1, 15.2, 15.3, 15.4, 15.5, 15.6, 15.7, 15.8, 15.9, 16.0, 16.1, 16.2, 16.3, 16.4, 16.5, 16.6, 16.7, 16.8, 16.9, 17.0, 17.1, 17.2, 17.3, 17.4, 17.5, 17.6, 17.7, 17.8, 17.9, 18.0, 18.1, 18.2, 18.3, 18.4, 18.5, 18.6)

# Your ggplot code
ggplot(a.4, aes(x = factor(protein.y, levels = x_axis_levels), y = yield)) +
  geom_boxplot(fill = "#aec7e8ff") +
  scale_y_continuous(limits = c(0, 85)) +
  scale_x_discrete(expand = c(0, 0), drop = FALSE)  # This ensures all levels are shown



x_axis_levelsnel <- c(1.40, 1.41, 1.42, 1.43, 1.44, 1.45, 1.46, 1.47, 1.48, 1.49, 1.50, 1.51, 1.52, 1.53, 1.54, 1.55, 1.56, 1.57, 1.58, 1.59, 1.60, 1.61, 1.62, 1.63, 1.64, 1.65, 1.66, 1.67, 1.68, 1.69, 1.70, 1.71, 1.72, 1.73, 1.74, 1.75, 1.76, 1.77, 1.78, 1.79, 1.80, 1.81, 1.82, 1.83, 1.84, 1.85)

ggplot(a.4, aes(x = factor(NEl.Mcal.y, levels = x_axis_levelsnel),y = yield)) +
  geom_boxplot(fill="#ffbb78ff")+
  scale_y_continuous( limits = c(0, 85))+
  scale_x_discrete(expand = c(0, 0), drop = FALSE)  # This ensures all levels are shown


x_axis_levelsnel <- c(25.3, 25.4, 25.5, 25.6, 25.7, 25.8, 25.9, 26.0, 26.1, 26.2, 26.3, 26.4, 26.5, 26.6, 26.7, 26.8, 26.9, 27.0, 27.1, 27.2, 27.3, 27.4, 27.5, 27.6, 27.7, 27.8, 27.9, 28.0, 28.1, 28.2, 28.3, 28.4, 28.5, 28.6, 28.7, 28.8, 28.9, 29.0, 29.1, 29.2, 29.3, 29.4, 29.5, 29.6, 29.7, 29.8, 29.9, 30.0, 30.1, 30.2, 30.3, 30.4, 30.5, 30.6, 30.7, 30.8, 30.9, 31.0, 31.1, 31.2, 31.3, 31.4, 31.5, 31.6, 31.7, 31.8, 31.9, 32.0, 32.1, 32.2, 32.3, 32.4, 32.5, 32.6, 32.7, 32.8, 32.9, 33.0, 33.1, 33.2, 33.3, 33.4, 33.5, 33.6, 33.7, 33.8, 33.9, 34.0, 34.1, 34.2, 34.3, 34.4, 34.5, 34.6, 34.7, 34.8, 34.9, 35.0, 35.1, 35.2, 35.3, 35.4, 35.5, 35.6, 35.7, 35.8, 35.9, 36.0, 36.1, 36.2, 36.3, 36.4, 36.5, 36.6, 36.7, 36.8, 36.9, 37.0, 37.1, 37.2, 37.3, 37.4, 37.5, 37.6, 37.7, 37.8, 37.9, 38.0, 38.1, 38.2, 38.3, 38.4, 38.5)


ggplot(a.4,aes(x = factor(N.D.F..y , levels = x_axis_levelsnel),y = yield)) +
  geom_boxplot(fill="#FF9896FF")+
  scale_y_continuous( limits = c(0, 85))+
  scale_x_discrete(expand = c(0, 0), drop = FALSE) 

x_axis_levelsadf <- c(15.7, 15.8, 15.9, 16.0, 16.1, 16.2, 16.3, 16.4, 16.5, 16.6, 16.7, 16.8, 16.9, 17.0, 17.1, 17.2, 17.3, 17.4, 17.5, 17.6, 17.7, 17.8, 17.9, 18.0, 18.1, 18.2, 18.3, 18.4, 18.5, 18.6, 18.7, 18.8, 18.9, 19.0, 19.1, 19.2, 19.3, 19.4, 19.5, 19.6, 19.7, 19.8, 19.9, 20.0, 20.1, 20.2, 20.3, 20.4, 20.5, 20.6, 20.7, 20.8, 20.9, 21.0, 21.1, 21.2, 21.3, 21.4, 21.5, 21.6, 21.7, 21.8, 21.9, 22.0, 22.1, 22.2, 22.3, 22.4, 22.5, 22.6, 22.7, 22.8, 22.9, 23.0)

ggplot(a.4, aes(x = factor(A.D.F..y , levels = x_axis_levelsadf), y = yield)) +
  geom_boxplot(fill="#C49C94FF")+
  scale_y_continuous( limits = c(0, 85))+
  scale_x_discrete(expand = c(0, 0), drop = FALSE)  
x_axis_levelsfat <- c(2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9, 6.0, 6.1, 6.2)
ggplot(a.4,  aes(x = factor(Fat.y , levels = x_axis_levelsfat), y = yield)) +
  geom_boxplot(fill="#F7B6D2FF")+
  scale_y_continuous( limits = c(0, 85))+
  scale_x_discrete(expand = c(0, 0), drop = FALSE) 


#f2


ggplot(f2, aes(x=protein.y, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))

ggplot(f2, aes(x=NEl.Mcal.y, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3)+
  scale_y_continuous( limits = c(0, 85)) 


ggplot(f2, aes(x=N.D.F..y, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85)) 


ggplot(f2, aes(x=A.D.F..y, y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))  

ggplot(f2, aes(x=Fat.y, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))

#f3
ggplot(f3, aes(x=protein.y, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))

ggplot(f3, aes(x=NEl.Mcal.y, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3)+
  scale_y_continuous( limits = c(0, 85)) 


ggplot(f3, aes(x=N.D.F..y, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85)) 


ggplot(f3, aes(x=A.D.F..y, y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))  

ggplot(f3, aes(x=Fat.y, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3)+
  scale_y_continuous( limits = c(0, 85))


#f4
ggplot(f4, aes(x=protein.y, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)

ggplot(f4, aes(x=NEl.Mcal.y, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3)


ggplot(f4, aes(x=N.D.F..y, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3)


ggplot(f4, aes(x=A.D.F..y, y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3)

ggplot(f4, aes(x=Fat.y, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3)




ggplot(all.2, aes(x=protein, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)

ggplot(all.2, aes(x=NEl.Mcal, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3) 

ggplot(all.2, aes(x=Forage, y = yield)) +
  geom_violin(fill="#98DF8AFF")+
  geom_boxplot(fill="#98DF8AFF",width = 0.3) 

ggplot(all.2, aes(x=N.D.F, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3) 

ggplot(all.2, aes(x=Forage.NDF, y = yield)) +
  geom_violin(fill="#C5B0D5Ff")+
  geom_boxplot(fill="#C5B0D5Ff",width = 0.3) 

ggplot(all.2, aes(x=A.D.F., y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3) 

ggplot(all.2, aes(x=Fat, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3) 

ggplot(all.2, aes(x=UIP, y = yield)) +
  geom_violin(fill="#C7C7C7EF")+
  geom_boxplot(fill="#C7C7C7EF",width = 0.3) 

ggplot(all.2, aes(x=NSC, y = yield)) +
  geom_violin(fill="#DBDB8DFF")+
  geom_boxplot(fill="#DBDB8DFF",width = 0.3) 

ggplot(all.2, aes(x=starch, y = yield)) +
  geom_violin(fill="#9EDAE5Ff")+
  geom_boxplot(fill="#9EDAE5Ff",width = 0.3) 


ggplot(all.2, aes(x=sugar, y = yield)) +
  geom_violin(fill="#9467BDFF")+
  geom_boxplot(fill="#9467BDFF",width = 0.3) 

ggplot(all.2, aes(x=soluble.fiber, y = yield)) +
  geom_violin(fill="#FF7F0EFF")+
  geom_boxplot(fill="#FF7F0EFF",width = 0.3) 


#高二配方
ggplot(all.3, aes(x=protein, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)

ggplot(all.3, aes(x=NEl.Mcal, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3) 

ggplot(all.3, aes(x=Forage, y = yield)) +
  geom_violin(fill="#98DF8AFF")+
  geom_boxplot(fill="#98DF8AFF",width = 0.3) 

ggplot(all.3, aes(x=N.D.F, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3) 

ggplot(all.3, aes(x=Forage.NDF, y = yield)) +
  geom_violin(fill="#C5B0D5Ff")+
  geom_boxplot(fill="#C5B0D5Ff",width = 0.3) 

ggplot(all.3, aes(x=A.D.F., y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3) 

ggplot(all.3, aes(x=Fat, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3) 

ggplot(all.3, aes(x=UIP, y = yield)) +
  geom_violin(fill="#C7C7C7EF")+
  geom_boxplot(fill="#C7C7C7EF",width = 0.3) 

ggplot(all.3, aes(x=NSC, y = yield)) +
  geom_violin(fill="#DBDB8DFF")+
  geom_boxplot(fill="#DBDB8DFF",width = 0.3) 

ggplot(all.3, aes(x=starch, y = yield)) +
  geom_violin(fill="#9EDAE5Ff")+
  geom_boxplot(fill="#9EDAE5Ff",width = 0.3) 

#低产配方
ggplot(all.4, aes(x=protein, y = yield)) +
  geom_violin(fill="#aec7e8ff")+
  geom_boxplot(fill="#aec7e8ff",width = 0.3)

ggplot(all.4, aes(x=NEl.Mcal, y = yield)) +
  geom_violin(fill="#ffbb78ff")+
  geom_boxplot(fill="#ffbb78ff",width = 0.3) 

ggplot(all.4, aes(x=Forage, y = yield)) +
  geom_violin(fill="#98DF8AFF")+
  geom_boxplot(fill="#98DF8AFF",width = 0.3) 

ggplot(all.4, aes(x=N.D.F, y = yield)) +
  geom_violin(fill="#FF9896FF")+
  geom_boxplot(fill="#FF9896FF",width = 0.3) 

ggplot(all.4, aes(x=Forage.NDF, y = yield)) +
  geom_violin(fill="#C5B0D5Ff")+
  geom_boxplot(fill="#C5B0D5Ff",width = 0.3) 

ggplot(all.4, aes(x=A.D.F., y = yield)) +
  geom_violin(fill="#C49C94FF")+
  geom_boxplot(fill="#C49C94FF",width = 0.3) 

ggplot(all.4, aes(x=Fat, y = yield)) +
  geom_violin(fill="#F7B6D2FF")+
  geom_boxplot(fill="#F7B6D2FF",width = 0.3) 

ggplot(all.4, aes(x=UIP, y = yield)) +
  geom_violin(fill="#C7C7C7EF")+
  geom_boxplot(fill="#C7C7C7EF",width = 0.3) 

ggplot(all.4, aes(x=NSC, y = yield)) +
  geom_violin(fill="#DBDB8DFF")+
  geom_boxplot(fill="#DBDB8DFF",width = 0.3) 

ggplot(all.4, aes(x=starch, y = yield)) +
  geom_violin(fill="#9EDAE5Ff")+
  geom_boxplot(fill="#9EDAE5Ff",width = 0.3) 


formula$type<-factor(formula$type)


formula.1 <- formula[formula$type==1, ]
formula.2 <- formula[formula$type==2, ]
formula.3 <- formula[formula$type==3, ]
formula.4 <- formula[formula$type==4, ]


ggplot(formula.1, aes(x = as.Date(begin))) +
  geom_bar() +
  scale_x_date(date_breaks = "1 month", date_labels = "%m", 
               limits = c(as.Date("2017-08-01"), as.Date("2021-07-31"))) +
  labs(x = "time", y = "Number") +
  theme_classic()


ggplot(formula.2, aes(x = as.Date(begin))) +
  geom_bar() +
  scale_x_date(date_breaks = "1 month", date_labels = "%m", 
               limits = c(as.Date("2017-08-01"), as.Date("2021-07-31"))) +
  labs(x = "time", y = "Number") +
  theme_classic()

ggplot(formula.3, aes(x = as.Date(begin))) +
  geom_bar() +
  scale_x_date(date_breaks = "1 month", date_labels = "%m", 
               limits = c(as.Date("2017-08-01"), as.Date("2021-07-31"))) +
  labs(x = "time", y = "Number") +
  theme_classic()
ggplot(formula.4, aes(x = as.Date(begin))) +
  geom_bar() +
  scale_x_date(date_breaks = "1 month", date_labels = "%m", 
               limits = c(as.Date("2017-08-01"), as.Date("2021-07-31"))) +
  labs(x = "time", y = "Number") +
  theme_classic()

all$formula <- factor(all$formula, levels = c("a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16", "a17", "a18", "a19", "a20",
                                              "a21","a22","a23","a24","a25","a26","a27","a28","a29","a30","a31","a32","a33","a34",
                                              "a35","a36","a37","a38","a39"))
ggplot(all, aes(x=formula, y = yield,fill=formula)) +
  geom_violin()


all.2$formula <- factor(all.2$formula, levels = c("b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b10", 
                                                  "b11", "b12", "b13", "b14", "b15", "b16", "b17", "b18", "b19", "b20",
                                                  "b21", "b22", "b23", "b24", "b25", "b26", "b27", "b28", "b29", "b30",
                                                  "b31", "b32", "b33", "b34", "b35", "b36", "b37", "b38", "b39", "b40",
                                                  "b41", "b42", "b43", "b44", "b45", "b46", "b47", "b48", "b49", "b50",
                                                  "b51", "b52", "b53", "b54", "b55", "b56", "b57", "b58", "b59", "b60",
                                                  "b61", "b62", "b63", "b64", "b65", "b66", "b67", "b68", "b69", "b70",
                                                  "b71", "b72", "b73", "b74"))
ggplot(all.2, aes(x=formula, y = yield,fill=formula)) +
  geom_violin()

all.3$formula <- factor(all.3$formula, levels =  c("c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", 
                                                   "c11", "c12", "c13", "c14", "c15", "c16", "c17", "c18", "c19", "c20",
                                                   "c21", "c22", "c23", "c24", "c25", "c26", "c27", "c28", "c29"))


ggplot(all.3, aes(x=formula, y = yield,fill=formula)) +
  geom_violin()

all.4$formula <- factor(all.4$formula, levels =  c("d1", "d2", "d3", "d4", "d5", "d6", "d7", "d8", "d9", "d10", 
                                                   "d11", "d12", "d13", "d14", "d15", "d16", "d17", "d18", "d19", "d20"))


ggplot(all.4, aes(x=formula, y = yield,fill=formula)) +
  geom_violin()+
  geom_boxplot(width = 0.3)






