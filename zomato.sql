


------------------------------              PROBLEMS THAT NEED TO BE SOLVED               ---------------------------------------
/*
1.What is total amount each customer spent on ZOMATO

2.How many days has each customer visited ZOMATO

3.What was the first product purchased by each customer

4.What is the most purchased item on menu and how many times it was purchased by all the customers

5.Which item was the most popular for each customer

*/




------------                            CREATE A DATABASE ZOMATO                --------------------------------
create database zomato
use zomato

---***************************************************************************************************************************--

-------                    CREATE TABLE GOLDUSERS_SIGNUP(INORDER TO FETCH GOLDMEMBERS IN OUR ZOMATO DATASET)      ----------

CREATE TABLE goldusers_signup(userid integer,gold_signup_date date);

---***************************************************************************************************************************--

---------                            INSERTING THE DATA IN OUR GOLDUSERS TABLE                            ---------------------------

INSERT INTO goldusers_signup(userid,gold_signup_date)
VALUES (1,'09-22-2017'),
(3,'04-21-2017');

---***************************************************************************************************************************--

----------------                     CREATE TABLE USERS TO FETCH USER DETAILS                      --------------------------
CREATE TABLE users(userid integer,signup_date date);

---***************************************************************************************************************************--

------------------                   INSERT VALUES IN OUR USERS TABLE                       ----------------------------------
INSERT INTO users(userid,signup_date)

VALUES (1,'09-02-2014'),

(2,'01-15-2015'), (3,'04-11-2014');

---***************************************************************************************************************************--

------------                         CREATE TABLE FOR SALES                  ---------------------------------------------------

CREATE TABLE sales(userid integer,created_date date,product_id integer);

---***************************************************************************************************************************--

-------------                        INSERT VALUES IN SALES TABLE            -----------------------------------------------
INSERT INTO sales(userid,created_date,product_id) VALUES (1,'04-19-2017',2),

(3,'12-18-2019',1), (2,'07-20-2020',3),

(1,'10-23-2019',2), (1,'03-19-2018',3),

(3,'12-20-2016',2),

(1,'11-09-2016',1),

(1,'05-20-2016',3),

(2,'09-24-2017',1),

(1,'03-11-2017',2),

(1,'03-11-2016',1), (3,'11-10-2016',1),

(3,'12-07-2017',2),

(3,'12-15-2016',2),

(2,'11-08-2017',2), (2,'09-10-2018',3);

---***************************************************************************************************************************--

--------                       CREATE TABLE PRODUCT                            ------------------------------------------

CREATE TABLE product(product_id integer,product_name text,price integer);

---***************************************************************************************************************************--

---------                      INSERT VALUES IN OUR PRODUCT TABLE             -------------------------------------------
INSERT INTO product(product_id,product_name,price)

VALUES

(1,'p1',980), (2,'p2',870),

(3,'p3',330);

---***************************************************************************************************************************--

-------------                  DQL OPERATION (INORDER TO RETRIEVE DATA FROM THE TABLES IN DATABASE)   ----------------------
select * from sales;
select *from product;
select *from goldusers_signup;
select * from users;

---***************************************************************************************************************************--


---              1) TO SHOW USERS HOW MUCH THEY SPENT IN ZOMATO (WITHOUT PRODUCT_ID)        ----------------------------


select a.userid,sum(b.price) as totalamount  from
sales  a
inner join
product  b
on a.product_id=b.product_id
group by a.userid

----------------------          userid_1=5230 , useris_2=2510 and userid_3=4570           ------------------------------

--*****************************************************************************************************************************--

--------------------                2) 2.How many days has each customer visited ZOMATO                         -------------------------

select [userid],COUNT(distinct[created_date]) as distinct_days 
from sales
group by userid

------------------------    userid_1 = 7days , userid_2 = 4days , userid_3 = 5days        --------------------------

--****************************************************************************************************************************--

----------                     3.What was the first product purchased by each customer                           --------------------

select * from 
(select*,rank() over(partition by userid order by created_date) rnk 
from sales) a 
where rnk =1

--****************************************************************************************************************************--

------------------      4.What is the most purchased item on menu and how many times it was purchased by all the customers -------------------------


select product_id,COUNT(product_id) as_no_of_times_bought
from sales
group by product_id
order by count(product_id) desc;

----- product id 2,1,3 bought 7,5,4 times respectively (product id 2 has been bought more num of times as 7 times)------------

select top 1 product_id,COUNT(product_id) as_no_of_times_bought
from sales
group by product_id
order by count(product_id) desc;

------------------------------- complete detail of productid 2   ---------------------------------------------------------

select * from sales where product_id=
(select top 1 product_id
from sales
group by product_id
order by count(product_id) desc)

--------------------------------------------------------------------------------------------------------------------------

select userid,count(product_id) as count 
from sales
where product_id=(select top 1 product_id 
from sales 
group by product_id
order by count(product_id) desc)
group by userid

---**************************************************************************************************************************---


------------------------------5.Which item was the most popular for each customer----------------------------------------------
select* from
(select *,rank() over(partition by userid order by cnt desc) rnk from 
(select userid,product_id,count(product_id) as cnt 
from sales
group by userid,product_id)subquery;a)b 
where rnk=1

/* first i wrote the query 
                select userid,product_id,count(product_id) as cnt 
                from sales
                group by userid,product_id through which i got count of product id with user and product ID's

next i wrote the query
                select *,rank() over(partition by userid order by cnt desc) rnk from 
               (select userid,product_id,count(product_id) as cnt 
                from sales
                group by userid,product_id)subquery; through which i got the ranking of based on the count of product purchased 

finally i wrote a query
                select* from
               (select *,rank() over(partition by userid order by cnt desc) rnk from 
               (select userid,product_id,count(product_id) as cnt 
               from sales
               group by userid,product_id)subquery;a)b 
               where rnk=1 through which i got yo know which item was most popular for each member in database
*/








