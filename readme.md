# Data Warehouse & Analytics Project

> *End-to-end data pipeline · Medallion Architecture · SQL Server · Star Schema · Business Insights via pure SQL*

---

## ⚡ At a Glance

| 🥉 Layers | 📂 Sources | ⭐ Model | 🕐 Snapshot |
|-----------|-----------|---------|------------|
| 3 (Bronze → Silver → Gold) | ERP & CRM CSV files | Star Schema | Latest only (no historization) |

---

## 🌊 How Data Flows

```
CSV Files  ──►  🥉 Bronze  ──►  🥈 Silver  ──►  🥇 Gold  ──►  📊 Analytics
(ERP/CRM)       Raw Ingest      Clean+Transform   Star Schema    SQL Reports
```

---

##  Medallion Architecture

### 🥉 Bronze — Raw Zone
- Data lands here **exactly as-is** from CSV source files
- Zero transformations — pure source of truth
- `ERP data` + `CRM data` ingested into SQL Server

### 🥈 Silver — Clean Zone
- Nulls evicted · Duplicates eliminated · Types standardized
- Data becomes consistent, reliable, and trustworthy
- Validation checks applied before promotion

### 🥇 Gold — Business Zone
- Structured as a **Star Schema** (Fact + Dimension tables)
- Curated for fast queries and BI reporting
- The layer analysts actually touch

---

##  Analytics Objectives

| Focus Area | What We Uncover |
|------------|----------------|
|  Customer Behavior | Who buys, when, and how often they return |
|  Product Performance | Winners, laggards, and what drives the numbers |
|  Sales Trends | Revenue patterns, seasonal shifts, growth signals |

---

##  Skills Demonstrated

```
SQL Development          ████████████████████  Advanced
ETL Pipeline Design      ███████████████████   Advanced
Data Modeling            ██████████████████    Advanced
Data Cleaning            ████████████████████  Advanced
Medallion Architecture   ██████████████████    Intermediate
Analytics & Reporting    ███████████████████   Intermediate
```

- **SQL Development** — Complex queries, joins, aggregations, window functions
- **ETL Design** — Extract, transform, load pipelines built for reliability
- **Data Modeling** — Star schema with well-defined fact & dimension tables
- **Data Cleaning** — Null handling, deduplication, type normalization
- **Architecture** — Medallion pattern applied end-to-end
- **Analytics** — Business insights via structured SQL reporting

---

##  Tech Stack

| Category | Tool |
|----------|------|
| Database | SQL Server Express |
| IDE | SQL Server Management Studio (SSMS) |
| Source Data | CSV Files (ERP & CRM) |
| Diagramming | Draw.io |
| Version Control | Git & GitHub |
| Project Tracking | Notion |

---

##  Repository Structure

```
data-warehouse-project/
│
├── datasets/               ← raw CSV source files
├── docs/                   ← architecture & model diagrams
├── scripts/
│   ├── bronze/             ← raw ingestion scripts
│   ├── silver/             ← cleaning & transformation
│   └── gold/               ← star schema models
│
├── tests/                  ← validation queries
├── README.md
├── LICENSE
└── .gitignore
```

---

##  Key Highlights

- ✅ End-to-end **data pipeline** from raw CSV to business-ready insights
- ✅ Real-world **data cleaning & transformation** challenges tackled
- ✅ Scalable **Medallion Architecture** (Bronze → Silver → Gold)
- ✅ Optimized **Star Schema** analytical data models
- ✅ Pure **SQL-based analytics** — no external BI tools required
- ✅ Well-documented, structured, and portfolio-ready

---

##  License

This project is licensed under the **MIT License** — free to use, learn from, and build upon.

---

<div align="center">
  <sub>Built with brain for learning · Designed for portfolios · Powered by SQL</sub>
</div>