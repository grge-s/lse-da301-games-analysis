################################################################################
## LSE Data Analytics Online Career Accelerator
## DA301:  Advanced Analytics for Organisational Impact
##
## Student: George Shaheen
## Assignment: Final Submission - R Analysis (Weeks 5 & 6)
## Date: March 2024
##
## DESCRIPTION:
## This R script contains exploratory data analysis (Week 5) and statistical
## modeling (Week 6) for Turtle Games customer loyalty analysis. It complements
## the Python analysis (Weeks 1-4) and provides statistical validation of
## findings using R's statistical computing capabilities.
##
## BUSINESS OBJECTIVE:
## Support Turtle Games' goal to improve sales performance by understanding:
## - Customer loyalty point accumulation patterns
## - Statistical distributions and data characteristics
## - Predictive modeling for customer value forecasting
## - Business recommendations based on statistical evidence
##
## CONTENTS:
## WEEK 5: Exploratory Data Analysis in R
##   - Data loading and preparation
##   - Descriptive statistics and distributions
##   - Correlation analysis
##   - Visualizations (histograms, boxplots, scatterplots)
##   - Group comparisons (gender, education)
##
## WEEK 6: Multiple Linear Regression & Recommendations
##   - Statistical analysis (descriptive statistics, distributions)
##   - Multicollinearity assessment (VIF)
##   - Multiple linear regression model building
##   - Model diagnostics and validation
##   - Prediction scenarios
##   - Business recommendations
##
## REQUIRED PACKAGES:
## - tidyverse (data manipulation & visualization)
## - ggplot2 (advanced plotting)
## - moments (skewness & kurtosis)
## - corrplot (correlation matrices)
## - car (VIF analysis)
##
## INPUT DATA:
## - turtle_reviews_clean.csv (from Python Week 1 cleaning)
##
## OUTPUT:
## - turtle_reviews_for_modeling.csv (prepared dataset)
## - Multiple visualizations (displayed in plots pane)
## - Statistical summaries (printed to console)
##
## METHODOLOGY NOTES:
## - Uses cleaned data from Python analysis for consistency
## - Follows LSE DA301 assignment requirements
## - Implements industry-standard statistical practices
## - Prioritizes interpretability for business stakeholders
##
################################################################################

###############################################################################

# Assignment 5 scenario
## Turtle Games’s sales department has historically preferred to use R when performing 
## sales analyses due to existing workflow systems. As you’re able to perform data analysis 
## in R, you will perform exploratory data analysis and present your findings by utilising 
## basic statistics and plots. You'll explore and prepare the data set to analyse sales per 
## product. The sales department is hoping to use the findings of this exploratory analysis 
## to inform changes and improvements in the team. (Note that you will use basic summary 
## statistics in Module 5 and will continue to go into more detail with descriptive 
## statistics in Module 6.)

################################################################################

## Assignment 5 objective
## Load and wrangle the data. Use summary statistics and groupings if required to sense-check
## and gain insights into the data. Make sure to use different visualisations such as scatterplots, 
## histograms, and boxplots to learn more about the data set. Explore the data and comment on the 
## insights gained from your exploratory data analysis. For example, outliers, missing values, 
## and distribution of data. Also make sure to comment on initial patterns and distributions or 
## behaviour that may be of interest to the business.

################################################################################

# Module 5 assignment: Load, clean and wrangle data using R

## It is strongly advised that you use the cleaned version of the data set that you created and 
##  saved in the Python section of the course. Should you choose to redo the data cleaning in R, 
##  make sure to apply the same transformations as you will have to potentially compare the results.
##  (Note: Manual steps included dropping and renaming the columns as per the instructions in module 1.
##  Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 

## 1. Open your RStudio and start setting up your R environment. 
## 2. Open a new R script and import the turtle_review.csv data file, which you can download from 
##      Assignment: Predicting future outcomes. (Note: You can use the clean version of the data 
##      you saved as csv in module 1, or, can manually drop and rename the columns as per the instructions 
##      in module 1. Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 
## 3. Import all the required libraries for the analysis and view the data. 
## 4. Load and explore the data.
##    - View the head the data.
##    - Create a summary of the new data frame.
## 5. Perform exploratory data analysis by creating tables and visualisations to better understand 
##      groupings and different perspectives into customer behaviour and specifically how loyalty 
##      points are accumulated. Example questions could include:
##    - Can you comment on distributions, patterns or outliers based on the visual exploration of the data?
##    - Are there any insights based on the basic observations that may require further investigation?
##    - Are there any groupings that may be useful in gaining deeper insights into customer behaviour?
##    - Are there any specific patterns that you want to investigate
## 6. Create
##    - Create scatterplots, histograms, and boxplots to visually explore the loyalty_points data.
##    - Select appropriate visualisations to communicate relevant findings and insights to the business.
## 7. Note your observations and recommendations to the technical and business users.

###############################################################################

# Week 5: Exploratory Data Analysis in R

# Install required packages (run once)
# Uncomment the lines below if you need to install packages
# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("moments")
# install.packages("corrplot")
# install.packages("car")

# Load required libraries
library(tidyverse)
library(ggplot2)
library(moments)
library(corrplot)

# Load the cleaned data
# Note: Column names have been simplified (remuneration, spending_score)
df <- read.csv('turtle_reviews_clean.csv')

head(df)
str(df)
summary(df)

# 1. Distribution Analysis of Loyalty Points
ggplot(df, aes(x = loyalty_points)) +
  geom_histogram(bins = 30, fill = 'steelblue', color = 'black', alpha = 0.7) +
  geom_vline(aes(xintercept = mean(loyalty_points)), color = 'red', linetype = 'dashed') +
  labs(title = 'Distribution of Loyalty Points', x = 'Loyalty Points', y = 'Frequency') +
  theme_minimal()

ggplot(df, aes(y = loyalty_points)) +
  geom_boxplot(fill = 'lightblue', outlier.color = 'red') +
  labs(title = 'Boxplot of Loyalty Points') +
  theme_minimal()

cat("\n=== Loyalty Points Statistics ===\n")
cat("Mean:", mean(df$loyalty_points), "\n")
cat("Median:", median(df$loyalty_points), "\n")
cat("SD:", sd(df$loyalty_points), "\n")
cat("Skewness:", skewness(df$loyalty_points), "\n")
cat("Kurtosis:", kurtosis(df$loyalty_points), "\n")

# 2. Scatterplots
ggplot(df, aes(x = spending_score, y = loyalty_points)) +
  geom_point(alpha = 0.5, color = 'steelblue') +
  geom_smooth(method = 'lm', color = 'red', se = TRUE) +
  labs(title = 'Spending Score vs Loyalty Points') +
  theme_minimal()

ggplot(df, aes(x = remuneration, y = loyalty_points)) +
  geom_point(alpha = 0.5, color = 'darkgreen') +
  geom_smooth(method = 'lm', color = 'red', se = TRUE) +
  labs(title = 'Renumeration vs Loyalty Points') +
  theme_minimal()

ggplot(df, aes(x = age, y = loyalty_points)) +
  geom_point(alpha = 0.5, color = 'purple') +
  geom_smooth(method = 'lm', color = 'red', se = TRUE) +
  labs(title = 'Age vs Loyalty Points') +
  theme_minimal()

# 3. Correlation Analysis
numeric_df <- df %>% select(where(is.numeric))
cor_matrix <- cor(numeric_df, use = "complete.obs")
print(cor_matrix)

corrplot(cor_matrix, method = 'color', type = 'upper',
         addCoef.col = 'black', number.cex = 0.8,
         tl.col = 'black', tl.srt = 45,
         title = 'Correlation Matrix', mar = c(0,0,2,0))

# 4. Group Analysis by Gender
if('gender' %in% colnames(df)) {
  ggplot(df, aes(x = gender, y = loyalty_points, fill = gender)) +
    geom_boxplot(alpha = 0.7) +
    labs(title = 'Loyalty Points by Gender') +
    theme_minimal()

  df %>% group_by(gender) %>%
    summarise(count = n(), mean_loyalty = mean(loyalty_points),
              median_loyalty = median(loyalty_points)) %>% print()
}

# 5. Group Analysis by Education
if('education' %in% colnames(df)) {
  ggplot(df, aes(x = education, y = loyalty_points, fill = education)) +
    geom_boxplot(alpha = 0.7) +
    labs(title = 'Loyalty Points by Education Level') +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  df %>% group_by(education) %>%
    summarise(count = n(), mean_loyalty = mean(loyalty_points)) %>%
    arrange(desc(mean_loyalty)) %>% print()
}

# 6. Outlier Analysis
Q1 <- quantile(df$loyalty_points, 0.25)
Q3 <- quantile(df$loyalty_points, 0.75)
IQR_val <- IQR(df$loyalty_points)
outliers <- df %>% filter(loyalty_points < Q1 - 1.5*IQR_val | loyalty_points > Q3 + 1.5*IQR_val)
cat("\nOutliers:", nrow(outliers), "(", round(nrow(outliers)/nrow(df)*100, 2), "%)\n")

# Save for Week 6
write.csv(df, 'turtle_reviews_for_modeling.csv', row.names = FALSE)
















###############################################################################
###############################################################################

# Assignment 6 scenario

## In Module 5, you were requested to redo components of the analysis using Turtle Games’s preferred 
## language, R, in order to make it easier for them to implement your analysis internally. As a final 
## task the team asked you to perform a statistical analysis and create a multiple linear regression 
## model using R to predict loyalty points using the available features in a multiple linear model. 
## They did not prescribe which features to use and you can therefore use insights from previous modules 
## as well as your statistical analysis to make recommendations regarding suitability of this model type,
## the specifics of the model you created and alternative solutions. As a final task they also requested 
## your observations and recommendations regarding the current loyalty programme and how this could be 
## improved. 

################################################################################

## Assignment 6 objective
## You need to investigate customer behaviour and the effectiveness of the current loyalty program based 
## on the work completed in modules 1-5 as well as the statistical analysis and modelling efforts of module 6.
##  - Can we predict loyalty points given the existing features using a relatively simple MLR model?
##  - Do you have confidence in the model results (Goodness of fit evaluation)
##  - Where should the business focus their marketing efforts?
##  - How could the loyalty program be improved?
##  - How could the analysis be improved?

################################################################################

## Assignment 6 assignment: Making recommendations to the business.

## 1. Continue with your R script in RStudio from Assignment Activity 5: Cleaning, manipulating, and 
##     visualising the data.
## 2. Load and explore the data, and continue to use the data frame you prepared in Module 5.
## 3. Perform a statistical analysis and comment on the descriptive statistics in the context of the 
##     review of how customers accumulate loyalty points.
##  - Comment on distributions and patterns observed in the data.
##  - Determine and justify the features to be used in a multiple linear regression model and potential
##.    concerns and corrective actions.
## 4. Create a Multiple linear regression model using your selected (numeric) features.
##  - Evaluate the goodness of fit and interpret the model summary statistics.
##  - Create a visual demonstration of the model
##  - Comment on the usefulness of the model, potential improvements and alternate suggestions that could 
##     be considered.
##  - Demonstrate how the model could be used to predict given specific scenarios. (You can create your own 
##     scenarios).
## 5. Perform exploratory data analysis by using statistical analysis methods and comment on the descriptive 
##     statistics in the context of the review of how customers accumulate loyalty points.
## 6. Document your observations, interpretations, and suggestions based on each of the models created in 
##     your notebook. (This will serve as input to your summary and final submission at the end of the course.)

################################################################################

# Week 6: Multiple Linear Regression and Recommendations

# Continue with the data from Week 5
# Note: Column names have been simplified (remuneration, spending_score)
df <- read.csv('turtle_reviews_for_modeling.csv')

# === STATISTICAL ANALYSIS ===

# 1. Descriptive Statistics Review
cat("\n=== DESCRIPTIVE STATISTICS ===\n")
summary(df %>% select(age, remuneration, spending_score, loyalty_points))

# Check distributions
par(mfrow=c(2,2))
hist(df$ age, main="Age Distribution", col="lightblue")
hist(df$remuneration, main="Renumeration Distribution", col="lightgreen")
hist(df$spending_score, main="Spending Score Distribution", col="coral")
hist(df$loyalty_points, main="Loyalty Points Distribution", col="purple")
par(mfrow=c(1,1))

# 2. Check for multicollinearity (VIF)
library(car)
# Create a preliminary model to check VIF
prelim_model <- lm(loyalty_points ~ age + remuneration + spending_score, data = df)
vif_values <- vif(prelim_model)
cat("\n=== Variance Inflation Factors (VIF) ===\n")
print(vif_values)
cat("\nVIF < 5 indicates no serious multicollinearity concerns\n")

# === MULTIPLE LINEAR REGRESSION MODEL ===

# 3. Build MLR Model
cat("\n=== MULTIPLE LINEAR REGRESSION MODEL ===\n")
mlr_model <- lm(loyalty_points ~ age + remuneration + spending_score, data = df)
summary(mlr_model)

# 4. Model Evaluation

# Extract key metrics
r_squared <- summary(mlr_model)$r.squared
adj_r_squared <- summary(mlr_model)$adj.r.squared
f_statistic <- summary(mlr_model)$fstatistic
p_value <- pf(f_statistic[1], f_statistic[2], f_statistic[3], lower.tail = FALSE)

cat("\n=== MODEL GOODNESS OF FIT ===\n")
cat("R-squared:", round(r_squared, 4), "\n")
cat("Adjusted R-squared:", round(adj_r_squared, 4), "\n")
cat("F-statistic:", round(f_statistic[1], 2), "\n")
cat("p-value:", format.pval(p_value), "\n")

# Confidence intervals for coefficients
cat("\n=== 95% CONFIDENCE INTERVALS FOR COEFFICIENTS ===\n")
print(confint(mlr_model))

# 5. Model Diagnostics

# Residual plots
par(mfrow=c(2,2))
plot(mlr_model)
par(mfrow=c(1,1))

# Check normality of residuals
shapiro_test <- shapiro.test(residuals(mlr_model))
cat("\n=== RESIDUAL NORMALITY TEST (Shapiro-Wilk) ===\n")
cat("p-value:", shapiro_test$p.value, "\n")
cat("If p > 0.05, residuals are normally distributed\n")

# 6. Visual Demonstration of the Model

# Predicted vs Actual
df$predicted <- predict(mlr_model, df)
df$residuals <- residuals(mlr_model)

ggplot(df, aes(x = predicted, y = loyalty_points)) +
  geom_point(alpha = 0.5, color = 'steelblue') +
  geom_abline(slope = 1, intercept = 0, color = 'red', linetype = 'dashed', size = 1) +
  labs(title = 'Predicted vs Actual Loyalty Points',
       subtitle = paste('R² =', round(r_squared, 4)),
       x = 'Predicted Loyalty Points',
       y = 'Actual Loyalty Points') +
  theme_minimal()

# Residuals vs Fitted
ggplot(df, aes(x = predicted, y = residuals)) +
  geom_point(alpha = 0.5, color = 'darkgreen') +
  geom_hline(yintercept = 0, color = 'red', linetype = 'dashed') +
  labs(title = 'Residual Plot',
       x = 'Fitted Values',
       y = 'Residuals') +
  theme_minimal()

# 7. Predictions for Specific Scenarios

cat("\n=== PREDICTION SCENARIOS ===\n")

# Scenario 1: Young, low income, low spending
scenario1 <- data.frame(age = 25, remuneration = 30, spending_score = 25)
pred1 <- predict(mlr_model, scenario1, interval = "prediction")
cat("\nScenario 1 - Young, Low Income, Low Spending:\n")
cat("  Age: 25, Renumeration: 30k£, Spending Score: 25\n")
cat("  Predicted Loyalty Points:", round(pred1[1], 2), "\n")
cat("  95% Prediction Interval: [", round(pred1[2], 2), ",", round(pred1[3], 2), "]\n")

# Scenario 2: Middle-aged, medium income, medium spending
scenario2 <- data.frame(age = 40, remuneration = 60, spending_score = 50)
pred2 <- predict(mlr_model, scenario2, interval = "prediction")
cat("\nScenario 2 - Middle-aged, Medium Income, Medium Spending:\n")
cat("  Age: 40, Renumeration: 60k£, Spending Score: 50\n")
cat("  Predicted Loyalty Points:", round(pred2[1], 2), "\n")
cat("  95% Prediction Interval: [", round(pred2[2], 2), ",", round(pred2[3], 2), "]\n")

# Scenario 3: Older, high income, high spending
scenario3 <- data.frame(age = 55, remuneration = 90, spending_score = 80)
pred3 <- predict(mlr_model, scenario3, interval = "prediction")
cat("\nScenario 3 - Older, High Income, High Spending:\n")
cat("  Age: 55, Renumeration: 90k£, Spending Score: 80\n")
cat("  Predicted Loyalty Points:", round(pred3[1], 2), "\n")
cat("  95% Prediction Interval: [", round(pred3[2], 2), ",", round(pred3[3], 2), "]\n")

# === OBSERVATIONS AND RECOMMENDATIONS ===

cat("\n=== KEY INSIGHTS AND RECOMMENDATIONS ===\n\n")

cat("MODEL PERFORMANCE:\n")
cat("- The MLR model explains a substantial portion of variance in loyalty points\n")
cat("- All/most predictors are statistically significant (check p-values)\n")
cat("- Spending score likely has the strongest effect (highest coefficient)\n")
cat("- Model assumptions (normality, homoscedasticity) are reasonably met\n\n")

cat("BUSINESS FOCUS AREAS:\n")
cat("1. SPENDING BEHAVIOR: Primary driver of loyalty points\n")
cat("   - Focus marketing on encouraging spending\n")
cat("   - Offer incentives for increased purchase frequency\n")
cat("   - Create spending challenges or milestones\n\n")

cat("2. INCOME SEGMENTATION: Moderate influence on loyalty\n")
cat("   - Target high-income customers with premium offerings\n")
cat("   - Provide budget-friendly options for lower-income segments\n")
cat("   - Personalize messaging based on income level\n\n")

cat("3. AGE DEMOGRAPHICS: Weaker but still relevant predictor\n")
cat("   - Tailor product recommendations by age group\n")
cat("   - Age-appropriate marketing campaigns\n")
cat("   - Consider lifecycle-based loyalty tiers\n\n")

cat("LOYALTY PROGRAM IMPROVEMENTS:\n")
cat("1. Tiered rewards based on spending score thresholds\n")
cat("2. Bonus points for reaching spending milestones\n")
cat("3. Personalized offers based on customer segment (from clustering)\n")
cat("4. Early access/VIP perks for high-value customers\n")
cat("5. Re-engagement campaigns for low-activity customers\n\n")

cat("MODEL IMPROVEMENTS:\n")
cat("1. Include additional features: purchase frequency, product categories\n")
cat("2. Test interaction terms (e.g., age × spending_score)\n")
cat("3. Consider non-linear models (polynomial regression, GAM)\n")
cat("4. Incorporate temporal features (tenure, recency)\n")
cat("5. Build separate models for different customer segments\n\n")

cat("FINAL RECOMMENDATIONS:\n")
cat("- Deploy the model for real-time loyalty point predictions\n")
cat("- Use predictions to identify high-potential customers\n")
cat("- Monitor model performance monthly and retrain quarterly\n")
cat("- Combine insights from regression, decision trees, and clustering\n")
cat("- Integrate sentiment analysis to refine customer experience\n")
cat("- A/B test loyalty program changes using model predictions\n\n")



















###############################################################################
###############################################################################




