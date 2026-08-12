# ==============================================================================
# Script 02: Data Cleaning & Aggregation (Refactored for Methodological Rigor)
# Project: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support
# Author: Dr. José I. Peña Bravo
# Date: August 10, 2026
# Status: Refactored Production Pipeline (Step 2.2)
#
# Goal: Clean and aggregate raw CDC VSRR drug overdose mortality data.
#       Methodological Refactor: Filter for `Month == "December"` to capture the
#       true January-December 12-month calendar totals, preserving NA suppression
#       flags (counts 1-9) rather than distorting baseline with zero-imputation.
# ==============================================================================

library(tidyverse)

cat("=== Starting Refactored Data Cleaning Script ===\n\n")

# 1. Define input and output paths
raw_data_path <- "data/raw_cdc_overdose_data.csv"
clean_output_path <- "data/clean_state_overdose_summary.csv"

# 2. Read raw CDC dataset
cat("Loading raw CDC overdose dataset...\n")
cdc_raw <- read_csv(raw_data_path, show_col_types = FALSE)

# 3. Target Indicators
target_indicators <- c(
  "Synthetic opioids, excl. methadone (T40.4)",
  "Psychostimulants with abuse potential (T43.6)",
  "Number of Drug Overdose Deaths",
  "Opioids (T40.0-T40.4,T40.6)"
)

cat("Filtering December calendar-year records and preserving suppression status...\n")

# 4. Methodological Filter: Filter for December reporting to get true calendar-year totals
# CDC VSRR data provides 12-month trailing totals for each month.
# Filtering for Month == "December" isolates the Jan-Dec calendar year cleanly.
cdc_clean <- cdc_raw %>%
  filter(
    Indicator %in% target_indicators,
    Month == "December"
  ) %>%
  select(
    state_code = State,
    state_name = `State Name`,
    year = Year,
    indicator = Indicator,
    death_count = `Data Value`
  ) %>%
  # Flag suppressed data (counts under 10 are reported as NA for privacy by CDC)
  mutate(
    is_suppressed = is.na(death_count)
  )

# 5. Pivot data to summary table structure
cat("Pivoting data to summary format...\n")

wide_summary <- cdc_clean %>%
  pivot_wider(
    id_cols = c(state_code, state_name, year),
    names_from = indicator,
    values_from = death_count
  ) %>%
  rename(
    total_overdose_deaths = `Number of Drug Overdose Deaths`,
    synthetic_opioid_deaths = `Synthetic opioids, excl. methadone (T40.4)`,
    psychostimulant_deaths = `Psychostimulants with abuse potential (T43.6)`,
    all_opioids_deaths = `Opioids (T40.0-T40.4,T40.6)`
  )

# 6. Preview Cleaned Output
cat("\n--- Cleaned Summary Preview (December Calendar-Year Totals) ---\n")
print(head(wide_summary, 10))

# 7. Export Cleaned CSV
write_csv(wide_summary, clean_output_path)
cat("\nSuccessfully exported refactored dataset to:", clean_output_path, "\n")
cat("=== Cleaning Script Complete ===\n")
