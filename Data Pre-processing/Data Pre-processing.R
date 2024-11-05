library(dplyr)
library(readr)
library(openxlsx)
library(writexl)
library(psych)
library(reshape2)

# Read data
THI <- read.csv("C://Users/Evan/Desktop/123.csv")
birthday <- read.csv("C://Users/Evan/Desktop/birth_time.csv")
THI$time <- as.Date(THI$time)
formula2 <- read.csv("C://Users/Evan/Desktop/formula1.csv")
ill <- read.csv("C://Users/Evan/Desktop/ill.csv")
formula$begin <- as.Date(formula$begin)
formula$end <- as.Date(formula$end)
birthday <- read.csv("C://Users/Evan/Desktop/copy_5_years_data.csv")

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
  time_point <- all.4$time[i]
  time_point <- as.Date(time_point)
  
  # Find matching rows in formula.4
  matching_row <- formula.