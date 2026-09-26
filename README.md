# Retail Customer Segmentation — RFM Analysis

A SQL + Power BI project segmenting customers by purchase behavior.

## Objective
Segment 150 customers based on purchasing behavior (Recency, Frequency, Monetary) to help a business prioritize retention efforts and marketing spend.

## Tools Used
- **MySQL** — data cleaning, RFM calculation, View creation
- **Power BI** — interactive dashboard, DAX measures, custom design

## Approach
1. Cleaned raw transaction data in SQL, removing nulls and invalid records
2. Calculated Recency, Frequency, and Monetary metrics per customer using GROUP BY, aggregate functions, and a subquery to reference the dataset's most recent order date
3. Scored each metric 1–5 using CASE WHEN logic, based on the observed spread of the data
4. Combined the three scores into business-friendly segments (Champions, Loyal Customers, At Risk, Lost, New Customers, Needs Attention) using nested subqueries
5. Saved the full logic as a reusable MySQL View (`rfm_segments`)
6. Built 4 DAX measures in Power BI: Total Customers, Total Revenue, Average Order Value, Churn Risk %
7. Designed an interactive dashboard: KPI summary ribbon, segment distribution bar chart, Frequency-vs-Monetary scatter plot, filterable customer table, segment slicer

## Key Findings
- 150 total customers generated **₹8,00,000** in total revenue
- **34.67%** of customers fall into an at-risk category (At Risk, Lost, Needs Attention) — a clear retention priority
- Champions and Loyal Customers show a strong positive correlation between purchase frequency and total spend
- Average Order Value: **₹641.24**

## Dashboard Preview
![Dashboard Screenshot](dashboard_screenshot.png)

## Files in This Repo
- `rfm_analysis.sql` — full SQL script (data cleaning, RFM scoring, View creation)
- `rfm_dashboard.pbix` — Power BI dashboard file
- `dashboard_screenshot.png` — dashboard preview image

## Future Enhancements
- Connect Power BI directly to the SQL View for live refresh
- Add a Pareto (80/20) analysis by segment
- Build a "Next Best Action" column mapping segments to marketing actions
