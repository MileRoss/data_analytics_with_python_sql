# Tableau Analysis: IBM Watson Marketing Customer Value

## Table of Contents
- [Purpose](#purpose)
- [Implementation](#implementation)
- [Dataset](#dataset)
- [Steps](#steps)
- [Dashboards](#dashboards)
- [How to Run](#how-to-run)
- [Troubleshooting](#troubleshooting)

## Purpose
The client requested a dashboard showing the distribution of customers by:
- Employment Status  
- Gender  
- Marital Status  
- Vehicle Size  
- Customer Lifetime Value (CLV)  
- Income  

**Focus:** Total Claim Amount (TCA)

## Implementation

### Tools Used
- **Local machine:** MacBook Air M1, 8 GB RAM, macOS Sequoia 15.4.1
- **Tableau:** Desktop Public Edition 2025.2.0 (Apple Silicon)
- **Browser:** Google Chrome Version 140.0.7339.208 (arm64)

### Dataset
- [Primary link](https://raw.githubusercontent.com/data-bootcamp-v4/data/main/we_fn_use_c_marketing_customer_value_analysis.csv)  
- [Alternative Kaggle link](https://www.kaggle.com/datasets/pankajjsh06/ibm-watson-marketing-customer-value-data)  

## Steps

### Data Preparation
1. Inspect the dataset in Chrome to understand its content and structure (24 columns, 9,134 rows).
2. Save locally as `we_fn_use_c_marketing_customer_value_analysis.csv` (1.6 MB).
3. Import into Tableau via `Connect > To a File > Text file`.

**Alternative:** Save to Google Drive and connect via `Connect > To a Server > Google Drive`.  
*See [Troubleshooting](#troubleshooting) if Tableau cannot communicate with Drive.*
  
<img src="https://raw.githubusercontent.com/MileRoss/data_analytics_with_python_sql/main/w6_tableau/tableau_analysis_-_ibm_watson_marketing_customer_value/images/connect_to_google_drive.jpg" width="500">  

## Dashboards

### Dashboard 1
**Layout:** 3 horizontal strips + 1 vertical strip (right)

- **Top strip:** Count of Customers, Avg CLV, Avg Income, Avg TCA  
- **Middle strip:** TCA vs CLV, TCA vs Income (parameters allow bin size adjustments)
- **Bottom strip:** TCA by Gender and Income group
- **Vertical strip:** Distribution by Gender, Marital Status, State, Employment Status, Vehicle Size

**Features:** Clicking a visual filters others; mid-strip visuals allow parameter changes.  

**Client feedback:**  
- Dashboard feels busy; geographical map and treemap are too small.
- Filters are not obvious; the Gender filter breaks donut charts.
<img src="https://raw.githubusercontent.com/MileRoss/data_analytics_with_python_sql/main/w6_tableau/tableau_analysis_-_ibm_watson_marketing_customer_value/images/donuts.jpg" width="500">  

**Requested changes:**
- Simplify dashboard.
- Make filters and parameters more obvious.
- Use common visuals (pies, bars).
- Allow swapping of dimensions, metrics, and aggregations.

---

### Dashboard 2
**Layout:** 2 horizontal strips + 1 vertical strip  

- **Upper strip:** 4 pie charts showing distribution across 4 dimensions; display:
  1. Segment name
  2. % of total count
  3. Selected metric (default/user-selected) in millions of euros (€M)
- **Lower strip:** Bar-line visual by Employment Status (avg TCA as bars, avg CLV as line)
- **Vertical strip:** Filters and parameters for metric, aggregation, and dimension selection

**Client feedback:**
- Poor aesthetics (no background or section separation).
- Pie charts have too much information (three lines each).
- Parameters are confusing.

**Requested changes:**
- Add background color and section separators.
- Simplify visuals to show only one additional information besides segment name.
- Make parameters easier to use.

---

### Dashboard 3
**Layout:** Vertically split halves

- **Left half:** 3 pie charts, 2 horizontal bars, 5 associated filters
- **Right half:** Dominant bar-line visual with 5 parameters

**Features:**
- Simplified filters and parameters
- Metric/Aggregation selectors (blue box) control left visuals and bar-line visual
- Bar-line visual adaptation (red box) for user needs

**Outcome:** Final iteration meets client needs; no further requests.

---

## How to Run

**Tableau visualization:**  
[Distribution of customers (Tableau Public)](https://public.tableau.com/app/profile/milenko.rosic/viz/Distributionofcustomers_17562827655500/CLV-story)

**Best experience:**  
- Open on PC or laptop (Chrome/Safari recommended)
- Use full screen (“Actual Size”)
- Click “See this in full screen” in Tableau Public UI for best results; otherwise, some visuals or filters may not display.

<img src="https://raw.githubusercontent.com/MileRoss/data_analytics_with_python_sql/main/w6_tableau/tableau_analysis_-_ibm_watson_marketing_customer_value/images/see_this_in_full_screen.jpg" width="500">  

**Not in full screen:**
<img src="https://raw.githubusercontent.com/MileRoss/data_analytics_with_python_sql/main/w6_tableau/tableau_analysis_-_ibm_watson_marketing_customer_value/images/not_full_screen.jpg" width="500">  

**Full screen:**
<img src="https://raw.githubusercontent.com/MileRoss/data_analytics_with_python_sql/main/w6_tableau/tableau_analysis_-_ibm_watson_marketing_customer_value/images/full_screen.jpg" width="500">  


**Note:**  
- Dashboards auto-resize on computers  
- On phone/tablet screens, resizing may be poor  

---

## Troubleshooting

### Google Drive Connection
- **Issue:** "Unable to complete action – insufficient permissions"
- **Solution:** Repeat the connection process; you should see your Drive folder content.

### Dynamic Axis Titles
- **Issue:** Bar-line visual axis titles update in dashboards but not in Story.
- **Solution:** Hide axis titles and add a text object with dynamic elements (see Dashboard 3).

---

## Additional Resources
Check my other [GitHub repositories](https://github.com/MileRoss) for more learning material.