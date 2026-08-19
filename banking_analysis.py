# Banking Transaction & Fraud Analytics
# Python analysis using Pandas, NumPy and Matplotlib

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# 1. Load data
df = pd.read_csv("dataset.csv")

# 2. Basic inspection
print("Shape:", df.shape)
print("\nColumns:")
print(df.columns.tolist())
print("\nMissing values:")
print(df.isna().sum())
print("\nSummary statistics:")
print(df[["amount", "customer_age", "risk_score"]].describe())

# 3. Data preparation
df["transaction_date"] = pd.to_datetime(df["transaction_date"])
df["month"] = df["transaction_date"].dt.to_period("M").astype(str)
df["fraud_flag"] = df["fraud_flag"].astype(int)

# 4. Core KPIs
total_transactions = len(df)
total_value = df["amount"].sum()
average_transaction = df["amount"].mean()
fraud_transactions = df["fraud_flag"].sum()
fraud_rate = df["fraud_flag"].mean() * 100
high_risk_transactions = (df["risk_score"] >= 80).sum()

print("\n--- Core KPIs ---")
print("Total transactions:", total_transactions)
print("Total transaction value:", round(total_value, 2))
print("Average transaction:", round(average_transaction, 2))
print("Fraudulent transactions:", fraud_transactions)
print("Fraud rate (%):", round(fraud_rate, 2))
print("High-risk transactions (risk_score >= 80):", high_risk_transactions)

# 5. Monthly transaction trend
monthly = (
    df.groupby("month")
      .agg(transaction_count=("transaction_id", "count"),
           transaction_value=("amount", "sum"),
           fraud_count=("fraud_flag", "sum"))
      .reset_index()
)
print("\n--- Monthly trend ---")
print(monthly)

# 6. Transaction type analysis
by_type = (
    df.groupby("transaction_type")
      .agg(transactions=("transaction_id", "count"),
           total_value=("amount", "sum"),
           average_amount=("amount", "mean"),
           fraud_rate=("fraud_flag", "mean"))
      .reset_index()
)
by_type["fraud_rate"] = by_type["fraud_rate"] * 100
print("\n--- Transaction type analysis ---")
print(by_type.sort_values("total_value", ascending=False))

# 7. Customer segment analysis
by_segment = (
    df.groupby("customer_segment")
      .agg(transactions=("transaction_id", "count"),
           total_value=("amount", "sum"),
           average_amount=("amount", "mean"),
           fraud_count=("fraud_flag", "sum"))
      .reset_index()
)
print("\n--- Customer segment analysis ---")
print(by_segment.sort_values("total_value", ascending=False))

# 8. Channel analysis
by_channel = (
    df.groupby("channel")
      .agg(transactions=("transaction_id", "count"),
           total_value=("amount", "sum"),
           fraud_count=("fraud_flag", "sum"))
      .reset_index()
)
print("\n--- Channel analysis ---")
print(by_channel.sort_values("transactions", ascending=False))

# 9. High-risk transactions
high_risk = df[df["risk_score"] >= 80].copy()
print("\n--- High-risk transactions ---")
print(high_risk[[
    "transaction_id", "transaction_date", "customer_id",
    "transaction_type", "amount", "channel", "fraud_flag", "risk_score"
]].sort_values("risk_score", ascending=False).head(20))

# 10. Save analysis outputs for portfolio use
monthly.to_csv("python_monthly_analysis.csv", index=False)
by_type.to_csv("python_transaction_type_analysis.csv", index=False)
by_segment.to_csv("python_customer_segment_analysis.csv", index=False)
by_channel.to_csv("python_channel_analysis.csv", index=False)

# 11. Simple fraud-rate chart
fraud_by_type = (
    df.groupby("transaction_type")["fraud_flag"]
      .mean()
      .mul(100)
      .sort_values(ascending=False)
)

plt.figure(figsize=(9, 5))
fraud_by_type.plot(kind="bar")
plt.title("Fraud Rate by Transaction Type")
plt.xlabel("Transaction Type")
plt.ylabel("Fraud Rate (%)")
plt.tight_layout()
plt.savefig("fraud_rate_by_transaction_type.png", dpi=150)
plt.show()
