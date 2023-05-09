# The t-test indicated that there is not a significant difference 
# in offspring count between the ev and raga treatment groups,
# to further explore the relationship between the RNAi treatment 
# and offspring count, I will perform a linear regression analysis
# while controlling for potential confounding factors.

# NOTE: The following code script only runs if the plot_code.R 
# and t-test.R scripts are run beforehand, so that the Environment 
# should already contain the df, f0_data, d1_data, f0_means, f1_means,
# f0_ttest and f1_ttest.

library("see")
library("patchwork")

model1<- lm(offspring ~ rnai + Light_Exposure, data = f1_data)
summary(model1)

model0<- lm(offspring ~ rnai + Light_Exposure, data = f0_data)
summary(model0)



performance::check_model(model1, check ="qq")

performance::check_model(model1, check ="outliers")

performance::check_model(model1, check ="homogeneity")

performance::check_model(model1, check ="vif")



performance::check_model(model0, check ="qq")

performance::check_model(model0, check ="outliers")

performance::check_model(model0, check ="homogeneity")

performance::check_model(model0, check ="vif")


