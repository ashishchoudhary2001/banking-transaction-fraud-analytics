# Banking Transaction & Fraud Analytics

## 📌 Project Overview

An end-to-end banking transaction analytics project focused on understanding transaction behavior, customer segments, transaction channels and fraud patterns.

The project analyzes 50,000 synthetic banking transactions and converts raw transaction data into business-focused insights using SQL and Excel, with Power BI, Python and SAS analysis planned as part of the complete analytics workflow.

---

## 🎯 Business Problem

A banking organization wants to understand:

- How transaction activity changes over time
- Which transaction types generate the highest transaction value
- Which customer segments contribute the most activity
- Which cities and channels have the highest transaction volume
- Where fraudulent transactions are concentrated
- Which transactions require additional risk investigation

The objective is to use data analysis to identify patterns and provide actionable business insights.

---

## 📊 Dataset

The dataset contains 50,000 synthetic banking transactions.

Key fields include:

- Transaction ID
- Transaction Date
- Customer ID
- Customer Age
- Customer Segment
- City
- Transaction Type
- Amount
- Merchant Category
- Channel
- Transaction Status
- Fraud Flag
- Risk Score

---

## 🛠️ Tools & Technologies

- SQL / MySQL
- Python
- SAS
- Power BI
- Microsoft Excel

### SQL
- Aggregations
- GROUP BY
- CASE statements
- CTEs
- Window functions
- Ranking
- Trend analysis

### Python
- Pandas
- NumPy
- Matplotlib
- Data cleaning
- Exploratory Data Analysis

### SAS
- DATA Step
- PROC SQL
- PROC SORT
- PROC FREQ
- PROC MEANS

### Power BI
- KPI dashboards
- Data visualization
- Interactive filtering
- Trend analysis

---

## 🔎 Business Questions

1. What is the total transaction value?
2. What is the average transaction amount?
3. Which transaction types have the highest value?
4. Which customer segments generate the most transactions?
5. Which cities have the highest transaction activity?
6. Which channels are used most frequently?
7. What is the overall fraud rate?
8. Which transaction types have the highest fraud rate?
9. Which customer segments have higher fraud activity?
10. Which transactions have the highest risk scores?
11. How does transaction activity change month over month?
12. Who are the highest-value customers?

---

## 📈 Key KPIs

- Total Transactions
- Total Transaction Value
- Average Transaction Amount
- Fraudulent Transactions
- Fraud Rate
- High-Risk Transactions
- Transaction Value by Channel
- Transaction Value by Customer Segment

---

## 📂 Project Structure

```text
banking-transaction-fraud-analytics/
│
├── README.md
├── dataset.csv
├── analysis.sql
├── analysis_workbook.xlsx
│
├── Python/
│   └── banking_analysis.py
│
├── SAS/
│   └── banking_analysis.sas
│
├── PowerBI/
│   └── banking_fraud_dashboard.pbix
│
└── screenshots/
    └── dashboard.png
