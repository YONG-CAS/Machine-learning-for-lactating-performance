# Install and load necessary packages
install.packages("matlab")
library(matlab)
library(mgcv)
library(minpack.lm)
library(ggplot2)                                       
library(writexl)

# Load data
births.number <- read.csv("C://Users/Evan/Desktop/new_excel_sheet.csv")
median_values <- aggregate(yield ~ ill, data = all, FUN = median)

# Filter data based on 'ill' values
ill <- a.3[-16 < a.3$ill & a.3$ill < 16, ]
ill$ill <- factor(ill$ill)

# Create a violin plot with boxplot overlay
ggplot(ill, aes(x = ill, y = yield, fill = ill)) +
  geom_violin() +
  geom_boxplot(width = 0.5) +
  stat_summary(fun = median, geom = "line", aes(group = 1), position = position_dodge(width = 0.75), linetype = "solid", size = 1, color = "black") +
  theme_minimal()

# Prepare datasets for daily counts
data1 <- a.3
ill.structure <- a.3[a.3$ill == 0, ]
data1$births[data1$births > 4] <- 5
ill.structure$births[ill.structure$births > 4] <- 5

# Calculate daily counts for ill and non-ill structures
data <- ill.structure %>%
  group_by(days) %>%
  summarise(daily_count = n(), .groups = 'drop')

data1 <- data1 %>%
  group_by(days) %>%
  summarise(daily_count = n(), .groups = 'drop')

data.1 <- data %>%
  left_join(data1, by = "days")

# Calculate the ratio of daily counts
data.1$a <- data.1$daily_count.x / data.1$daily_count.y
data.1$births <- factor(data.1$births)

# Create a scatter plot
ggplot(data.1) +
  geom_point(aes(x = days, y = a), size = 0.01) +
  scale_x_continuous(breaks = c(5, 55, 105, 155, 205, 255, 305), limits = c(5, 305))

# Calculate daily counts over time for ill structure
ill.time <- ill.structure %>%
  group_by(time) %>%
  summarise(daily_count = n())

# Monthly total quantities for ill structure
df_monthly <- ill.time %>%
  mutate(month = format(time, "%y")) %>%
  group_by(month) %>%
  summarize(total_quantity = sum(daily_count))

# Monthly total quantities for all data
ill.time2 <- a.3 %>%
  group_by(time) %>%
  summarise(daily_count = n())

df_monthly2 <- ill.time2 %>%
  mutate(month = format(time, "%y")) %>%
  group_by(month) %>%
  summarize(total_quantity = sum(daily_count))

# Join monthly data frames
df_monthly3 <- df_monthly %>%
  left_join(df_monthly2, by = 'month')

# Calculate the ratio of total quantities
df_monthly3$a <- df_monthly3$total_quantity.x / df_monthly3$total_quantity.y

# Create a bar chart for monthly totals
ggplot(df_monthly3, aes(x = month, y = a)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Monthly Quantity Bar Chart", x = "Month", y = "Total Quantity") +
  theme_minimal()