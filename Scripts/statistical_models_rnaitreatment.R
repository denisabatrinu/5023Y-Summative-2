#### Testing different models 
# Gene knockdown AND light/dark treatment for F0 GEN
# Visualising the data with a box plot 

ggplot(f0_data, aes(x=rnai, y=offspring, fill=treatment)) +
  geom_boxplot() +
  labs('title' = 'Environmental and genetic treatment on offspring count',
       y = 'Offspring count',
       x = 'RNAi treatment', 
       fill = "Treatment") +
  scale_fill_manual(values = alpha(c("gray", "white"),.3)) 

# Creating a linear model 
f0offspringls1 <- lm(offspring ~ rnai + treatment + rnai + rnai:treatment, data = f0_data)

# Checking for normality in the model
performance::check_model(f0offspringls1)
performance::check_model(f0offspringls1, check="homogeneity") 
performance::check_model(f0offspringls1, check=c("normality","qq"))
performance::check_model(f0offspringls1, check="outliers")
# Data looks normal

# Create summary
summary(f0offspringls1)

# Calculate mean values of treatment and rnai using emmeans function
f0offspringmeans2 <- emmeans::emmeans(f0offspringls1, specs = ~treatment)
f0offspringmeans2
f0offspringmeans21 <- emmeans::emmeans(f0offspringls1, specs = ~rnai)
f0offspringmeans21

# Create a table for the report
f0offspringls1 %>% broom::tidy(conf.int = T) %>% 
  select(-`std.error`) %>% 
  mutate_if(is.numeric, round, 2) %>% 
  kbl(col.names = c("Predictors",
                    "Estimates",
                    "Z-value",
                    "P",
                    "Lower 95% CI",
                    "Upper 95% CI"),
      caption = "f0 generation", 
      booktabs = TRUE) %>% 
  kable_styling(full_width = FALSE, font_size=16, latex_options = c("striped", "hold_position"))

# Gene knockdown AND light/dark treatment for F1 GEN
# Visualising the data with a box plot 

ggplot(f1_data, aes(x=rnai, y=offspring, fill=treatment)) +
  geom_boxplot() +
  labs('title' = 'Environmental and parental genetic treatment on offspring count',
       y = 'Offspring count',
       x = 'RNAi treatment', 
       fill = "Treatment") +
  scale_fill_manual(values = alpha(c("gray", "white"),.3)) 

# Creating a linear model 
f1offspringls1 <- lm(offspring ~ rnai + treatment + rnai + rnai:treatment, data = f1_data)

# Checking for normality in the model
performance::check_model(f1offspringls1)
performance::check_model(f1offspringls1, check="homogeneity") 
performance::check_model(f1offspringls1, check=c("normality","qq"))
performance::check_model(f1offspringls1, check="outliers")
# Data does not look normal

# Transform with boxcox
MASS::boxcox(f1offspringls1)

# Using sqrt to transform data 
f1offspringls1 <- lm(sqrt(offspring) ~ rnai + treatment + rnai + rnai:treatment, data = f1_data)
# Checking for normality in the transformed new model
performance::check_model(f1offspringls1, check=c("homogeneity", "qq"))
# Data looks normal
# Create summary
summary(f1offspringls1)

# Calculate mean values of treatment and rnai using emmeans function
f1offspringmeans2 <- emmeans::emmeans(f1offspringls1, specs = ~treatment)
f1offspringmeans2
f1offspringmeans21 <- emmeans::emmeans(f1offspringls1, specs = ~rnai)
f1offspringmeans21

# Create a table for the report
f1offspringls1 %>% broom::tidy(conf.int = T) %>% 
  select(-`std.error`) %>% 
  mutate_if(is.numeric, round, 2) %>% 
  kbl(col.names = c("Predictors",
                    "Estimates",
                    "Z-value",
                    "P",
                    "Lower 95% CI",
                    "Upper 95% CI"),
      caption = "f1 Generation", 
      booktabs = TRUE) %>% 
  kable_styling(full_width = FALSE, font_size=16, latex_options = c("striped", "hold_position"))



