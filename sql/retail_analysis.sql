create database retail_analysis;
use retail_analysis;

create table Customers (
customer_id varchar(10) Primary Key,
first_name varchar(50),
last_name varchar(50),
city varchar(50)
);

create table Categories (
category_id varchar(10) Primary Key,
category_name varchar(50)
);

create table Products (
product_id varchar(10) Primary Key,
product_name varchar(100),
category_id varchar(10),
price decimal (10,2),
foreign key (category_id) references Categories (category_id)
);

create table Orders (
order_id INT Primary Key,
customer_id varchar (10),
order_date date,
foreign key (customer_id) references Customers (customer_id)
);

create table Order_Items (
order_item_id INT Primary Key,
order_id int,
product_id varchar(10),
quantity int,
foreign key (order_id) references Orders (order_id),
foreign key (product_id) references Products (product_id)
);

Select *
from categories;

Select *
from customers;

Select *
from order_items;

Select *
from orders;

Select *
from products;

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
