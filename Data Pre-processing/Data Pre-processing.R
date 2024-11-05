library(dplyr)
library(readr)
library(openxlsx)
library(writexl)
library(psych)
library(reshape2)


# Read data
all.1<-read.csv("C://Users/Evan/Desktop/Lactation data.csv")
lactation_period<-read.csv("C://Users/Evan/Desktop/lactation_period.csv")
THI <- read.csv("C://Users/Evan/Desktop/THI.csv")
birthday <- read.csv("C://Users/Evan/Desktop/birth_time.csv")
THI$time <- as.Date(THI$time)
formula2 <- read.csv("C://Users/Evan/Desktop/formula1.csv")
ill <- read.csv("C://Users/Evan/Desktop/Disease.csv")
formula$begin <- as.Date(formula$begin)
formula$end <- as.Date(formula$end)
birthday <- read.csv("C://Users/Evan/Desktop/copy_5_years_data.csv")

lactation_period$begin <- as.Date(lactation_period$begin)
lactation_period$end <- as.Date(lactation_period$end)




all.2 <- all.1 %>%
  left_join(lactation_period, by = "uid", relationship = "many-to-many") %>%
  filter(time >= begin, time <= end)



# Data integration
all.2 <- all.1 %>%
  left_join(THI, by = "time")

all.1 <- all %>%
  left_join(formula, by = "formula")

all.3 <- all.2
for (i in 1:nrow(all.3)) {
  time_point <- all.3$time[i]
  
  # Find matching rows in formula
  matching_row <- formula$begin <= time_point & time_point <= formula$end
  
  # If there are matching rows, assign the corresponding formula to all.3
  if (any(matching_row)) {
    all.3$formula[i] <- formula$formula[matching_row]
  }
}

all.4 <- all.3

for (i in 1:nrow(all.4)) {
  time_point <- all.4$time[i]
  
  # Find matching rows in ill
  matching_row <- all.4$uid == ill$uid & ill$begin <= time_point & time_point <= ill$end
  
  # If there are matching rows, assign the corresponding ill value to all.4
  if (any(matching_row)) {
    all.4$ill[i] <- ill$day[matching_row]
  }
}

all <- rbind(a, b, c, d, e, f, g, h, i)
all.5 <- readRDS("C://Users/Evan/Desktop/fill.rds")

# Calculate days
result_df <- all.5 %>%
  mutate(days = as.numeric(difftime(time, begin, units = "days"))) %>%
  filter(days >= 1 & days <= 305)

# Separate data for parity and days in milk
births <- readRDS("C://Users/Evan/Desktop/all6.rds")

births <- data.frame(
  days = result_df$days,
  yield = result_df$yield,
  births = result_df$births
)

births$births[births$births > 5] <- 5

births.1 <- all.1[all.1$births == 1, ]
births.2 <- all.1[all.1$births == 2, ]
births.3 <- all.1[all.1$births == 3, ]
births.4 <- all.1[all.1$births == 4, ]
births.5 <- all.1[all.1$births == 5, ]
saveRDS(a.1, file("C://Users/Evan/Desktop/a1.rds"))

# Heat stress
all.6 <- readRDS("C://Users/Evan/Desktop/all6.rds")
THI1 <- data.frame(all.6$time, all.6$yield, all.6$days)
colnames(THI1) <- c("time", "yield", "days")

THI <- read.csv("C://Users/Evan/Desktop/THI.csv")

all.6$time <- as.Date(all.6$time)
THI$time <- as.Date(THI$Time) 
thi.all <- all.6 %>%
  left_join(THI, by = "time")

thi1 <- thi.all[thi.all$stress == 1, ]
thi2 <- thi.all[thi.all$stress == 2, ]
thi3 <- thi.all[thi.all$stress == 3, ]
thi4 <- thi.all[thi.all$stress == 4, ]
thi5 <- thi.all[thi.all$stress == 5, ]
saveRDS(thi.all, file("C://Users/Evan/Desktop/thi-yieldall.rds"))
saveRDS(thi1, file("C://Users/Evan/Desktop/thi1.rds"))
saveRDS(thi2, file("C://Users/Evan/Desktop/thi2.rds"))
saveRDS(thi3, file("C://Users/Evan/Desktop/thi3.rds"))
saveRDS(thi4, file("C://Users/Evan/Desktop/thi4.rds"))
saveRDS(thi5, file("C://Users/Evan/Desktop/thi5.rds"))

# Formula information
THI <- read.csv("C://Users/Evan/Desktop/thi.csv")
THI2 <- data.frame(THI$time, THI$stress)
colnames(THI2) <- c("time", "stress")
formula <- read.csv("C://Users/Evan/Desktop/time.csv")
THI2$time <- as.Date(THI2$time)
formula$begin <- as.Date(formula$begin)
formula$end <- as.Date(formula$end)

saveRDS(all.1, file("C://Users/Evan/Desktop/all.1.rds"))
write_xlsx(formula2, path = "C://Users/Evan/Desktop/formula.xlsx")

all.6 <- readRDS("C://Users/Evan/Desktop/all6.rds")

formula.1 <- all.6[all.6$formula %in% c(7, 23, 36, 49, 8, 22), ]
formula.2 <- all.6[all.6$formula %in% c(2, 5, 12, 13, 14, 19, 26, 32, 33, 38, 46, 55, 56, 57, 58, 65, 69), ]
formula.3 <- all.6[all.6$formula %in% c(1, 15, 59, 60, 71, 16, 30), ]

# Disease information
ill <- all.6[all.6$s %in% c(1, 15, 59, 60, 71, 16, 30), ]
ill <- all.6[!is.na(all.6$ill_day), ]
all.6$ill_day <- as.Date(all.6$ill_day)

all <- all.6 %>%
  mutate(
    time = as.POSIXct(format(time, format = "%Y-%m-%d")),
    ill_day = as.POSIXct(format(ill_day, format = "%Y-%m-%d")),
    ill = as.integer(difftime(time, ill_day, units = "days"))
  )

ill.1 <- all[all$ill >= -15 & all$ill <= 15, ]
ill.2 <- result_df[result_df$ill >= 0 & result_df$ill <= 45, ]

all$ill <- ifelse(is.na(all$ill), 50, all$ill)

saveRDS(all.1, file("C://Users/Evan/Desktop/all.rds")) 
all.1 <- readRDS("C://Users/Evan/Desktop/all.rds")

all.2 <- all.1[all.1$days >= 40 & all.1$days <= 60, ]
all.3 <- all.2[all.2$births == 1, ]

values_df <- data.frame(yield = yield)

# Formula information
all <- readRDS("C://Users/Evan/Desktop/cow_milk/all.rds")
low <- read.csv("C://Users/Evan/Desktop/low.csv")
colostrum <- read.csv("C://Users/Evan/Desktop/colostrum.csv")
lowhigh <- read.csv("C://Users/Evan/Desktop/low_high_2.csv")
formula <- read.csv("C://Users/Evan/Desktop/new_excel_sheet.csv")
lowhigh$time <- as.Date(lowhigh$time)
formula$begin <- as.Date(formula$begin)
formula$end <- as.Date(formula$end)

colostrum$time <- as.Date(colostrum$time)
all.low <- all %>%
  left_join(low, by = c("uid", "time"))

all.1 <- a.1[a.1$type == 1, ]
all.2 <- a.1[a.1$type == 2, ]
all.3 <- a.1[a.1$type.x == 3, ]
all.4 <- a.1[a.1$type == 4, ]

formula.1 <- formula[formula$type == 1, ]
formula.2 <- formula[formula$type == 2, ]
formula.3 <- formula[formula$type == 3, ]
formula.4 <- formula[formula$type == 4, ]

a.1$time <- as.Date(a.1$time)
formula.1$begin <- as.Date(formula.1$begin)
formula.1$end <- as.Date(formula.1$end)

a.1 <- all %>% filter(!is.na(type))

for (i in 1:nrow(all.4)) {
  time_point <-all.4$time[i]
  time_point<-as.Date(time_point)
  matching_row <- formula.4$begin <= time_point & time_point <= formula.4$end

  if (any(matching_row)) {
    all.4$formula[i] <- formula.4$formula[matching_row]
  }
}



all.4 <- a.3 %>%
  left_join(formula2, by = "formula")

all<-rbind(all.1,all.1a)

saveRDS(all,file("C://Users/Evan/Desktop/colostrum.rds"))
saveRDS(all.2,file("C://Users/Evan/Desktop/high.rds"))
saveRDS(all,file("C://Users/Evan/Desktop/high2.rds"))
saveRDS(all,file("C://Users/Evan/Desktop/low.rds"))


a.1<-rbind(all,all.2,all.3,all.4)
all$protein[all$protein == 181] <- 18.1
saveRDS(a.1,file("C://Users/Evan/Desktop/all.rds"))

all$dry <- all$Dry.matter / all$Wet.matter
all.2$dry <- all.2$Dry.matter / all.2$Wet.matter
all.3$dry <- all.3$Dry.matter / all.3$Wet.matter
all.4$dry <- all.4$Dry.matter / all.4$Wet.matter

all<- a.1[a.1$type.x==1, ]

a.2 <- a.1 %>%
  left_join(birthday, by = c("uid"))

a.2 <- inner_join(a.1, filtered_result, by = c("uid", "births")) 
a.3<- a.2 %>%
  left_join(birthday, by = "uid")
a.3 <- a.3 %>%
  filter(days >= 5 & days <= 305)

saveRDS(a.3,file("C://Users/Evan/Desktop/fill.rds"))
a.4<- a.4 %>%
  left_join(formula, by = "formula")
a.4 <- all.4[, c("uid", "yield", "births","THI.y", "protein.y","NEl.Mcal.y","N.D.F..y","A.D.F..y","Fat.y","number", "ill", "days","stress","formula")]
saveRDS(a.4,file("C://Users/Evan/Desktop/rfr.rds"))
a.3$days <- as.numeric(a.3$days)
a.3$yield <- as.numeric(a.3$yield)
B1<- a.3[a.3$births==1, ]
B2<- a.3[a.3$births==2, ]
B3<- a.3[a.3$births==3, ]
B4<- a.3[a.3$births==4, ]
B5<- a.3[a.3$births>4, ]
saveRDS(B1,file("C://Users/Evan/Desktop/B1.rds"))
saveRDS(B2,file("C://Users/Evan/Desktop/B2.rds"))
saveRDS(B3,file("C://Users/Evan/Desktop/B3.rds"))
saveRDS(B4,file("C://Users/Evan/Desktop/B4.rds"))
saveRDS(B5,file("C://Users/Evan/Desktop/B5.rds"))

T1<- a.3[a.3$stress==1, ]
T2<- a.3[a.3$stress==2, ]
T3<- a.3[a.3$stress==3, ]
T4<- a.3[a.3$stress==4, ]
saveRDS(T1,file("C://Users/Evan/Desktop/T1.rds"))
saveRDS(T2,file("C://Users/Evan/Desktop/T2.rds"))
saveRDS(T3,file("C://Users/Evan/Desktop/T3.rds"))
saveRDS(T4,file("C://Users/Evan/Desktop/T4.rds"))
saveRDS(a.1,file("C://Users/Evan/Desktop/a.1.rds"))
saveRDS(a1,file("C://Users/Evan/Desktop/Disease.rds"))
saveRDS(all.4,file("C://Users/Evan/Desktop/a.1.rds"))
all<-readRDS("C://Users/Evan/Desktop/奶牛泌乳/a1.rds")
a.time <- a.3[, c("uid","time" ,"yield", "births","THI.y", "protein","NEl.Mcal","N.D.F","A.D.F","Fat","number", "Disease", "days","stress","formula")]
a.time$time.month <- format(a.time$time, "%Y-%m")


new_table <- all.5%>%
  group_by(time) %>%
  summarise(
    total_yield = sum(yield, na.rm = TRUE),     
    count = n(),                                 
    average_yield = mean(yield, na.rm = TRUE)    
  ) %>%
  as.data.frame()

saveRDS(all.1,file("C://Users/Evan/Desktop/predicted.rds"))



new_table$y<-new_table$total_yield
new_table$ds<-new_table$time
new_table1 <-new_table[, c("ds","y")]
a.3$b <- 100
colnames(a.3)[colnames(a.3) == "ill"] <- "c"
colnames(a.3)[colnames(a.3) == "b"] <- "ill"

a1<-a.3[, c("uid","time" ,"yield", "births","A.D.F..y","THI.y","Fat.y","ill", "c","days")]
predicted<-readRDS( "E:/奶牛泌乳/predicted_yield.rds")

predicted$q<-predicted$predicted_yield-predicted$yield
predicted$p<-predicted$q/predicted$yield

all.1$state <- ifelse(all.1$c < 10 & all.1$c  > -4, "disease", "health")


write_xlsx("1", path = "C://Users/Evan/Desktop/1.xlsx")

n <- nrow(predicted)
predicted <- predicted[order(predicted$time), ]
A1 <- predicted[1:1000000, ]
A2 <- predicted[1000001:2000000, ]
A3 <- predicted[2000001:3000000, ]
A4 <- predicted[3000000:4000000, ]
A5 <- predicted[4000000:5000000, ]
A6 <- predicted[5000000:6000000, ]
A7 <- predicted[6000000:7000000, ]
A8 <- predicted[7000001:n, ]
write_xlsx(A1, path = "C://Users/Evan/Desktop/A1.xlsx")
write_xlsx(A2, path = "C://Users/Evan/Desktop/A2.xlsx")
write_xlsx(A3, path = "C://Users/Evan/Desktop/A3.xlsx")
write_xlsx(A4, path = "C://Users/Evan/Desktop/A4.xlsx")
write_xlsx(A5, path = "C://Users/Evan/Desktop/A5.xlsx")
write_xlsx(A6, path = "C://Users/Evan/Desktop/A6.xlsx")
write_xlsx(A7, path = "C://Users/Evan/Desktop/A7.xlsx")
write_xlsx(A8, path = "C://Users/Evan/Desktop/A8.xlsx")

