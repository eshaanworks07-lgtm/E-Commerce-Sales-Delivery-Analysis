# E-Commerce Sales & Delivery Analysis

## Business Problem
Leadership at an online marketplace wants to know two things: is revenue trending up or down month over month, and are late deliveries a real, measurable problem worth operational attention — or just noise.

## Dataset
Brazilian E-Commerce Public Dataset by Olist (Kaggle) — orders and order items tables, ~54K delivered orders, Sep 2016 - Aug 2018.

## Tools
- **SQL (MySQL)** — JOINs, GROUP BY, HAVING, CASE WHEN, date functions (DATEDIFF, DATE_FORMAT)
- **Excel** — PivotTables, SUMIFS/COUNTIFS, conditional formatting, dashboard design

## Key Questions Answered
- Is revenue trending up or down month over month?
- Are late deliveries a real, measurable problem, and is it improving or worsening over time?

## Key Insights
1. **Revenue grew roughly 8x** between Jan 2017 (R$63.7K) and a Nov 2017 peak (R$565K), then **plateaued through 2018** (R$459K-551K/month) instead of continuing to climb — a trend-shift, not a straight growth story.
2. **Overall late-delivery rate is 8.02% of orders**, and 8.68% of revenue — late orders skew slightly higher in value than the average order.
3. Late % isn't steady month to month — it spikes to **14.43% in Nov 2017** (alongside the order-volume surge, likely Black Friday) and to **15.78%-20.80% in Feb-Mar 2018**, the two worst months in the dataset by a wide margin, with no confirmed cause identified.
4. **Scope note:** this analysis uses only the orders and order_items tables. Whether late delivery measurably lowers review scores, or whether the Feb-Mar 2018 spike was concentrated in specific regions, would need the reviews/customers tables — flagged as a natural next step, not chased down here.

## Recommendation
Investigate what changed in Feb-Mar 2018 specifically, since it's the clearest anomaly in the data — before assuming ~8% is a stable, static late-delivery baseline going forward.

## Dashboard
![dashboard](screenshots/dashboard.png)

## Files in this repo
- `queries.sql` — all SQL, organized by section, commented
- `dashboard.xlsx` — Excel dashboard (KPIs, monthly revenue trend, late vs. on-time revenue split)
- `screenshots/dashboard.png` — dashboard preview
