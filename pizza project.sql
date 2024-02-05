-- 1. How many customers do we have each day? Are there any peak hours?
select avg (totalcust)
from(
select date,count(order_id)as totalcust
from orders
group by date
order by date
)a;
-- an avg customers visit each day 59.639

-- 2. How many pizzas are typically in an order? Do we have any bestsellers?
select pizza_id,sum(quantity) as totalunitsold
from order_details
group by pizza_id
order by btotalunitsold desc
limit 5;

-- 3. How much money did we make this year in each month? Can we identify any seasonality in the sales?
SELECT monthname (date) as month, sum(od.quantity*price)as revenue
FROM orders o
Inner join order_details od
			on o.order_id=od.order_id
inner join pizzas as p
			on od.pizza_id =p.pizza_id
group by month
order by revenue desc;

-- 4. Are there any pizzas we should take off the menu, or any promotions we could leverage?
select pizza_id,sum(quantity)as totalunitsold
from order_details
group by pizza_id
order by totalunitsold desc;

-- SELECT p. pizza_id, sum(od.quantity*price)as revenue
FROM orders o
Inner join order_details od
			on o.order_id=od.order_id
inner join pizzas as p
			on od.pizza_id =p.pizza_id
group by pizza_id
order by revenue desc;



-- 5. What is the average order value for each pizza category (e.g., Vegetarian, Non-Vegetarian, etc.)?
with table1 as(
select o.order_id,o.date,od.pizza_id,od.quantity,
case
when od.quantity=4 then 4*p.price
when od.quantity=3 then 3*p.price
when od.quantity=2 then 2*p.price
else p.price
end as tprice,p.pizza_type_id,pt.category
from orders o inner join order_details od
on o.order_id=od.order_id
inner join pizzas p
on od.pizza_id=p.pizza_id
inner join pizza_types pt
on p.pizza_type_id=pt.pizza_type_id
)
select category,avg(tprice)
from table1

group by category;

-- 6. Are there any trends in sales based on the day of the week?

 SELECT DAYNAME (o.date) as extracted_day, sum(od.quantity*p.price)as revenue
 FROM  orders as o 
 inner join order_details od
 on o.order_id=od.order_id
 inner join pizzas as p
 on od.pizza_id=p.pizza_id
 group by extracted_day
 order by revenue desc;
