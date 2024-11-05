test <- readRDS("C://Users/Evan/Desktop/all6.rds")
library(ggplot2)
library(lubridate)
formula <- read.csv("C://Users/Evan/Desktop/formula.csv")
a <- readRDS("C://Users/Evan/Desktop/thi1.rds")
a <- readRDS("C://Users/Evan/Desktop/thi2.rds")
a <- readRDS("C://Users/Evan/Desktop/thi3.rds")
a <- readRDS("C://Users/Evan/Desktop/thi4.rds")

test$births[test$births > 5] <- 5

births.1 <- test[test$births == 1, ]
births.2 <- test[test$births == 2, ]
births.3 <- test[test$births == 3, ]
births.4 <- test[test$births == 4, ]
births.5 <- test[test$births == 5, ]

births.1$number <- unique(births.1$uid)
births.2number <- unique(births.2$uid)
births.3number <- unique(births.3$uid)
births.4number <- unique(births.4$uid)
births.5number <- unique(births.5$uid)
saveRDS(births.3, file("C://Users/Evan/Desktop/births3.rds"))
saveRDS(births.4, file("C://Users/Evan/Desktop/births4.rds"))
saveRDS(births.5, file("C://Users/Evan/Desktop/births5.rds"))

A <- c(1, 2, 3, 4, 5)
B <- c(11996, 8839, 5517, 3810, 2442)

# Create data frame
df <- data.frame(A = A, B = B)

df$A <- factor(df$A)
ggplot(df, aes(x = A, y = B)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Bar Chart", x = "A", y = "B")

# Structure of the herd for birth type 1
b1 <- table(B1$days)
ba1 <- as.data.frame(b1)
ba1$Var1 <- as.numeric(ba1$Var1)
ba1$Freq <- as.numeric(ba1$Freq)

# Structure of the herd for birth type 2
b2 <- table(B2$days)
ba2 <- as.data.frame(b2)
ba2$Var1 <- as.numeric(ba2$Var1)
ba2$Freq <- as.numeric(ba2$Freq)

# Structure of the herd for birth type 3
b3 <- table(B3$days)
ba3 <- as.data.frame(b3)
ba3$Var1 <- as.numeric(ba3$Var1)
ba3$Freq <- as.numeric(ba3$Freq)

# Structure of the herd for birth type 4
b4 <- table(B4$days)
ba4 <- as.data.frame(b4)
ba4$Var1 <- as.numeric(ba4$Var1)
ba4$Freq <- as.numeric(ba4$Freq)

# Structure of the herd for birth type 5
b5 <- table(B5$days)
ba5 <- as.data.frame(b5)
ba5$Var1 <- as.numeric(ba5$Var1)
ba5$Freq <- as.numeric(ba5$Freq)

# Plot for birth type 1
ggplot(ba5, aes(x = Var1, y = Freq)) +
  geom_line(size = 1) +
  geom_ribbon(aes(ymin = 0, ymax = Freq), fill = "yellow", alpha = 1) +
  labs(title = "Line Chart", x = "Value", y = "Frequency") +
  scale_x_continuous(breaks = c(5, 55, 105, 155, 205, 255, 305), limits = c(5, 305)) +
  scale_y_continuous(limits = c(0, 12000))

# Convert dates to days and calculate daily data volume
data <- a.3 %>%
  mutate(date = as.Date(time)) %>%
  group_by(time) %>%
  summarise(daily_count = n())

df_summary <- a.3 %>%
  group_by(time, Month = format(time, "%Y-%m")) %>%
  summarise(daily_count = n()) %>%
  ungroup()

breaks <- c(0, 10, 20, Inf) 
max_per_group <- df_summary %>%
  group_by(Month, Group = cut(day(time), breaks = breaks, labels = c("0-10", "11-20", "greater than 20"))) %>%
  summarise(MaxDailyCount = max(daily_count)) %>%
  ungroup()

write_xlsx(max_per_group2, path = "C://Users/Evan/Desktop/max_per_group.xlsx")
max_per_group2 <- read.csv("C://Users/Evan/Desktop/max_per_group.csv")

x_labels <- seq(1, 180, by = 3)

ggplot(max_per_group2, aes(x = number, y = MaxDailyCount)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) +
  scale_x_continuous(breaks = x_labels, labels = x_labels) +
  scale_fill_brewer(palette = "Set1") +  # Change color palette as needed
  labs(title = "Daily Data Count by Group per Month", x = "Date", y = "Data Count")