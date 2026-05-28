# Data Cleaning Steps — Excel

## Source File
`DataCoSupplyChainDataset.csv` — 180,520 rows, 53 columns

## Steps Performed

### 1. Initial Setup
- Opened raw CSV in Excel and saved as `dataco_working.xlsx`
- Froze header row for easier navigation
- Used `Ctrl + End` to confirm full data load (row ~180,520, column 53)

### 2. Null Value Check
- Used `COUNTBLANK()` on each column to identify missing values
- `Customer Zipcode` — nulls present, left as-is (not critical for analysis)
- `Product Description` — excessive nulls, column dropped
- `Order Zipcode` — mostly empty, column dropped

### 3. Duplicate Removal
- Used Data → Remove Duplicates on `Order Id` + `Order Item Id` combo
- Removed duplicate rows and documented count

### 4. Date Formatting
- Reformatted `order date (DateOrders)` to `YYYY-MM-DD` for BigQuery compatibility
- Applied same format to shipping date column

### 5. Calculated Column — Delivery Delay
- Added new column: `Delivery Delay = Days for shipping (real) - Days for shipment (scheduled)`
- Positive = late, Zero = on time, Negative = early

### 6. Text Cleanup
- Applied `TRIM()` to `Category Name`, `Customer Segment`, `Order Region`, `Shipping Mode`
- Removed helper columns after pasting trimmed values back as static values
- Note: `Category Name` was replaced by `Category Name _Helper_` after trimming

### 7. Data Quality Flag
- Added `Data_Quality_Flag` column
- Formula: `=IF(OR([Order Item Quantity]<=0, [Sales]<=0), "Review", "OK")`
- All rows returned "OK" — no negative or zero-value orders found

### 8. Export
- Deleted all helper/audit columns
- Saved final file as `dataco_cleaned.csv` (UTF-8 encoding)

## Known Issues
- Country names in `Order Country` are in Spanish — translated to English via BigQuery CASE statement in `04_region_delay.sql`
- Data completeness drops significantly after October 2017 — treat post-Oct 2017 figures as incomplete
