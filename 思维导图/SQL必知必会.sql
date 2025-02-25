select prod_name
from Products
limit 3, 4;

select cust_id
from Customers;

select distinct prod_id
from OrderItems;

-- select * from Customers;
select cust_id
from Customers;

select prod_id, prod_price, prod_name
from Products
order by prod_price, prod_name;

select prod_id, prod_price, prod_name
from Products
order by 2, 3;

select prod_id, prod_price, prod_name
from Products
order by prod_price desc;

select cust_name
from Customers
order by cust_name desc;

select cust_id, order_num
from Orders
order by cust_id, order_date desc;

select quantity, item_price
from OrderItems
order by quantity desc, item_price desc;

select prod_name, prod_price
from Products
where prod_price = 3.49;

select vend_id, prod_name
from Products
where vend_id <> 'DLL01';

select prod_name, prod_price
from Products
where prod_price between 5 and 10;

select cust_name
from Customers
where cust_email is null;

select prod_id, prod_name
from Products
where prod_price = 9.49;

select prod_id, prod_name
from Products
where prod_price >= 9;

select distinct order_num
from OrderItems
where quantity >= 100;

select prod_name, prod_price
from Products
where prod_price between 3 and 6
order by prod_price;

select vend_name
from Vendors
where vend_country = 'USA'
  and vend_state = 'CA';

select order_num, prod_id, quantity
from OrderItems
where quantity >= 100
  and prod_id in ('BR01', 'BR02', 'BR03')
order by prod_id, quantity;

select prod_name, prod_price
from Products
where prod_price >= 3
  and prod_price <= 6;

select cust_contact
from Customers
where cust_contact like '[JM]%'
order by cust_contact;

select prod_name, prod_desc
from Products
where prod_desc like '%toy%';

select prod_name, prod_desc
from Products
where not prod_desc like '%toy%'
order by prod_name;

select prod_name, prod_desc
from Products
where prod_desc like '%toy%'
  and prod_desc like '%carrots%';

select prod_name, prod_desc
from Products
where prod_desc like '%toy%carrots%';

select CONCAT(vend_name, ' (', vend_country, ')') as vender_title
from Vendors
order by vend_name;

select current_date();

select vend_id,
       vend_name    as vname,
       vend_address as vaddress,
       vend_city    as vcity
from Vendors
order by vname;

select prod_id,
       prod_price,
       prod_price * 0.9 as sale_price
from Products;

select vend_name, upper(vend_name) as vend_name_upcase
from Vendors;

select order_num
from Orders
where YEAR(order_date) = '2020';

select cust_id,
       cust_name,
       upper(concat(left(cust_contact, 2), left(cust_country, 3))) as user_login
from Customers;

select substring(trim(cust_name), 0, 2)
from Customers;

select order_num, order_date
from Orders
where year(order_date) = '2020'
  and month(order_date) = '1';

select avg(prod_price) as avg_price
from Products;

select sum(quantity)
from OrderItems;

select sum(quantity)
from OrderItems
where prod_id = 'BR01';

select max(prod_price) as max_price
from Products
where prod_price <= 10;

select vend_id, count(*) as num_prods
from Products
group by vend_id;

-- 10.1
select order_num, count(*) as order_lines
from OrderItems
group by order_num
order by order_lines;

-- 10.2
select vend_id, min(prod_price) as cheapest_item
from Products
group by vend_id
order by cheapest_item;

-- 10.3
SELECT order_num
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity) >= 100
ORDER BY order_num;

-- 10.4
select order_num, sum(quantity * item_price) as total_price
from OrderItems
group by order_num
having sum(quantity * item_price) > 1000
order by order_num;

-- 10.5
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY items
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

-- 11.1
select *
from Customers
where cust_id in (
    select cust_id
    from Orders
    where order_num in (
        select order_num
        from OrderItems
        where item_price >= 10
    )
);

-- 11.2
select cust_id, order_date
from Orders
where order_num in (
    select OrderItems.order_num
    from OrderItems
    where prod_id = 'BR01')
order by order_date;

-- 11.3
select cust_email
from Customers
where cust_id in (
    select cust_id
    from Orders
    where order_num in (
        select order_num
        from OrderItems
        where prod_id = 'BR01'
    )
);

-- 11.4
select cust_id,
       (
           select sum(quantity * OrderItems.item_price)
           from OrderItems
           where order_num in (
               select order_num
               from Orders
               where Orders.cust_id = Customers.cust_id
           )) as total_ordered
from Customers
order by total_ordered desc;

-- 11.5
select prod_name,
       (select sum(quantity)
        from OrderItems
        where OrderItems.prod_id = Products.prod_id) as quant_sold
from Products;

-- 12.1
select cust_name, order_num
from Customers,
     Orders
where Customers.cust_id = Orders.cust_id
order by cust_name, order_num;

select cust_name, order_num
from Customers
         inner join Orders
                    on Customers.cust_id = Orders.cust_id
order by cust_name, order_num;

-- 12.2
select cust_name, Orders.order_num, sum(quantity * item_price) as order_total
from Customers
         inner join Orders on Customers.cust_id = Orders.cust_id
         inner join OrderItems on Orders.order_num = OrderItems.order_num
group by cust_name, Orders.order_num
order by cust_name, order_num;

-- 12.3
select cust_id, order_date
from Orders,
     OrderItems
where Orders.order_num = OrderItems.order_num
  and prod_id = 'BR01'
order by order_date;

select cust_id, order_date
from Orders
         inner join OrderItems OI on Orders.order_num = OI.order_num
where prod_id = 'BR01'
order by order_date;

-- 12.4
select cust_email
from Customers
         inner join Orders on Customers.cust_id = Orders.cust_id
         inner join OrderItems on Orders.order_num = OrderItems.order_num
where prod_id = 'BR01';

-- 12.5
select cust_name, sum(quantity * item_price) as total_order
from Customers,
     Orders,
     OrderItems
where Customers.cust_id = Orders.cust_id
  and Orders.order_num = OrderItems.order_num
group by cust_name
having total_order >= 1000
order by cust_name;


SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                   FROM Customers
                   WHERE cust_contact = 'Jim Jones');

-- 13.1
select cust_name, order_num
from Customers
         inner join Orders
                    on Customers.cust_id = Orders.cust_id;

-- 13.2
select cust_name, order_num
from Customers
         left join Orders
                   on Customers.cust_id = Orders.cust_id;

-- 13.3
select prod_name, order_num
from Products
         left join OrderItems
                   on Products.prod_id = OrderItems.prod_id
order by prod_name;

-- 13.4
select prod_name, count(order_num) as orders
from Products
         left join OrderItems
                   on Products.prod_id = OrderItems.prod_id
group by prod_name
order by prod_name;

-- 13.5
select Vendors.vend_id, count(prod_id)
from Vendors
         left join Products
                   on Vendors.vend_id = Products.vend_id
group by Vendors.vend_id;

-- 14.1
select prod_id, quantity
from OrderItems
where quantity = 100
union
select prod_id, quantity
from OrderItems
where prod_id like 'BNBG%'
order by prod_id;

-- 14.2
select prod_id, quantity
from OrderItems
where quantity = 100
   or prod_id like 'BNBG%'
order by prod_id;

-- 14.3
select prod_name
from Products
union
select cust_name
from Customers
order by prod_name;


-- 15.2
create table CustomerCopy as
select *
from Customers;
create table OrderCopy as
select *
from Orders;
create table OrderItemsCopy as
select *
from OrderItems;

-- 17.1
alter table Vendors
    add column vend_web char(100);

create view ProductCustomers as
select cust_name, cust_contact, prod_id
from Customers,
     Orders,
     OrderItems
where Customers.cust_id = Orders.cust_id
  and Orders.order_num = OrderItems.order_num;

select cust_name, cust_contact
from productcustomers
where prod_id = 'RGAN01';

drop view VendorLocations;

create view VendorLocations as
select concat(rtrim(vend_name), ' (', rtrim(vend_country), ') ') as vend_title
from Vendors;

select *
from vendorlocations;

create view CustomerEmailList as
select cust_id, cust_name, cust_email
from Customers
where cust_email is not null;

select *
from customeremaillist;

create view OrderItemsExpanded as
select order_num, prod_id, quantity, item_price, quantity * item_price as expanded_price
from OrderItems;

select *
from OrderItemsExpanded
where order_num = 20008;

-- 18.1
create view CustomerWithOrders as
select Customers.*
from Customers
         inner join Orders O on Customers.cust_id = O.cust_id;
select *
from CustomerWithOrders;

-- 18.2
CREATE VIEW OrderItemsExpanded1 AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM OrderItems
ORDER BY order_num;


