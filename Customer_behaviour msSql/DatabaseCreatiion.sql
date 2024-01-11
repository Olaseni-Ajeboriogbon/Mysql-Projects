create database HOLLYS_KITCHEN;

Use HOLLYS_KITCHEN;
CREATE TABLE sales(
customer_id varchar(10),
order_date Date,
Product_id integer);

Insert into sales (Customer_id, Order_date,product_id)
values ('A', '2021-01-01', 1),
	('A', '2021-01-01', 2),
	('A', '2021-01-07', 2),
	('A', '2021-01-10', 3),
	('A', '2021-01-11', 3),
	('A', '2021-01-11', 3),
	('B', '2021-01-01', 2),
	('B', '2021-01-02', 2),
	('B', '2021-01-04', 1),
	('B', '2021-01-11', 1),
	('B', '2021-01-16', 3),
	('B', '2021-02-01', 3),
	('C', '2021-01-01', 3),
	('C', '2021-01-01', 3),
	('C', '2021-01-07', 3);

	CREATE TABLE menu(
	product_id INTEGER,
	product_name VARCHAR(5),
	price INTEGER
);

INSERT INTO menu
	(product_id, product_name, price)
VALUES
	(1, 'sushi', 10),
    (2, 'curry', 15),
    (3, 'ramen', 12);

CREATE TABLE members(
	customer_id VARCHAR(1),
	join_date DATE
);

-- Still works without specifying the column names explicitly
INSERT INTO members
	(customer_id, join_date)
VALUES
	('A', '2021-01-07'),
    ('B', '2021-01-09');

--1. What is the total amount each customer spent at the restaurant?

	select s.customer_id, SUM(m.price) as Total_Amt_spent from sales s join menu m on s.product_id = m. product_id group by s.customer_id;

-- 2. How many days has each customer visited the restaurant?

select s.customer_id, COUNT(distinct s.order_date) As No_days_visited from sales s group by s.customer_id;

-- 3. What was the first item from the menu purchased by each customer?

With customer_first_purchase As (
select s.customer_id, MIN(s.order_date) As first_purchase_date
from sales s
group by s.customer_id)
select cfp.customer_id, cfp.first_purchase_date, m.product_name 
from customer_first_purchase cfp
Join sales s ON s.customer_id = cfp.customer_id
AND cfp.first_purchase_date = s.order_date
Join menu m on m.product_id = s.product_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

  

-- 5. Which item was the most popular for each customer?

With customer_popularity As (
select s.customer_id, m.product_name, count(*) AS purchase_count,
DENSE_RANK() Over (partition by s.customer_id order by count(*) Desc) AS rank
from sales s
Join menu m ON s.product_id = m.product_id Group by S.customer_id, m.product_name
)
Select cp.Customer_id,cp.product_name, cp.purchase_count
from customer_popularity cp
where rank = 1;

-- 6. Which item was purchased first by the customer after they became a member?

with first_purchase_after_membership As (
select s.customer_id, Min(s.order_date) As first_purchase_date
from sales s
Join members mb on s.customer_id = mb.customer_id
where s.order_date >= mb.join_date
Group by s.customer_id
)
select fpam.customer_id, m.product_name 
from first_purchase_after_membership fpam
Join sales s on s.customer_id = fpam.customer_id
and fpam.first_purchase_date = s.order_date
Join menu m on s.Product_id = m.product_id;


-- 7. Which item was purchased just before the customer became a member?

With last_purchase_before_membership As (
select s. customer_id, Max(s.order_date) AS last_purchase_date
from sales s
JOIN members mb ON s.customer_id = mb.customer_id
where s.order_date < mb.join_date
Group by s.customer_id )
select lpbm.customer_id, m.product_name
from last_purchase_before_membership lpbm
Join sales s on lpbm.customer_id = s.customer_id
And lpbm.last_purchase_date = s.order_date
Join menu m on s.Product_id = m.product_id;

-- 8. What is the total items and amount spent for each member before they became a member?

select s.customer_id, COUNT(*) As total_items, SUM(m.price) As total_spent
from sales s
JOIN menu m on s. product_id = m.product_id
Join members mb on s.customer_id = mb.customer_id
where s.order_date < mb.join_date
Group by s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

Select s.customer_id, SUM(
Case
When m.product_name = 'sushi' Then m.price*20
else m.price*10 END) As total_points
From sales s
Join menu m ON s.Product_id = m.product_id
Group by s.customer_id;

/* 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - 
how many points do customer A and B have at the end of January?*/

Select s.customer_id, SUM(
Case
When s.order_date between mb.join_date AND DATEADD(day,7, mb.join_date )
Then m.price*20
When m.product_name ='sushi' Then m.price*20
Else m.price*10 END ) as total_points
from sales s
Join menu m on s.product_id = m.product_id
left Join Members mb on s.customer_id = mb.customer_id
where s.customer_id in ('A', 'B') AND s.order_date <= '2021-01-31'
Group by s.customer_id;

--11. Recreate the table output using the available data

Select s.customer_id,s. order_date,m.product_name,m.price,
CASE
When s.order_date >= mb.Join_date Then 'Y'
Else 'N' End As member
from sales s
join menu m on s.product_id = m.Product_id
Left Join Members mb On S.customer_id = mb.customer_id
order By S.customer_id, S.order_date;

--12. Rank all the things:

With customers_data As
(Select s.customer_id, s.order_date,m.product_name,m.price,
Case
When s.order_date < mb.join_date Then 'N'
When s.order_date >= mb.join_date Then 'Y'
Else 'N' End As member
From sales s
Left Join members mb On s.customer_id = mb.customer_id
Join menu m On s.Product_id = m.product_id)
Select *,
Case 
When member = 'N' Then Null
Else RANK() Over (Partition by customer_id, member order by order_date)
End As Ranking
From customers_data
Order By customer_id,order_date;
