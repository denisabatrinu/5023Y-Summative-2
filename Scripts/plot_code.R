#___________________________----
# SET UP ---
# Studying the effect of the gene raga-1 and how it interacts with stress on longevity and reproduction in the nematode worm (C. elegans) through gene knockout

#__________________________----
# 📦 PACKAGES ----
library(ggplot2) # creates data visualisation
library(readxl) # reads xlsx or xls files
library(ggpubr)
library(dplyr)
library(performance) # provides a collection of tools for evaluating and visualizing the performance of predictive models

#__________________________----
# 📂 IMPORT DATA ----
f0_data <- read_excel("Data/elegans_offspring.xlsx", sheet = 1
                      , col_names = TRUE, col_types = NULL, na = "", skip = 0)
f1_data <- read_excel("Data/elegans_offspring.xlsx", sheet = 2
                      , col_names = TRUE, col_types = NULL, na = "", skip = 0)


#__________________________----
# 🧹 TIDY ----
# Convert the "offspring" column to numeric
f0_data$offspring <- as.numeric(f0_data$offspring)
f1_data$offsprings <- as.numeric(f1_data$offsprings)

# Remove columns that will not be used
f0_data <- select(f0_data, -replicate)
f1_data <- select(f1_data, -parental_treatment)

# Fix column names
colnames(f1_data)[3] <- "offspring"
colnames(f1_data)[1] <- "rnai"
colnames(f1_data)[2] <- "Light_Exposure"
colnames(f0_data)[2] <- "Light_Exposure"

# Remove NA rows
f0_data <- na.omit(f0_data)
f1_data <- na.omit(f1_data)

# Add generation column to each data frame
f0_data$generation <- "f0"
f1_data$generation <- "f1"

# Combine data frames
df <- rbind(f0_data, f1_data)

# Convert columns to factors with levels
df$Light_Exposure <- factor(df$Light_Exposure, levels = c("light", "dark"))
df$rnai <- factor(df$rnai, levels = c("raga", "ev"))
df$generation <- factor(df$generation, levels = c("f1", "f0"))

#__________________________----
# 📊PLOTS ----
ggplot(df, aes(x = rnai, y = offspring, fill = Light_Exposure)) +
  geom_boxplot(color = "black") +
  facet_wrap(~ generation, ncol = 2) +
  scale_fill_manual(values = c("white", "gray")) +
  labs(x = "RNAi Treatment of f0", y = "Offspring Count") +
  theme_classic()

