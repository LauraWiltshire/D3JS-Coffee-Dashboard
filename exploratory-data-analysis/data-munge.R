# Download Packages
library(tidyverse) #  for general data analytics
library(VIM) #  for kNN clustering
library(e1071) #  for skewness and kurtosis

# Import data
coffee_data <- read_csv('coffee-data-raw.csv')
glimpse(coffee_data)

# Check for missing values
colSums(is.na(coffee_data)) #  roast has 12 NA values

# Impute using KNN and keep track of which values were imputed
coffee_data_imputed <- VIM::kNN(coffee_data, variable = "roast", k = 5, imp_var = TRUE)

# Filter rows where roast was imputed
imputed_rows <- coffee_data_imputed[coffee_data_imputed$roast_imp == TRUE, ]
imputed_frequencies <- table(imputed_rows$roast)
print(imputed_frequencies)

# Plot coffee ratings

# Create a minimalist histogram
ggplot(coffee_data_imputed, aes(x = rating)) +
  geom_histogram(binwidth = 2, fill = "brown", color = "black") +
  theme_minimal() +
  labs(
    x = "Rating Score",
    y = "Frequency"
  ) +
  theme(
    panel.grid = element_blank(),  # Remove gridlines for a clean look
    axis.title = element_text(size = 12), 
    axis.text = element_text(size = 10)
  )

# Calculate summary statistics
rating_summary <- data.frame(
  Statistic = c("Minimum", "Maximum", "Mean", "Median", "Mode", "Range", "Variance", "Standard Deviation", "IQR", "Skewness", "Kurtosis"),
  Value = c(
    min(coffee_data$rating, na.rm = TRUE),
    max(coffee_data$rating, na.rm = TRUE),
    mean(coffee_data$rating, na.rm = TRUE),
    median(coffee_data$rating, na.rm = TRUE),
    mode(coffee_data$rating), 
    paste(range(coffee_data$rating, na.rm = TRUE), collapse = "-"),
    var(coffee_data$rating, na.rm = TRUE),
    sd(coffee_data$rating, na.rm = TRUE),
    IQR(coffee_data$rating, na.rm = TRUE),
    skewness(coffee_data$rating, na.rm = TRUE),
    kurtosis(coffee_data$rating, na.rm = TRUE)
  )
)

# Display the table
print(rating_summary)

