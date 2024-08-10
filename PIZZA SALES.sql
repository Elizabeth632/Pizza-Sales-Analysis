
-- Use Pizza;

-- get the whole data
select * from pizza_sales; 

-- To check for null values
Select * from pizza_sales
Where order_id is null
and pizza_name is null
and quantity is null
and pizza_category is null;

-- no null value found
-- to count total number of orders
Select count(*) from pizza_sales;

-- average pizza revenue
select avg(total_price)  from pizza_sales;

-- to check for start and end date of our pizza data
Select
     min(order_date) as start_date,
     max(order_date) as end_date
	from pizza_sales;


-- top 7 pizza details that have the highest price
Select order_id, pizza_name, pizza_category,  ROUND(Sum(total_price), 0) as price
from pizza_sales
group by order_id,pizza_name,pizza_category
order by price desc
limit 7;

-- to check for size category with their total sales
WITH size_sales as 
       ( select
       case when pizza_size = 'M' then 'medium'
       when pizza_size = 'L' then 'large'
	   when pizza_size = 'S' then 'small'
	   when pizza_size = 'XL' then 'xtra_large'
       when pizza_size = 'XXL' then 'xxtralarge'
      Else 'null' end as pizza_size,
      round(sum(total_price), 0 ) as price
	 from pizza_sales
     Group by pizza_size
     order by price desc
        )
Select * 
from size_sales;
 
 -- To get which month has the highest pizza sales
Select
     Extract(MONTH FROM order_date) as months,
	 round(sum(total_price), 0 ) as price
      from pizza_sales
      Group by months
      order by price desc;
      
            
-- which of our price category is much in demand
select 
     pizza_category, 
     round(sum(total_price), 0) as price
from pizza_sales
group by pizza_category
order by price desc;
