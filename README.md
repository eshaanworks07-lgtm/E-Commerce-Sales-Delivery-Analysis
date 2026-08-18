E-Commerce Sales & Delivery Analysis

Business Problem

I wanted to look at two main things in the Olist e-commerce data:

1. Is revenue generally going up or down over time?
2. Are late deliveries actually a big enough problem to be concerned about?

I used SQL to explore the data and then used Excel to organize the results and build a small dashboard.

Dataset

Brazilian E-Commerce Public Dataset by Olist (Kaggle)

I mainly worked with the orders and order items tables, covering around 54K delivered orders from September 2016 to August 2018.

Tools

- SQL (MySQL) — JOINs, GROUP BY, HAVING, CASE WHEN, subqueries, DATEDIFF and DATE_FORMAT
- Excel — PivotTables, COUNTIFS, SUMIFS, charts and dashboard

Key Questions

- Is revenue going up or down over time?
- How common are late deliveries?
- Is the late delivery rate getting better or worse?
- Do late deliveries seem to affect customer review scores?

Key Insights

1. Revenue grew quite a lot during 2017. It went from around 63.7K in January 2017 to around 565K in November 2017. After that, revenue stayed relatively high but fluctuated through 2018 instead of continuing to grow steadily.

2. Around 8.02% of delivered orders were late. Late orders also made up around 8.7% of the total order value, so their share of revenue was slightly higher than their share of orders.

3. The late delivery rate was around 3–7% in most months, but there were some noticeable spikes. It reached 14.43% in November 2017 and then went up even more in February and March 2018, reaching 15.78% and 20.80%. I couldn't find a clear reason for the February–March spike from the data I had, so I think that would be worth looking into further.

4. Late deliveries also had a much lower average review score. Late orders had an average score of 2.67 compared with 4.17 for on-time orders. This suggests there could be a link between delivery delays and customer satisfaction, although this analysis doesn't prove that late delivery directly caused the lower scores.

Recommendation

The main thing I'd investigate next is what happened in February and March 2018. The late delivery rate was much higher than normal during these two months, and it would be useful to check if the problem was concentrated in certain states, sellers or product categories.

Dashboard

Files in this repo

- OLIST-ECOMMERCE-PROJECT.sql — SQL queries used for the analysis
- olist excel insight.xlsx — Excel dashboard with KPIs, monthly revenue trend and late vs. on-time revenue
- DASHBOARD SCREENSHOT.png — dashboard preview
