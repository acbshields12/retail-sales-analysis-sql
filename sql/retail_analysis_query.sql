-- Total Revenue --
select
sum(oi.quantity * p.price) as total_revenue
from order_items oi
join products p
on oi.product_id = p.product_id;

-- Revenue by Product --
select
p.product_name,
sum(oi.quantity * p.price) as Revenue
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.product_name;

-- Top Customers with orders --
select
c.first_name,
c.last_name,
sum(oi.quantity * p.price) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
Group by c.customer_id
order by total_spent desc
;

-- Customers even without Orders --
select 
c.first_name,
c.last_name,
sum(oi.quantity * p.price) as total_spent
from customers c
left join orders o
on c.customer_id = o.customer_id
left join order_items oi
on o.order_id = oi.order_id
left join products p
on oi.product_id = p.product_id
Group by c.customer_id
;

-- Most Popular Product --
select p.product_name,
sum(oi.quantity) as total_sold
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.product_name
Order by Total_sold Desc
;

-- Customer Segmentation (High vs Low Spenders) --
select 
c.first_name,
c.last_name,
sum(oi.quantity * p.price) as total_spent,
case
when sum(oi.quantity * p.price) >= 100 then 'High Spender'
when sum(oi.quantity * p.price) >= 50 then 'Medium Spender'
else 'Low Spender'
end as customer_type
from customers c
left join orders o
on c.customer_id = o.customer_id
left join order_items oi
on o.order_id = oi.order_id
left join products p
on oi.product_id = p.product_id
Group by c.customer_id
;

-- Sales by Category --
select
cat.category_name,
sum(oi.quantity * p.price) as Revenue
from order_items oi
join products p
on oi.product_id = p.product_id
join categories cat
on p.category_id = cat.category_id
group by cat.category_name
order by revenue desc
;

-- Daily Sales Trend --
select
o.order_date,
sum(oi.quantity * p.price) as daily_Revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by o.order_date
order by o.order_date
;

-- Top # Products --
select
p.product_name,
sum(oi.quantity) as total_sold
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.product_name
order by total_sold desc
limit 3 
;
