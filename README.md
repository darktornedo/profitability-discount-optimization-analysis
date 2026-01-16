# 📊 Profitability Analysis & Discount Optimization  

## 🔍 Project Summary
This project analyzes **business profitability and discount effectiveness** to identify **profit drivers, loss-making areas, and pricing inefficiencies**.  
Using **Python, SQL, and Power BI**, I built a complete analytics pipeline — from raw data cleaning to executive-level dashboards — to support **data-driven pricing and discount decisions**.

---

## 💼 Business Problems Addressed
- Which products and categories generate the **highest and lowest profit**?
- How do **discounts impact profit margins and loss-making orders**?
- What is The Optimal Discount Range?
- What is the **break-even discount percentage** beyond which profit declines?
- Are profits **concentrated among a small set of Sub-Categories (Pareto principle)**?
- Which **regions, customer segments, and ship modes** drive or leak profit?

---

## 🛠️ Tools & Technologies
- **Excel** – Initial data review  
- **Python (Jupyter Notebook)** – Data cleaning, EDA, feature engineering  
- **Pandas, NumPy** – Data manipulation  
- **Matplotlib, Seaborn** – Exploratory visualization  
- **MySQL** – Advanced SQL analysis  
- **SQLAlchemy** – Python–SQL integration  
- **Power BI** – Interactive dashboards & storytelling
  
---

## 🔄 End-to-End Workflow

### 1️⃣ Data Understanding & Validation
- Downloaded dataset from GitHub and reviewed structure in **Excel**
- Verified pricing, cost, discount, and categorical fields

### 2️⃣ Data Cleaning & Preparation (Python)
- Standardized invalid categorical values (`N/A`, `Unknown`, `Not Available`)
- Removed records with zero cost or price
- Converted date fields to proper datetime format
- Validated numeric ranges and distributions
- Retained genuine high-value product outliers to preserve business realism

### 3️⃣ Feature Engineering
Created key financial and performance metrics:
- Gross Revenue & Net Revenue
- Discount Amount
- Total Cost
- Profit
- Profit Margin %

### 4️⃣ Exploratory & Diagnostic Analysis
- Univariate and bivariate analysis
- Category wise analysis
- Loss-making order analysis
- Discount impact and optimization analysis
- Correlation analysis between revenue, cost, quantity, discount, profit and profit margin

### 5️⃣ SQL-Based Business Analysis
- After data cleaning and EDA:
- Connected Jupyter Notebook to **MySQL** using:
  - `sqlalchemy`
  - `urllib.parse`
  - SQL engine creation
- Exported clean dataset to **MySQL**
- Wrote analytical SQL queries for:
  - Product & category profitability
  - Discount threshold identification
  - Pareto (Top 20% profit contribution)
  - Regional and customer performance analysis

### 6️⃣ Power BI Dashboard & Storytelling
Imported the final dataset into **Power BI** and built a **3-page interactive dashboard**:

#### 📄 Page 1: Profitability Overview
- Revenue, profit, and margin KPIs
- Category-wise and time-based performance
- Margin distribution analysis

📷 *Screenshot:*
![Profitability Overview](screenshots/profitability_overview.png)

---

#### 📄 Page 2: Discount Impact Analysis
- Discount vs profit and margin trends
- Break-even discount identification
- Loss-making orders by discount level
- Category-level discount effectiveness

📷 *Screenshot:*
![Discount Impact Analysis](screenshots/discount_impact_analysis.png)

---

#### 📄 Page 3: Profit Concentration & Regional Performance
- Pareto analysis (Top 20% profit contribution)
- Profitable vs loss-making Sub-Categories
- Segment-wise and region-wise profitability

📷 *Screenshot:*
![Profit Concentration & Regional Performance](screenshots/profit_concentration_regional.png)

---


## 📈 Key Business Insights
- A small percentage of products contribute a **disproportionately high share of total profit**
- Discounts beyond a certain threshold significantly reduce profit margins
- High revenue does **not always indicate high profitability**
- Loss-making orders increase sharply at higher discount levels
- Profitability varies meaningfully across **regions and customer segments**

---

## 🚀 Project Impact
This project demonstrates:
- Strong **business and financial analytics thinking**
- Practical application of **Python, SQL, and Power BI**
- Ability to translate data into **actionable business insights**
- End-to-end ownership of an analytics problem

---

## 👤 Author
**Kumkum Pal**  
