# DataCo Supply Chain Analytics

Analyzed 180K+ supply chain orders to uncover late delivery patterns and revenue insights using Excel, Google BigQuery, and Tableau.

---

## Tools Used
- **Microsoft Excel** — Data cleaning and transformation
- **Google BigQuery** — SQL analysis
- **Tableau Public** — Interactive dashboard

---

## Dataset
**DataCo Smart Supply Chain for Big Data Analysis**  
Source: [Kaggle](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)  
- 180,000+ order records
- 53 columns covering orders, shipments, customers, and products
- Categories: Fishing, Cleats, Camping & Hiking, Apparel, Electronics, and more

---

## Project Workflow

### 1. Data Cleaning (Excel)
- Removed duplicate records based on `Order Id` and `Order Item Id`
- Standardized date columns to `YYYY-MM-DD` format for BigQuery compatibility
- Dropped irrelevant columns (`Product Description`, `Order Zipcode`)
- Trimmed whitespace from text columns (`Category Name`, `Customer Segment`, `Order Region`)
- Created calculated column: `Delivery Delay = Days for shipping (real) - Days for shipment (scheduled)`
- Added `Data_Quality_Flag` column to identify suspicious records
- Exported cleaned file as `dataco_cleaned.csv`

### 2. SQL Analysis (Google BigQuery)
Five queries were written to answer key business questions:

| File | Question |
|------|----------|
| `01_late_delivery_by_shipping_mode.sql` | Which shipping mode has the highest late delivery rate? |
| `02_category_profit.sql` | Which product categories drive the most revenue and profit? |
| `03_monthly_revenue_trend.sql` | How has revenue trended over time? |
| `04_region_delay.sql` | Which countries and regions have the worst delivery delays? |
| `05_customer_segment.sql` | How do customer segments compare in revenue and delivery performance? |

### 3. Dashboard (Tableau Public)
Five visualizations assembled into one interactive dashboard:
- Late delivery rate by shipping mode (bar chart)
- Monthly revenue trend (line chart)
- Late delivery rate by country (filled map)
- Sales and profit ratio by category (treemap)
- Revenue by customer segment (bar chart)

🔗 **[View Dashboard on Tableau Public](https://public.tableau.com/app/profile/matthew.koch/viz/shared/56B8SXKT9)**

---

## Key Findings

**1. First Class shipping has a 95% late delivery rate**  
Despite being a premium tier, First Class had the worst on-time performance of all shipping modes. Standard Class was the most reliable at 38%.

**2. Fishing is the #1 revenue category at $6.9M — but not the most profitable**  
Women's Clothing had the highest profit ratio (0.151) despite ranking 17th in total sales, suggesting underutilized high-margin categories.

**3. Late deliveries are systemic, not regional**  
All regions averaged 55–60% late delivery rates, indicating an operational issue rather than a location-specific one.

**4. Revenue was stable at ~$1M/month from 2015–2017**  
Consistent order volume with minimal seasonality across the full period, suggesting a mature but underoptimized operation.

**5. All customer segments experience equal late delivery rates**  
Consumer, Corporate, and Home Office segments all had ~55% late rates, meaning no segment is being prioritized over another.

---

## Repository Structure

```
dataco-supply-chain-analytics/
│
├── README.md
├── sql/
│   ├── 01_late_delivery_by_shipping_mode.sql
│   ├── 02_category_profit.sql
│   ├── 03_monthly_revenue_trend.sql
│   ├── 04_region_delay.sql
│   └── 05_customer_segment.sql
└── excel/
    └── data_cleaning_steps.md
```

---

## Data Cleaning Notes
The raw dataset contained several issues addressed during cleaning:
- Columns `Product Description` and `Order Zipcode` were dropped due to excessive nulls
- `Customer Zipcode` nulls were left as-is (not critical for analysis)
- Country names were originally in Spanish — translated to English via BigQuery CASE statements for accurate map rendering in Tableau
- Data completeness drops significantly after October 2017, so trend analysis is limited to 2015–mid 2017
