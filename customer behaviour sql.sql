select * from customer limit 20
select gender , SUM(PURCHASE_amount) as revenue
from customer
group by gender
 
select customer_id, purchase_amount
from customer
where discount_applied = 'yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

select item_purchased,ROUND(AVG(review_rating::numeric),2) as"average product rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;
select shipping_type,
ROUND (AVG(purchase_amount),2)
from customer
where LOWER(shipping_type) in ('standard','express')
group by shipping_type

Select subscription_status,
COUNT(customer_id)  as total_customers,
ROUND(AVG(PURCHASE_AMOUNT),2) as avg_spend,
ROUND(SUM(PURCHASE_AMOUNT),2) AS total_revenue
from customer
group by subscription_status
order by total_revenue, avg_spend desc;

select item_purchased,
ROUND (100 * sum(case WHEN discount_applied ILIKE'yes' THEN 1 ELSE 0 END)/COUNT(*),2) as discount_rate
 from customer
 group by item_purchased
 order by discount_rate desc
 limit 5;

 WITH customer_TYPE AS(
 select customer_id, previous_purchases,
 CASE
     when previous_purchases = 1 then 'new'
	 when previous_purchases between 2 and 10 then 'returning'
	 else 'loyal'
	 end as customer_segment
from customer
)
select customer_segment,count(*) as "number of customers"
from customer_type
group by customer_segment

 with item_counts as (
select category,
item_purchased,
COUNT(customer_id) as total_orders,
ROW_NUMBER() over (partition by category order by count (customer_id) desc) as item_rank
from customer
group by category, item_purchased
)

select item_rank,category,item_purchased, total_orders
from item_counts
where item_rank <=3;

select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases >5
group by subscription_status

select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc; 

 