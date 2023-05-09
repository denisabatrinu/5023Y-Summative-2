#___________________________----
# 📦 PACKAGES ----
library(tidyverse) 
library(readxl) 
library(ggpubr) 
library(GGally)
library(performance) 
library(patchwork)
library(rstatix)
library(kableExtra)


#___________________________----
# 📂 IMPORT DATA ----
# Load the sheets via a read_excel path
f0_data <- read_excel(path = "Data/elegans_offspring.xlsx", sheet = 1, col_names = TRUE, col_types = NULL)
f1_data <- read_excel(path = "Data/elegans_offspring.xlsx", sheet = 2, col_names = TRUE, col_types = NULL)


#__________________________----
# 🧹 TIDY ----
# Check columns
str(f0_data)
str(f1_data)

# Fix column names so it fits the same format
f0_data$offspring <- as.numeric(f0_data$offspring)
f1_data$offsprings <- as.numeric(f1_data$offsprings)
colnames(f1_data)[4] <- "offspring"

# NAs introduced by coercion so will remove NA rows
f0_data <- na.omit(f0_data)
f1_data <- na.omit(f1_data)

# Use GGally to check whole plots of the datasets
GGally::ggpairs(f0_data)
GGally::ggpairs(f1_data)

# Isolate the rnai and offspring for f0
f0_data_summary <- f0_data %>%
  group_by(rnai) %>%
  summarise(mean = mean(offspring),
            sd = sd(offspring))

# Isolate the rnai and offspring for f1
f1_data_summary <- f1_data %>%
  group_by(parental_rnai) %>%
  summarise(mean = mean(offspring),
            sd = sd(offspring))

# Add generation column to each data frame
f0_data$generation <- "f0"
f1_data$generation <- "f1"

# Eliminate columns or merge columns to combine dfs later on
colnames(f1_data)[1] <- "rnai"
f1_data <- select(f1_data, -parental_treatment)
f0_data <- select(f0_data, -replicate)

# Combine data frames
df <- rbind(f0_data, f1_data)

# Convert columns to factors with levels
df$treatment <- factor(df$treatment, levels = c("light", "dark"))
df$rnai <- factor(df$rnai, levels = c("raga", "ev"))
df$generation <- factor(df$generation, levels = c("f1", "f0"))


#__________________________----
# 📊PLOTS ----
ggplot(df, aes(x = rnai, y = offspring, fill = treatment)) +
  geom_boxplot(color = "black") +
  facet_wrap(~ generation, ncol = 2) +
  scale_fill_manual(values = c("white", "gray")) +
  labs(x = "RNAi Treatment of f0", y = "Offspring Count") +
  theme_classic()
