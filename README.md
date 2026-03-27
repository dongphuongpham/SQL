# 🧠 Metaverse Financial Transactions Analysis (SQL)

## 📌 Overview

Performed SQL analysis on metaverse financial transactions to identify patterns, ensure data quality, and detect potential anomalous behaviors.

## 🛠 Tools

* SQL Server (T-SQL)

## 🔄 Key Tasks

* Cleaned and validated transaction data to ensure consistency
* Developed queries to analyze multi-dimensional transaction data
* Aggregated and filtered data to identify high-value and unusual activities

## ⚙️ Techniques Applied

* Implemented **Subqueries and Correlated Subqueries** for dynamic comparisons
* Applied **CTE (Common Table Expressions)** for modular and readable queries
* Used **JOINs (including self-joins)** to analyze transaction relationships
* Applied **CAST** for time-based analysis

## 📊 Key Insights

* Identified potential circular transaction patterns (e.g., A → B → A)
* Detected potential location anomalies from transactions occurring across regions within short timeframes
* Highlighted wallets with unusually high transaction volumes
* Identified transactions exceeding typical thresholds within regions
