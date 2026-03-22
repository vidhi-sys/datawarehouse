<div align="center">

<br/>

```
██████╗  █████╗ ████████╗ █████╗
██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
██║  ██║███████║   ██║   ███████║
██║  ██║██╔══██║   ██║   ██╔══██║
██████╔╝██║  ██║   ██║   ██║  ██║
╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
```

## W A R E H O U S E &nbsp;&nbsp;+&nbsp;&nbsp; A N A L Y T I C S

*An end-to-end data engineering project built on SQL Server*

<br/>

[![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/en-us/sql-server)
[![Architecture](https://img.shields.io/badge/Medallion_Architecture-gold?style=flat-square&logoColor=black)](.)
[![Schema](https://img.shields.io/badge/Star_Schema-4A90D9?style=flat-square)](.)
[![License](https://img.shields.io/badge/License-MIT-22c55e?style=flat-square)](./LICENSE)
[![Status](https://img.shields.io/badge/Status-Complete-22c55e?style=flat-square)](.)

<br/>

</div>

---

<br/>

## `01` &nbsp; Project Overview

This project implements a **production-style data warehouse** using the Medallion Architecture pattern — taking raw ERP and CRM data from CSV files all the way through to a clean, analytics-ready Star Schema model.

The goal: demonstrate real-world data engineering skills through structured ingestion, transformation, and modeling.

<br/>

---

<br/>

## `02` &nbsp; Architecture — Medallion Model

<br/>

```
  ┌─────────────────────────────────────────────────────────────┐
  │                      DATA SOURCES                           │
  │              📄 ERP CSV    +    📄 CRM CSV                  │
  └───────────────────────────┬─────────────────────────────────┘
                              │
                              ▼
  ┌─────────────────────────────────────────────────────────────┐
  │  🥉  BRONZE LAYER                                           │
  │      Raw ingestion — no transformation                      │
  │      Full source fidelity preserved                         │
  └───────────────────────────┬─────────────────────────────────┘
                              │
                              ▼
  ┌─────────────────────────────────────────────────────────────┐
  │  🥈  SILVER LAYER                                           │
  │      Cleansed + standardized                                │
  │      Null handling · Deduplication · Type normalization     │
  └───────────────────────────┬─────────────────────────────────┘
                              │
                              ▼
  ┌─────────────────────────────────────────────────────────────┐
  │  🥇  GOLD LAYER                                             │
  │      Business-ready star schema                             │
  │      Fact & dimension tables · Optimized for analytics      │
  └───────────────────────────┬─────────────────────────────────┘
                              │
                              ▼
  ┌─────────────────────────────────────────────────────────────┐
  │  📊  ANALYTICS                                              │
  │      Customers · Products · Sales · Revenue                 │
  └─────────────────────────────────────────────────────────────┘
```

<br/>

---

<br/>

## `03` &nbsp; Layer Breakdown

<br/>

### &nbsp;&nbsp;🥉 &nbsp; Bronze — *Raw Ingestion*

> The landing zone. Data enters exactly as-is from source files.

- Direct bulk load from CSV (ERP + CRM)
- Zero transformation applied
- Serves as the immutable source of truth
- Enables full reprocessing at any point

<br/>

### &nbsp;&nbsp;🥈 &nbsp; Silver — *Cleanse & Standardize*

> Data is made trustworthy and consistent.

- Null value handling & imputation
- Duplicate record resolution
- Data type normalization across sources
- Cross-source field standardization
- Row-level validation & quality checks

<br/>

### &nbsp;&nbsp;🥇 &nbsp; Gold — *Business-Ready Model*

> Structured for consumption by analysts and BI tools.

- Star Schema design (fact + dimensions)
- Relationships enforced at the model level
- Pre-aggregated where applicable
- Optimized for query performance

<br/>

---

<br/>

## `04` &nbsp; Analytics Coverage

<br/>

| Domain | What It Answers |
|--------|----------------|
| 👥 **Customers** | Who buys, how often, and what segments they fall into |
| 📦 **Products** | Which products perform, which underperform, and why |
| 📈 **Sales** | Revenue trends, seasonality, and growth patterns |

<br/>

---

<br/>

## `05` &nbsp; Skills Demonstrated

<br/>

```
  Data Modeling & Star Schema    ████████████████████  Core
  ETL Pipeline Design            ███████████████████░  Strong
  SQL Development                ████████████████████  Core
  Data Cleansing & Validation    ██████████████████░░  Strong
  Architecture Design            ███████████████████░  Strong
  Analytical Thinking            ██████████████████░░  Strong
```

<br/>

---

<br/>

## `06` &nbsp; Tech Stack

<br/>

| Category | Tools |
|----------|-------|
| **Database** | Microsoft SQL Server |
| **IDE** | SSMS (SQL Server Management Studio) |
| **Data Format** | CSV (ERP + CRM sources) |
| **Diagramming** | Draw.io |
| **Version Control** | Git + GitHub |
| **Project Mgmt** | Notion |
| **Design Patterns** | Medallion Architecture, Star Schema |

<br/>

---

<br/>

## `07` &nbsp; Repository Structure

<br/>

```
data-warehouse-project/
│
├── 📁 datasets/               ← Raw source CSV files (ERP + CRM)
│
├── 📁 docs/                   ← Architecture diagrams & documentation
│
├── 📁 scripts/
│   ├── 📁 bronze/             ← Ingestion scripts (raw load)
│   ├── 📁 silver/             ← Transformation & cleansing
│   └── 📁 gold/               ← Star schema modeling
│
├── 📁 tests/                  ← Data validation queries
│
├── README.md
├── LICENSE
└── .gitignore
```

<br/>

---

<br/>

## `08` &nbsp; Getting Started

<br/>

```sql
-- 1. Clone the repository
git clone https://github.com/yourusername/data-warehouse-project.git

-- 2. Open SSMS and connect to your SQL Server instance

-- 3. Run scripts in order:
--    scripts/bronze/  →  scripts/silver/  →  scripts/gold/

-- 4. Validate with test queries in /tests
```

<br/>

---

<br/>

## `09` &nbsp; About the Author

<br/>

<div align="center">

### Vidhi Udasi

*AIML · Data Analysis · SQL · Business Intelligence*

📍 VIT Bhopal, India &nbsp;|&nbsp; 📧 udasividhi2@gmail.com

<br/>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com)
[![GeeksforGeeks](https://img.shields.io/badge/GeeksforGeeks-2F8D46?style=flat-square&logo=geeksforgeeks&logoColor=white)](https://geeksforgeeks.org)

<br/>

*Built to learn. Designed to last. Open source under MIT License.*

</div>

<br/>

---

<div align="center">
<sub>◈ &nbsp; Data Warehouse & Analytics Project &nbsp; ◈</sub>
</div>
