# ==============================================================================
# Script 01: Data Ingestion & Initial Inspection
# Project: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support
# Author: Dr. José I. Peña Bravo
# Date: August 10, 2026
#
# Goal: Download official open-access government datasets from CDC and HRSA,
#       and inspect their structure to verify column names and row counts.
# ==============================================================================

# 1. Load required R packages
library(tidyverse)

cat("=== Starting Data Ingestion Script ===\n\n")

# 2. Define Dataset URLs (Official Public Open Data endpoints)

# Dataset A: CDC Provisional Drug Overdose Death Counts (CDC Open Data API / CSV)
cdc_url <- "https://data.cdc.gov/api/views/xkb8-kh2a/rows.csv?accessType=DOWNLOAD"

# Dataset B: HRSA Health Center Program Locations (HRSA Open Data CSV)
hrsa_url <- "https://data.hrsa.gov/DataDownload/DD_Files/Health_Center_Service_Delivery_Site_Locations.csv"

# 3. Define Local File Destination Paths
cdc_file_path  <- "data/raw_cdc_overdose_data.csv"
hrsa_file_path <- "data/raw_hrsa_clinic_locations.csv"

# 4. Download CDC Overdose Data if not already present
if (!file.exists(cdc_file_path)) {
  cat("Downloading CDC Overdose Mortality Dataset...\n")
  download.file(cdc_url, destfile = cdc_file_path, mode = "wb")
  cat("CDC Dataset successfully downloaded to:", cdc_file_path, "\n\n")
} else {
  cat("CDC Dataset already exists locally. Skipping download.\n\n")
}

# 5. Download HRSA Health Center Data if not already present
if (!file.exists(hrsa_file_path)) {
  cat("Downloading HRSA Primary Care Clinic Locations Dataset...\n")
  # Use tryCatch in case HRSA direct link requires standard user agent header
  tryCatch({
    download.file(hrsa_url, destfile = hrsa_file_path, mode = "wb")
    cat("HRSA Dataset successfully downloaded to:", hrsa_file_path, "\n\n")
  }, error = function(e) {
    cat("Direct download notice:", e$message, "\n")
  })
} else {
  cat("HRSA Dataset already exists locally. Skipping download.\n\n")
}

# 6. Read and Inspect CDC Dataset Summary
if (file.exists(cdc_file_path)) {
  cat("--- CDC Dataset Summary ---\n")
  cdc_raw <- read_csv(cdc_file_path, show_col_types = FALSE)
  cat("Total Rows:", nrow(cdc_raw), "\n")
  cat("Total Columns:", ncol(cdc_raw), "\n")
  cat("Column Names:\n")
  print(names(cdc_raw)[1:10]) # Show first 10 columns
  cat("\n")
}

cat("=== Ingestion Script Complete ===\n")
