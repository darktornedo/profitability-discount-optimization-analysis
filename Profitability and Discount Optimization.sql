create database revenue_db;
use revenue_db;

-- Basic understanding of the dataset
with rcp as (
select 
	 round(sum(total_revenue),2) as gross_revenue,
     round(sum(net_revenue),2) as net_revenue,
     round(sum(discounted_amount),2) as total_discount_given,
     sum(total_cost) as cost,
     round(sum(profit),2) as profit
from revenue
)
select gross_revenue, net_revenue, total_discount_given, cost, profit,
	round((profit/cost)*100,2) as profit_percentage_on_cost,
    round((profit/net_revenue)*100,2) as profit_margin
from rcp;

select 
     round(avg(discount_percent),6) as avg_disocunt
from revenue;

select 
     count(distinct order_id) as total_orders,
     sum(quantity) as total_qty_sold
from revenue;

select 
     category,
     count(distinct sub_category) as total_sub_category,
     count(distinct product_id) as total_products
from revenue
group by category;


-- Profitability Analysis

-- Q.1 Which products generate the highest total profit?
select 
     product_id,
     round(sum(profit),2) as total_profit
from revenue
group by product_id
order by total_profit desc
limit 10;

-- Q.2 Which products have negative profit?
select 
     product_id, profit
from revenue
order by profit
limit 10;

-- Q.3 Which category have high sales but low profit?
select 
      category,
      sum(quantity) as total_qty_sold,
      round(sum(profit),2) as total_profit,
      round(sum(profit)/sum(net_revenue)*100,2) as profit_margin_pct
from revenue 
group by category
order by total_qty_sold desc;

-- Q.4 Which categories have high revenue but low margins?
WITH category_metrics AS (
  SELECT 
        category,
        SUM(net_revenue) AS total_revenue,
        SUM(profit) AS total_profit,
        (SUM(profit) / SUM(net_revenue)) * 100 AS profit_margin
    FROM revenue
    GROUP BY category
),
averages AS (
    SELECT 
        AVG(total_revenue) AS avg_revenue,
        AVG(profit_margin) AS avg_margin
    FROM category_metrics
)
SELECT 
    c.category,
    c.total_revenue,
    c.profit_margin
FROM category_metrics c
CROSS JOIN averages a
WHERE 
    c.total_revenue > a.avg_revenue
    AND c.profit_margin < a.avg_margin;

-- Q.5 What % of total profit comes from top 20% products?
WITH product_profit AS (
    SELECT
        product_id,
        SUM(profit) AS total_profit
    FROM revenue
    GROUP BY product_id
),
ranked_products AS (
    SELECT
        product_id,
        total_profit,
        RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
        COUNT(*) OVER () AS total_products
    FROM product_profit
)
SELECT
    ROUND(
        SUM(total_profit) * 100.0 /
        (SELECT SUM(total_profit) FROM ranked_products),
        2
    ) AS top_20_percent_profit_contribution
FROM ranked_products
WHERE profit_rank <= total_products * 0.20;

-- Q.6 Which regions are least profitable?
select 
     region,
     round(sum(net_revenue),2) as total_revenue,
     round(sum(total_cost),2) as total_cost,
     count(quantity) as total_qty_sold,
     round(sum(profit),2) as total_profit,
     round(sum(profit)/sum(net_revenue)*100,2) as profit_margin_pct
from revenue
group by region
order by profit_margin_pct;

-- Q.7 Customer Segment contribute most to profit?
with segment_profit as(
select
     segment,
     sum(profit) as total_profit
from revenue 
group by segment
)
select 
    segment, total_profit,
    round(total_profit *100 / sum(total_profit) over(),2) as profit_contribution_pct
from segment_profit
order by profit_contribution_pct desc;



-- Discount Optimization
-- Q.1 What is the average discount per product?
with avg_discount_per_product as(
select 
      product_id,
      round(avg(discount_percent),2) as avg_discount
from revenue
group by product_id
)
select 
    round(avg(avg_discount),7) as overall_avg_discount
from avg_discount_per_product;

-- Q.2 Which products are over-discounted?
WITH product_metrics AS (
    SELECT
        product_id,
        round(AVG(discount_percent),2) AS avg_discount,
        SUM(profit) AS total_profit,
        (SUM(profit) / SUM(net_revenue)) * 100 AS profit_margin
    FROM revenue
    GROUP BY product_id
)
, benchmarks AS (
    SELECT
        AVG(avg_discount) AS overall_avg_discount,
        AVG(profit_margin) AS overall_avg_margin
    FROM product_metrics
)
SELECT
    p.product_id,
    p.avg_discount,
    p.total_profit,
    p.profit_margin
FROM product_metrics p
CROSS JOIN benchmarks b
WHERE
    p.avg_discount > b.overall_avg_discount
    AND p.profit_margin < b.overall_avg_margin
ORDER BY p.avg_discount DESC;

-- Q.3 Does higher discount always mean higher sales?
select 
    discount_percent,
    sum(quantity) as total_qty_sold
from revenue
group by discount_percent
order by total_qty_sold desc;

-- Q.4 Which customers take high discounts but give low profit?
WITH segment_metrics AS (
    SELECT
        segment,
        round(AVG(discount_percent),2) AS avg_discount,
        round(SUM(profit),2) AS total_profit,
        round(SUM(profit) / SUM(net_revenue),5) * 100 AS profit_margin
    FROM revenue
    GROUP BY segment
),
overall_avg AS (
    SELECT
        AVG(avg_discount) AS avg_discount_all,
        AVG(profit_margin) AS avg_margin_all
    FROM segment_metrics
)
SELECT
    s.segment,
    s.avg_discount,
    s.total_profit,
    s.profit_margin
FROM segment_metrics s
CROSS JOIN overall_avg o
WHERE
    s.avg_discount > o.avg_discount_all
    AND s.profit_margin < o.avg_margin_all;


-- Loss & Risk Analysis
-- Q.1 loss making orders
select 
    category, discount_percent, sum(profit) as total_loss
from revenue 
where profit < 0
group by category, discount_percent;

-- Q.2 Discount Levels Causing Maximum Loss
select 
    discount_percent,
    count(*) as loss_orders ,
    round(sum(profit),2) as total_loss
from revenue 
where profit < 0
group by discount_percent
order by loss_orders desc;