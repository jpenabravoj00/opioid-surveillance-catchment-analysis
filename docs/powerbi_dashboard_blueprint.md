# Power BI Dashboard Blueprint & Visual Layout Specification

**Project**: Mapping High-Risk Overdose Hotspots to Primary Care Clinic Support  
**Target Platform**: Power BI Web Service (`app.powerbi.com`)  
**Data Source**: `data/advanced_friction_summary.csv`  

---

## 1. Executive Canvas Layout (F-Pattern Structure)

```
+-------------------------------------------------------------------------------------------------------+
| EXECUTIVE BANNER: Opioid Surveillance & Primary Care Capacity Analysis                                |
| Subtitle: Tracking U.S. health systems where synthetic fentanyl surges (T40.4) exceed safety capacity|
+-----------------------------------+-----------------------------------+-------------------------------+
| KPI CARD 1                        | KPI CARD 2                        | KPI CARD 3                    |
| Cumulative CDC Recorded           | Deaths / Clinic Site              | Annual YoY Growth             |
| Fatalities (2015-2026)            | (⚠️ High Saturation: > 5.0)       | in Fentanyl Deaths (T40.4)    |
| Value: 996K                       | Value: 6.73                       | Value: 11.36%                 |
+-----------------------------------+-----------------------------------+-------------------------------+
| MAP HEATMAP (Middle-Left)         | PRIORITY BAR CHART (Middle-Right)                                 |
| U.S. Primary Care Misalignment    | Top Priority States by Clinic Saturation                          |
| Shape Map (Warm Risk Gradient)    | (Weighted DAX Measure + Constant Line at 5.0)                     |
+-----------------------------------+-------------------------------------------------------------------+
| TIME-SERIES LINE CHART (Bottom Band)                                  | RIGHT SIDEBAR                 |
| 10-Year Surge Trajectory: Synthetic Opioids vs. Psychostimulants      | Vertical Year Slicer          |
| (2015 - 2026 Trajectory, Edit Interactions set to NONE)               | (2015 - 2026)                 |
+-----------------------------------------------------------------------+-------------------------------+
```

---

## 2. Calculated DAX Measures

### Primary Misalignment Measure
```dax
Clinic Misalignment Index = 
DIVIDE(
    SUM('advanced_friction_summary'[total_overdose_deaths]),
    SUM('advanced_friction_summary'[hrsa_clinic_count]),
    BLANK()
)
```

---

## 3. Visual Configuration Details

1. **Top Header**: Text box formatted in bold dark slate font (`#0F172A`).
2. **KPI Cards**: White tiles, 8px rounded borders, subtle bottom-right shadow.
3. **Shape Map**: US state map with conditional fill gradient (Warm Amber to Crimson).
4. **Clustered Bar Chart**: Ranked by `Clinic Misalignment Index`, with a dashed constant reference line at `5.0`.
5. **Line Chart**: 10-year trajectory comparing Synthetic Opioids (`T40.4`) and Psychostimulants (`T43.6`). Edit Interactions set to `None` from the Year Slicer to preserve time-series context.
