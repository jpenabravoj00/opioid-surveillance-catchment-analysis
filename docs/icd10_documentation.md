# ICD-10 Surveillance & Friction Point Metrics Reference

**Project**: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support  
**Author**: José I. Peña Bravo, PhD  
**Date**: August 10, 2026  

---

## 1. ICD-10 Code Definitions & Clinical Context

In public health epidemiology and emergency surveillance, mortality and morbidity statistics rely on International Classification of Diseases, 10th Revision (ICD-10) codes to categorize drug involvement:

| Code / Category | Official ICD-10 Description | Clinical & Epidemiological Significance |
|---|---|---|
| **T40.4** | Poisoning by, adverse effect of and underdosing of **Synthetic opioids, excluding methadone** | Primary surveillance marker for illicitly manufactured **fentanyl** and fentanyl analogs. Represents the main driver of acute overdose surges. |
| **T43.6** | Poisoning by, adverse effect of and underdosing of **Psychostimulants with abuse potential** | Includes **methamphetamine**, amphetamines, and prescription stimulants. Key indicator for tracking polysubstance stimulant/opioid co-use. |
| **T40.0–T40.4, T40.6** | Poisoning by, adverse effect of and underdosing of **All Opioids** | Comprehensive opioid umbrella covering opium (T40.0), heroin (T40.1), natural/semi-synthetic opioids like oxycodone (T40.2), methadone (T40.3), synthetic opioids (T40.4), and other narcotics (T40.6). |
| **Overall Overdose Deaths** | Underlying Cause of Death Codes: **X40–X44** (unintentional), **X60–X64** (suicide), **X85** (homicide), **Y10–Y14** (undetermined intent) | Standard CDC aggregate measure for all acute drug poisonings regardless of specific substance. |

---

## 2. Core Friction Point Metrics Built in R Pipeline

### Metric 1: The "Synthetic Surge" Velocity Metric (`T40.4` vs. General Opioids)
- **Formula**: `(Synthetic_Opioid_Deaths_Year_N - Synthetic_Opioid_Deaths_Year_N-1) / Synthetic_Opioid_Deaths_Year_N-1 * 100` compared to overall opioid growth rate.
- **Friction Point Solved**: Identifies states/regions where fentanyl proliferation is accelerating faster than traditional opioid protocols, signaling urgent need for rapid-response naloxone distribution and emergency protocol updates.

### Metric 2: The "Polysubstance Cross-Over" Index (`T40.4` + `T43.6`)
- **Formula**: `Psychostimulant_Deaths (T43.6) / Synthetic_Opioid_Deaths (T40.4)` ratio and concurrent growth rate.
- **Friction Point Solved**: Exposes the "fentanyl mixed into stimulants" reality. Traditional primary care and harm reduction clinics are often structured around single-substance protocols; high cross-over indices highlight where multi-substance treatment capabilities are critically lacking.

### Metric 3: Clinic Catchment Misalignment Score
- **Formula**: `Annual_Overdose_Deaths / Total_HRSA_Primary_Care_Clinics` per state code.
- **Friction Point Solved**: Explicitly measures the burden on existing primary care safety net infrastructure. Highlights states where death counts are skyrocketing while primary care clinic capacity is mathematically overwhelmed or absent.
