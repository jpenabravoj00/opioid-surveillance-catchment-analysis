# ==============================================================================
# Script 02: Inspect CDC Overdose Dataset
# Author: Dr. José I. Peña Bravo
# ==============================================================================

library(tidyverse)

cdc_data <- read_csv("data/raw_cdc_overdose_data.csv", show_col_types = FALSE)

cat("=== CDC Overdose Dataset Columns ===\n")
print(colnames(cdc_data))

cat("\n=== Unique Indicators in CDC Data ===\n")
cdc_indicators <- cdc_data %>% 
  distinct(Indicator) %>% 
  pull(Indicator)

print(cdc_indicators)

cat("\n=== Years Covered in CDC Data ===\n")
print(unique(cdc_data$Year))

cat("\n=== First Few Rows ===\n")
print(head(cdc_data %>% select(State, Year, Month, Indicator, `Data Value`), 10))
