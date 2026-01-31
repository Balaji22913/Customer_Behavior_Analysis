use customer_behaviour;

select * from shopping_data;

select gender, sum(purchase_amount) as Amount
from shopping_data
group by gender;


select * from shopping_data
where discount_applied = 'Yes' and purchase_amount >= (select avg(purchase_amount) from shopping_data);


select top 5 item_purchased, round(avg(review_rating),2) as avg_rating
from shopping_data
group by item_purchased
order by avg_rating desc;


select shipping_type, avg(purchase_amount) as avg_amount
from shopping_data
group by shipping_type
having shipping_type = 'Express' or shipping_type = 'Standard';



select subscription_status, avg(purchase_amount) as avg_amount, sum(purchase_amount) as total_revenue, count(customer_id) as total_count
from shopping_data
group by subscription_status;


select item_purchased, count(item_purchased) as item_count from shopping_data
WHERE discount_applied = 'Yes'
group by item_purchased;

select top 5
item_purchased, count(case when discount_applied = 'Yes' then 1 end)*100/count(*) as percentage_
from shopping_data
group by item_purchased
order by percentage_ desc;


with CTE as (select customer_id, count(*) as total_purchase from shopping_data group by customer_id),
customersegment as (select customer_id, total_purchase,
					case when total_purchase = 1 then 'New'
					when total_purchase between 2 and 10 then 'Returning'
					else 'Loyal'
					end as customer_segment
					from CTE)
select customer_segment, count(*) as segment_count
from customersegment
group by customer_segment;


with customer_type as (
SELECT customer_id, previous_purchases,
CASE 
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS customer_segment
FROM shopping_data)

select customer_segment,count(*) AS "Number of Customers" 
from customer_type 
group by customer_segment;







SELECT subscription_status,
       COUNT(customer_id) AS repeat_buyers
FROM shopping_data
WHERE previous_purchases > 5
GROUP BY subscription_status;





select age_group, sum(purchase_amount)as revenue
from shopping_data
group by age_group;