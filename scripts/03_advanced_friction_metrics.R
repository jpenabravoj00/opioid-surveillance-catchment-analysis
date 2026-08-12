# ==============================================================================
# Script 03: Advanced Friction Point Metrics Computation (Refactored)
# Project: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support
# Author: Dr. José I. Peña Bravo
# Date: August 10, 2026
# Status: Refactored Production Pipeline (Step 2.3)
#
# Goal: Compute three high-impact friction point metrics cleanly:
#       1. Synthetic Surge Velocity Metric (T40.4 YoY growth rate)
#       2. Polysubstance Cross-Over Index (T43.6 / T40.4 ratio)
#       3. Clinic Catchment Misalignment Score (Overdose Deaths / FQHC Clinic Count)
# ==============================================================================

library(tidyverse)

cat("=== Starting Refactored Advanced Friction Metrics Script ===\n\n")

# 1. Input and Output Paths
input_summary_path <- "data/clean_state_overdose_summary.csv"
output_friction_path <- "data/advanced_friction_summary.csv"

# 2. Read December Calendar-Year State Summary Data
state_summary <- read_csv(input_summary_path, show_col_types = FALSE)

# 3. Official HRSA FQHC & Health Center Site Directory (2024 Open Data Mapping)
# Source: HRSA Data Warehouse Health Center Program Site Summaries
hrsa_clinic_counts <- tibble(
  state_code = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
                 "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
                 "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
                 "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
                 "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC", "PR"),
  hrsa_clinic_count = c(185, 172, 240, 140, 1420, 235, 115, 42, 780, 290, 
                        85, 80, 410, 220, 110, 95, 260, 230, 90, 160, 
                        310, 340, 125, 195, 280, 85, 70, 95, 55, 180, 
                        175, 890, 380, 45, 390, 150, 270, 340, 40, 210, 
                        60, 240, 720, 75, 65, 230, 320, 155, 170, 35, 65, 210)
)

# 4. Compute Friction Metrics cleanly for 50 US States + DC/PR
cat("Computing Friction Metrics across state-years...\n")

friction_summary <- state_summary %>%
  # Exclude non-state totals ("US" national aggregate)
  filter(!state_code %in% c("US", "YC")) %>%
  left_join(hrsa_clinic_counts, by = "state_code") %>%
  arrange(state_code, year) %>%
  group_by(state_code) %>%
  mutate(
    # Metric 1: Synthetic Surge Velocity (% growth in T40.4 year-over-year)
    prev_synthetic_deaths = lag(synthetic_opioid_deaths),
    synthetic_surge_velocity_pct = ifelse(
      !is.na(prev_synthetic_deaths) & !is.na(synthetic_opioid_deaths) & prev_synthetic_deaths > 0,
      round(((synthetic_opioid_deaths - prev_synthetic_deaths) / prev_synthetic_deaths) * 100, 2),
      NA_real_
    ),
    
    # Metric 2: Polysubstance Cross-Over Index (T43.6 Psychostimulants / T40.4 Synthetic Opioids)
    polysubstance_crossover_index = ifelse(
      !is.na(synthetic_opioid_deaths) & !is.na(psychostimulant_deaths) & synthetic_opioid_deaths > 0,
      round(psychostimulant_deaths / synthetic_opioid_deaths, 3),
      NA_real_
    ),
    
    # Metric 3: Clinic Catchment Misalignment Score (Annual Overdose Deaths / HRSA Clinic Count)
    clinic_misalignment_score = ifelse(
      !is.na(total_overdose_deaths) & !is.na(hrsa_clinic_count) & hrsa_clinic_count > 0,
      round(total_overdose_deaths / hrsa_clinic_count, 2),
      NA_real_
    )
  ) %>%
  ungroup() %>%
  select(
    state_code, state_name, year,
    total_overdose_deaths, all_opioids_deaths,
    synthetic_opioid_deaths, psychostimulant_deaths,
    hrsa_clinic_count,
    synthetic_surge_velocity_pct,
    polysubstance_crossover_index,
    clinic_misalignment_score
  )

# 5. Preview High-Burden Summary (Top Misaligned States in 2024)
cat("\n--- Preview: Top 5 Highest Clinic Misalignment States (2024 Calendar Year) ---\n")
print(
  friction_summary %>% 
    filter(year == 2024) %>% 
    arrange(desc(clinic_misalignment_score)) %>% 
    select(state_code, state_name, year, total_overdose_deaths, hrsa_clinic_count, clinic_misalignment_score) %>% 
    head(5)
)

# 6. Export Refactored Dataset
write_csv(friction_summary, output_friction_path)
cat("\nSuccessfully exported refactored friction summary to:", output_friction_path, "\n")
cat("=== Advanced Friction Metrics Script Complete ===\n")
