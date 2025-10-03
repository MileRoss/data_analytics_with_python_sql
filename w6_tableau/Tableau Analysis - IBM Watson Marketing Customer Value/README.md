# Tableau Analysis: IBM Watson Marketing Customer Value

## Purpose
Client requested a dashboard showing distribution of customers by:  
- Employment Status  
- Gender  
- Marital Status  
- Vehicle Size  
- Customer Lifetime Value (CLV)  
- Income  
- with focus on Total Claim Amount (TCA)  

## Implementation

### Tools
- **Local machine:** MacBook Air M1, 8 GB, macOS Sequoia 15.4.1  
- **Tableau:** Desktop Public Edition 2025.2.0 (Apple Silicon)  
- **Browser:** Google Chrome Version 140.0.7339.208 (arm64)  

### Dataset
- [Primary link](https://raw.githubusercontent.com/data-bootcamp-v4/data/main/we_fn_use_c_marketing_customer_value_analysis.csv)  
- [Alternative Kaggle link](https://www.kaggle.com/datasets/pankajjsh06/ibm-watson-marketing-customer-value-data)  

## Steps

### Data Preparation
1. Inspected the dataset in Chrome to understand content and structure (24 fields, 9,134 rows).  
2. Saved locally as `we_fn_use_c_marketing_customer_value_analysis.csv` (1.6 MB).  
3. Imported into Tableau via `Connect: To a File: Text file`.  

**Alternative:** Save to Google Drive and connect via `Connect: To a Server: Google Drive`. May require troubleshooting if Tableau cannot communicate with Drive.  

### Dashboard 1
**Layout:** 3 horizontal strips + 1 vertical strip on the right  

- **Top strip:** Count of Customers, Avg CLV, Avg Income, Avg TCA  
- **Middle strip:** TCA over CLV, TCA over Income (parameters allow bin size adjustments)  
- **Bottom strip:** TCA by Gender and Income group  
- **Vertical strip:** Distribution by Gender, Marital Status, State, Employment Status, Vehicle Size  

**Features:** Clicking a visual filters others; mid-strip visuals allow parameter changes.  

**Client feedback:**  
- Too busy, geographical map and treemap too small  
- Filters not obvious; Gender filter breaks donuts  

**Client request:**  
- Simplify dashboard  
- Make filters/parameters obvious  
- Use common visuals (pies, bars)  
- Allow swapping of dimensions, metrics, and aggregations  

### Dashboard 2
**Layout:** 2 horizontal strips + 1 vertical strip  

- **Upper strip:** 4 pies showing distribution across 4 dimensions, displaying:  
  1. Segment name  
  2. % of total count  
  3. Selected metric (default/user-selected) in €M  
- **Lower strip:** Bar-line visual by Employment Status, showing avg TCA (bars) and avg CLV (line)  
- **Vertical strip:** Filters and parameters for metric, aggregation, and dimension selection  

**Client feedback:**  
- Poor aesthetics (no background/section separation)  
- Pies overwhelming with 3 lines of info  
- Parameters confusing  

**Client request:**  
- Add background color and section separators  
- Simplify visuals to show only 1 info besides segment name  
- Make parameters easier to use  

### Dashboard 3
**Layout:** Vertically split in halves  

- **Left half:** 3 pies, 2 horizontal bars, and 5 associated filters  
- **Right half:** Dominant bar-line visual with 5 parameters  

**Features:**  
- Simplified filters and parameters  
- Metric/Aggregation selectors (blue box) control left visuals and bar-line visual  
- Bar-line visual adaptation (red box) for user needs  

**Outcome:** Final iteration meets client needs; no further requests  

## How to Run
**Tableau viz:** [Distribution of customers](https://public.tableau.com/app/profile/milenko.rosic/viz/Distributionofcustomers_17562827655500/CLV-story)  

**Best experience:**  
- Open on PC or laptop (Chrome/Safari)  
- Full screen, Actual Size  
- Click "See this in full screen" in Public Tableau UI  

**Note:**  
- Dashboards auto-resize on computers  
- On phone/tablet screens, resizing may be poor  

## Troubleshooting

### Google Drive Connection
**Issue:** "Unable to complete action – insufficient permissions"  
**Solution:** Repeat connection process; you should see your Drive folder content  

### Dynamic Axis Titles
**Issue:** Bar-line visual axis titles update in dashboards but not in Story  
**Solution:** Hide axis titles and add a text object with dynamic elements (as in Dashboard 3)  

**Additional:** Check my other GitHub repositories for more learning material.
