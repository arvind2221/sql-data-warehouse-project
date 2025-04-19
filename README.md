# SQL Data Warehouse Project

This project demonstrates a robust implementation of a **multi-layered SQL Data Warehouse** based on the Bronze-Silver-Gold architecture. The warehouse is designed for scalability, modularity, and support for advanced analytics such as BI dashboards and fraud detection.

---

## 🧱 Architecture Overview

The data warehouse is organized into three logical layers:

### 🔹 Bronze Layer – Raw Data Ingestion

- **Source Systems:** CRM, Interface CSV files in folders  
- **Data Model:** None (as-is)  
- **Storage Type:** Tables  
- **Load Type:** Full Load via Batch Processing (`Truncate and Insert`)  
- **Transformations:** ❌ No transformations applied  
- **Purpose:** Preserve raw, unaltered data from source systems for traceability and reprocessing.

---

### 🔸 Silver Layer – Cleaned & Standardized Data

- **Data Model:** None (as-is)  
- **Storage Type:** Tables  
- **Load Type:** Full Load via Batch Processing (`Truncate and Insert`)  
- **Transformations:**
  - Data Cleaning
  - Standardization
  - Normalization
  - Derived Columns
  - Data Enrichment  
- **Purpose:** Prepare data for analytics by applying transformations, improving quality, and ensuring consistency.

---

### 🟡 Gold Layer – Business-Ready Data

- **Data Model:**
  - Star Schema  
  - Flat Tables  
  - Aggregated Tables  
- **Storage Type:** Views (virtualized layer, no physical storage)  
- **Transformations:**
  - Business Logic Implementation
  - Data Integration
  - Aggregation  
- **Purpose:** Serve data to downstream consumers in a format optimized for business analysis and reporting.

---

## 📊 Data Consumption

Data from the Gold Layer is consumed by multiple tools and stakeholders:
- **Power BI** for executive dashboards and visualizations
- **Ad-hoc SQL Queries** for analysts and reporting teams
- **Machine Learning Pipelines** (e.g., fraud detection)

---

## 📁 Project Structure
## About me 
Hi, I am Arvind Singh persuing M.Tech in Data Science.


