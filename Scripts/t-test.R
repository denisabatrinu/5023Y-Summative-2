# After some exploratory data analysys, I have came to 
# the conclusion that, the RNAi treatment targeting 
# the raga gene leads to a significant decrease in the 
# number of offspring produced by both the f0 parental 
# generation and the f1 filial generation of nematodes, 
# compared to the empty vector (ev) treatment.

# To test this hypothesis, I will perform a t-test to compare 
# the mean offspring counts between the raga and ev 
# treatments for each generation. Additionally, I will perform 
# a regression model to model the relationship between the RNAi 
# treatment and offspring count, and assess the significance 
# of the effect of the RNAi treatment on offspring count 
# while controlling for other variables such as light exposure.

# NOTE: The following code script only runs if the plot_code.R 
# script is run beforehand, so that the Environment should
# already contain the df, f0_data and d1_data

# Calculate the mean offspring counts for each RNAi treatment in the F0 
f0_means <- f0_data %>%
  group_by(rnai, Light_Exposure) %>%
  summarize(mean_offspring = mean(offspring))

# Calculate the mean offspring counts for each RNAi treatment in the F1 
f1_means <- f1_data %>%
  group_by(rnai, Light_Exposure) %>%
  summarize(mean_offspring = mean(offspring))

# Perform a t-test comparing the mean offspring counts between the two RNAi treatments in the F0
f0_ttest <- t.test(offspring ~ rnai, data = f0_data)

# Perform a t-test comparing the mean offspring counts between the two RNAi treatments in the F1 
f1_ttest <- t.test(offspring ~ rnai, data = f1_data)

# Print the results of the t-tests
cat("F0 t-test p-value:", f0_ttest$p.value, "\n")
cat("F1 t-test p-value:", f1_ttest$p.value, "\n")

