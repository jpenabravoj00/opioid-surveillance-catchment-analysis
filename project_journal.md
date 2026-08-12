# Portfolio Project Log & Development Journal

**Project Title**: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support  
**Target Sectors**: Healthcare, Health Insurance (Payer), Public Health  
**Core Toolstack**: R (Data Pipeline & Cleaning), Power BI (Interactive Dashboard), GitHub (Open Code/Data)  
**Author**: Dr. José I. Peña Bravo  
**Date Started**: August 10, 2026  

---

## Executive Summary & Goals
- **Objective**: Identify public health overdose trends using official CDC open data and map them against primary care support locations to pinpoint gaps in clinical outreach.
- **Key Goals**:
  1. Build a reproducible data ingestion and cleaning pipeline in R.
  2. Export a clean dataset for Power BI visualization.
  3. Document every phase, timestamp, and duration for future project planning.
  4. Create a transparent, peer-reviewable asset for LinkedIn and GitHub.

---

## Phase 1: Planning & Setup

| Step # | Activity / Task | Date / Time | Duration | Key Outputs / Notes |
|---|---|---|---|---|
| 1.1 | Project Scope & Strategy | Aug 10, 2026 (12:00 PM) | 30 mins | Selected Concept 2; defined focus on real CDC & HRSA datasets. |
| 1.2 | Environment Setup | Aug 10, 2026 (12:46 PM) | 10 mins | Verified R 4.4.2 in Antigravity terminal; set up `scripts/` and `data/` directories. |

---

## Phase 2: Data Ingestion & Pipeline (R Script)

| Step # | Activity / Task | Date / Time | Duration | Key Outputs / Notes |
|---|---|---|---|---|
| 2.1 | Ingestion & Verification | Aug 10, 2026 (12:53 PM) | 15 mins | Ingested real CDC VSRR Drug Overdose Mortality dataset (`data/raw_cdc_overdose_data.csv`, 85,626 rows, 2015–2026). |
| 2.2 | Data Cleaning & Aggregation | Aug 10, 2026 (12:59 PM) | 10 mins | Created `scripts/02_clean_data.R` with project header & status (`Work in Progress`). Exported `data/clean_state_overdose_summary.csv`. |
| 2.3 | Advanced Friction Metrics & ICD-10 Docs | Aug 10, 2026 (2:26 PM) | 20 mins | Authored [`docs/icd10_documentation.md`](file:///Users/JPENA/porfolio_project_001/docs/icd10_documentation.md). Built `scripts/03_advanced_friction_metrics.R` computing Synthetic Surge Velocity, Polysubstance Cross-Over Index, and Clinic Misalignment Score (`data/advanced_friction_summary.csv`). |
| 2.4 | Code Refactoring & Audit Remediation | Aug 10, 2026 (7:18 PM) | 15 mins | Refactored `scripts/02_clean_data.R` to isolate `Month == "December"` for true calendar-year totals, preserved `NA` privacy suppression flags, and removed arbitrary fallback imputations in `scripts/03_advanced_friction_metrics.R`. |

---

## Phase 3: Dashboard & Visualization (Power BI Web)

| Step # | Activity / Task | Date / Time | Duration | Key Outputs / Notes |
|---|---|---|---|---|
| 3.1 | Canvas Blueprint & Wireframe | Aug 10, 2026 (2:37 PM) | 15 mins | Designed F-pattern executive layout in [`docs/powerbi_dashboard_blueprint.md`](file:///Users/JPENA/porfolio_project_001/docs/powerbi_dashboard_blueprint.md). |
| 3.2 | Power BI Report Construction | Aug 10, 2026 (3:20 PM) | 45 mins | Imported `data/advanced_friction_summary.csv` into Power BI Web (`app.powerbi.com`), built KPI cards, Shape Map Heatmap, Priority Bar Chart, and Vertical Year Slicer. |
| 3.3 | UI/UX Refinement & Subagent Audits | Aug 11-12, 2026 | 30 mins | Added Executive Header Banner, Baseline KPI Subtitles, Explicit DAX Weighted Measure (`Clinic Misalignment Index`), Constant Threshold Line (`5.0`), 10-Year Line Trajectory Chart, and Slicer Edit Interactions. |

---

## Phase 4: Social Media Packaging & Documentation

| Step # | Activity / Task | Date / Time | Duration | Key Outputs / Notes |
|---|---|---|---|---|
| 4.1 | Master GitHub README | Aug 12, 2026 (3:54 PM) | 20 mins | Created comprehensive master [`README.md`](file:///Users/JPENA/porfolio_project_001/README.md) documenting domain background, ICD-10 framework, R pipeline, DAX formulas, dashboard screenshot, and execution instructions. |
| 4.2 | LinkedIn Launch Strategy | Aug 12, 2026 (3:55 PM) | Pending | Drafted LinkedIn post copy & PDF carousel framework. |
