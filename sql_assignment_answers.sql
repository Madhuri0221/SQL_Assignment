

-- ===== From SQL_Assignment.ipynb =====

-- Basics

# 1. Create a table called employees with the following structure?
# a) emp_id (integer, should not be NULL and should be a primary key)
# b) emp_name (text, should not be NULL)
# c) age (integer, should have a check constraint to ensure the age is at least 8)
# d) email (text, should be unique for each employee)
# e) salary (decimal, with a default value of 30,000)
#  Write the SQL query to create the above table with all constraints.

'''
create database sample;
use sample;
create table employees (
emp_id int primary key not null,
emp_name varchar(50) not null,
age int check (age>=18),
email varchar(255) unique,
salary decimal(10,2) default 30000
);

''';

# 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints

"""
Constraints are the rules applied to columns or tables to ensure only valid and consistent data is stored in the database
They:
Prevent invalid data (e.g., age < 0).
Ensure uniqueness (e.g., no duplicate emails).
Maintain relationships between tables.
Enforce business rules automatically.

common types of constraints:
not null: eg - emp_name varchar(100) not null
primary key: eg - emp_id serial promary key
foreign key: eg - dept_id int references departments(dept_id)
unique: eg - email varchar(100) unique
check: eg - age int check (age>=18)
default and decimal: eg - salary decimal(10,2) default 30000

why decimal(10,2) - decimal takes 2 arguments p and s
where p is precision - total number of digits
s is scale - how many digits to be present after decimal

""";

# 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
# your answer.

"""
To make sure the column always has a value
when the fields are mandatory we cannot have null values
using not null there will be no missing values

eg: emp_name varchar(100) not null

Can a primary key contain NULL values?

no, a primary key has 2 definations: uniqueness and non null values
eg: emp_id serial primary key

""";

# 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
# example for both adding and removing a constraint.

"""
alter is used to add and remove constraints

to add constraint:
  alter table employees
  add constraint updated_emails unique(email)

to remove constraint:
  alter table employees
  drop index updated_emails

""";

# 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
# Provide an example of an error message that might occur when violating a constraint.

"""

insert into employees(emp_id, emp_name, age, email)
values (1,null,25,'john@gmail.com')

this throws an error: Column 'emp_name' cannot be null

INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'John', 25, 'john@email.com');

INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'Mary', 28, 'mary@email.com')

error: Duplicate entry '1' for key 'PRIMARY'

UPDATE employees
SET emp_name = NULL
WHERE emp_id = 1;

error: Column 'emp_name' cannot be null

Let’s say employees.dept_id references departments.dept_id

DELETE FROM departments
WHERE dept_id = 10;   -- But employees still linked to dept_id=10

error: Cannot delete or update a parent row: a foreign key constraint fails

""";

# 6. You created a products table without constraints as follows:

# CREATE TABLE products (

#     product_id INT,

#     product_name VARCHAR(50),

#     price DECIMAL(10, 2));

# Now, you realise that:
# : The product_id should be a primary key
# : The price should have a default value of 50.00

'''
alter table products
add constraint prod_id_constraint primary key (product_id);

alter table products
alter column price set default 50.00;

''';

# 7. You have two tables:
# Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

"""
select s.student_name, c.class_name
from students s
inner join classes c on c.class_id = s.class_id
group by s.student_id
order by 1

""";

# 8.Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
# listed even if they are not associated with an order

# Hint: (use INNER JOIN and LEFT JOIN)5


"""
use sample;
create table orders (
order_id int primary key,
order_date date not null,
customer_id int references customers(customer_id)
);

create table customers (
customer_id int primary key,
customer_name varchar(100) not null
);

create table products_new (
product_id int primary key,
product_name varchar(255) not null,
order_id int references orders(order_id)
);

insert into orders (order_id,order_date,customer_id)
values (1,'2024-01-01',101),
	   (2,'2024-01-03',102);

insert into customers (customer_id,customer_name)
values (101,'Alice'),
	   (102,'Bob');

insert into products_new (product_id,product_name,order_id)
values (1, 'Laptop', 1),
	(2, 'Phone', NULL);

select o.order_id, c.customer_name, p.product_name
from products_new p
left join orders o on o.order_id = p.order_id
left join customers c on c.customer_id = o.customer_id

""";

# 9. Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

"""
select p.product_name, sum(s.amount) as total_sales
from products p
join sales s on s.product_id = p.product_id
group by 1
order by 2 desc

""";

# 10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each
# customer using an INNER JOIN between all three tables.

"""
select o.order_id, c.customer_name, sum(od.quantity) as quantity_of_products_ordered
from orders o
join customers c on c.customer_id = o.customer_id
join order_details od on od.order_id = o.order_id
group by 1,2
order by 3 desc

""";

-- SQL Commands

# 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences

"""
Tables:

actor: actor_id is PK
actor_award: actor_award_id is PK
address: address_id is PK
advisor: advisor_id is PK

category: category_id is PK
city: city_id is PK
country: country_id is PK
customer: customer_id is PK

film: film_id is PK
film_actor: actor_id and film_id are PKs
film_category: film_id and category_id are PKs
film_text: film_id is PK

inventory: inventory_id is PK
investor: investor_id is PK


language: language_id is PK

payment: payment_id is PK

rental: rental_id is PK

staff: staff_id is PK
store: store_id is PK

"""
"""
Primary key defines uniqueness and non-null values
Foriegn key defines duplicate values

""";

# 2- List all details of actors

"""
select *
from actor a

""";

# 3 -List all customer information from DB.

"""
select *
from customer c
""";

# 4 -List different countries.

"""
select distinct(country)
from country

""";

# 5 -Display all active customers.

"""
select *
from customer c
where active = 1
""";

# 6 -List of all rental IDs for customer with ID 1.

"""
select *
from rental r
where customer_id = 1

""";

# 7 - Display all the films whose rental duration is greater than 5 .

"""
select *
from film f
where rental_duration > 5

""";

# 8 - List the total number of films whose replacement cost is greater than $15 and less than $20

"""
select count(*) as total_films
from film f
where replacement_cost > 15 and replacement_cost < 20;

""";

# 9 - Display the count of unique first names of actors.

"""
select count(distinct(a.first_name)) as unique_first_names
from actor a

""";

# 10- Display the first 10 records from the customer table .

"""
select *
from customer c
limit 10

""";

# 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

"""
select *
from customer c
where first_name like 'b%'
limit 3

""";

# 12 -Display the names of the first 5 movies which are rated as ‘G’.

"""
select f.title
from film f
where rating ='G'
limit 5

""";

# 13-Find all customers whose first name starts with "a".

"""
select *
from customer c
where first_name like 'a%'

""";

# 14- Find all customers whose first name ends with "a".

"""
select *
from customer c
where first_name like '%a'

""";

# 15- Display the list of first 4 cities which start and end with ‘a’

"""
select city
from city
where city like 'a%a'
limit 4;

""";

# 16- Find all customers whose first name have "NI" in any position.

"""
select *
from customer c
where first_name like '%ni%'

""";

# 17- Find all customers whose first name have "r" in the second position .

"""
select *
from customer c
where first_name like '_r%'

""";

# 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

"""
select *
from customer c
where first_name like 'a%' and length(first_name) >= 5

""";

# 19- Find all customers whose first name starts with "a" and ends with "o".

"""
select city
from city
where city like 'a%o'

""";

# 20 - Get the films with pg and pg-13 rating using IN operator.

"""
select *
from film f
where rating in ('PG','PG-13')

""";

# 21 - Get the films with length between 50 to 100 using between operator.

"""
select f.film_id, f.title, f.length
from film f
where f.length between 50 and 100

""";

# 22 - Get the top 50 actors using limit operator.

"""
select actor_id,first_name,last_name
from actor
limit 50;

""";

# 23 - Get the distinct film ids from inventory table.

"""
select distinct film_id
from inventory

""";

-- Functions

# Question 1:

# Retrieve the total number of rentals made in the Sakila database.

"""
select count(*) as total_rentals
from rental

""";

# Question 2:

# Find the average rental duration (in days) of movies rented from the Sakila database.

"""
select avg(rental_duration) as average_rental_duration
from film

""";

# Question 3:

# Display the first name and last name of customers in uppercase.

"""
select upper(first_name) as first_name, upper(last_name) as last_name
from customer

""";

# Question 4:

# Extract the month from the rental date and display it alongside the rental ID.

"""
select rental_id, rental_date, extract(month from rental_date) as rental_month
from rental

""";

# Question 5:

# Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

"""
select customer_id, count(rental_id) as number_of_rentals
from rental
group by 1
order by 2 desc

""";

# Question 6:

# Find the total revenue generated by each store.

"""
select s.store_id, sum(p.amount) as total_revenue
from customer c
join store s on s.store_id = c.store_id
join payment p on p.customer_id = c.customer_id
group by 1
order by 2 desc

""";

# Question 7:

# Determine the total number of rentals for each category of movies

"""
select fc.category_id, c.name as category_name, count(r.rental_id) as number_of_rentals_per_category
from film_category fc
join category c on c.category_id = fc.category_id
join inventory i on i.film_id = fc.film_id
join rental r on r.inventory_id = i.inventory_id
group by 1,2
order by 3 desc

""";

# Question 8:

# Find the average rental rate of movies in each language.

'''
select l.language_id, avg(f.rental_rate) as average_rental_rate_per_language
from language l
join film f on f.language_id = l.language_id
group by 1

''';

-- Joins

# Questions 9 -

# Display the title of the movie, customer s first name, and last name who rented it

'''
select  distinct f.title, c.first_name, c.last_name
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
where r.rental_id is not null

''';

# Question 10:

# Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

'''
The film table has only "Gone Trouble" title

select film_id, title
from film
where title like 'Gone%'

or

select film_id, title
from film
where title like 'g%d'

so there will be no rows fetched from below query

select a.first_name, f.title
from film_actor fa
join film f on f.film_id = fa.film_id
join actor a on a.actor_id = fa.actor_id
where f.title = 'Gone with the Wind';

''';

# Question 11:

# Retrieve the customer names along with the total amount they've spent on rentals

'''
select c.customer_id, c.first_name, sum(p.amount) as total_amount_spent_on_rentals
from customer c
join payment p on p.customer_id = c.customer_id
group by 1
order by 3 desc

''';

# Question 12:

# List the titles of movies rented by each customer in a particular city (e.g., 'London').

'''
select c.customer_id, c.first_name, cy.city, GROUP_CONCAT(DISTINCT f.title ORDER BY f.title SEPARATOR ', ') AS movies_rented
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
join address a on a.address_id = c.address_id
join city cy on cy.city_id = a.city_id
where cy.city = 'London'
group by 1,2,3

''';

Advanced joins and group by

# Question 13:

# Display the top 5 rented movies along with the number of times they've been rented

'''
select f.title, count(r.rental_id) as number_of_times_movie_rented
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by 1
order by 2 desc
limit 5

''';

# Question 14:

# Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

'''
select c.customer_id, c.first_name, c.last_name
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id
join store s on s.store_id = i.store_id
where s.store_id in (1,2)
group by 1,2,3
having count(distinct s.store_id) = 2

''';

-- Window functions

# 1. Rank the customers based on the total amount they've spent on rentals.

'''
with cte1 as (select c.customer_id, c.first_name, sum(p.amount) as total_amount_spent_on_rentals
from customer c
join payment p on p.customer_id = c.customer_id
group by 1,2
)
select *,
rank() over(order by total_amount_spent_on_rentals desc) as rnk
from cte1

''';

# 2. Calculate the cumulative revenue generated by each film over time.

'''
select
    f.film_id,
    f.title,
    r.rental_date,
    sum(p.amount) as revenue_for_rental,
    sum(sum(p.amount)) over (
        partition by f.film_id
        order by r.rental_date
        rows between unbounded preceding and current row
    ) as cumulative_revenue
from payment p
join rental r on r.rental_id = p.rental_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
group by f.film_id, f.title, r.rental_date
order by f.film_id, r.rental_date;

''';

# 3. Determine the average rental duration for each film, considering films with similar lengths

'''
select f.film_id, f.title, f.length as moive_length, avg(datediff(r.return_date,rental_date)) as rental_duration
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
where r.return_date is not null
group by 1,2,3
order by 4 desc

''';

# 4. Identify the top 3 films in each category based on their rental counts.

'''
select c.category_id, c.name as category_name, count(r.rental_id) as rental_counts
from category c
join film_category fc on fc.category_id = c.category_id
join film f on f.film_id = fc.film_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by 1,2
order by 3 desc
limit 3

''';

# 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals

# across all customers.

'''
with cte1 as (select c.customer_id, c.first_name, count(r.rental_id) as total_rental_counts
from customer c
join rental r on r.customer_id = c.customer_id
group by 1,2
order by 3 desc),
cte2 as (select avg(total_rental_counts) as avg_rental_count
from cte1)
select cte1.customer_id, cte1.first_name, cte1.total_rental_counts, cte2.avg_rental_count, cte1.total_rental_counts - cte2.avg_rental_count as diff_in_rental_counts
from cte1
cross join cte2
order by diff_in_rental_counts desc

''';

# 6. Find the monthly revenue trend for the entire rental store over time.

'''
select date_format(p.payment_date, '%m') as 'month', sum(p.amount) as total_revenue
from payment p
group by 1
order by 2

''';

# 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

'''
with cte1 as (select c.customer_id, c.first_name, sum(p.amount) as total_spending
from payment p
join customer c on p.customer_id = c.customer_id
group by 1,2),
cte2 as (select cte1.*, percent_rank() over(order by total_spending desc) pr
from cte1)
select customer_id, first_name, total_spending, pr
from cte2
where pr <= 0.2
order by 3 desc

''';

# 8. Calculate the running total of rentals per category, ordered by rental count.

'''
with cte1 as (select c.category_id, c.name as category_name, count(r.rental_id) as total_rental_count
from category c
join film_category fc on fc.category_id = c.category_id
join inventory i on i.film_id = fc.film_id
join rental r on r.inventory_id = i.inventory_id
group by 1,2)
select *, sum(total_rental_count) over(order by total_rental_count desc) as running_total
from cte1
order by total_rental_count desc

''';

# 9. Find the films that have been rented less than the average rental count for their respective categories.

'''
with cte1 as (select c.name as category_name, f.title, count(r.rental_id) as count_of_rentals_for_each_category
from film_category fc
join category c on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by 1,2),
cte2 as (select category_name, avg(count_of_rentals_for_each_category) as average_count_of_rentals
from cte1
group by 1)
select cte1.category_name, cte1.title, cte1.count_of_rentals_for_each_category, cte2.average_count_of_rentals
from cte1
join cte2 on cte2.category_name = cte1.category_name
where cte1.count_of_rentals_for_each_category < cte2.average_count_of_rentals
order by 1,3

''';

# 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

'''
select date_format(p.payment_date, '%m-%Y'), sum(p.amount) as month_wise_total_revenue
from payment p
group by 1
order by 2 desc
limit 5

''';

-- Normalization and CTE

# 1. First Normal Form (1NF):

#  a. Identify a table in the Sakila database that violates 1NF. Explain how you

#  would normalize it to achieve 1NF

'''
All attributes contain atomic values ie., only 1 value
No repeating groups or arrays.
Each row-column intersection has a single value.

'''

'''
create table film_special_feature (
    film_id smallint unsigned not null,
    feature varchar(50) not null,
    constraint fk_film_special_feature
        foreign key (film_id) references film(film_id)
);

insert into film_special_feature (film_id, feature)
values
(1, 'Trailers'),
(1, 'Deleted Scenes'),
(2, 'Trailers'),
(2, 'Commentaries');

select f.title, fsf.feature
from film f
join film_special_feature fsf on f.film_id = fsf.film_id;

''';

# 2. Second Normal Form (2NF):

#  a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.

#  If it violates 2NF, explain the steps to normalize it

'''
1NF : No repeating groups, atomic values only.
2NF :
Table must already be in 1NF.
Every non-key column must depend on the entire Primary Key (PK).
If PK is a single column, you’re safe (can’t violate 2NF, because no “partial dependency” exists).
If PK is a composite key (made of 2+ columns), you must check carefully.

film_actor (film_id, actor_id, actor_name)

PK = (film_id, actor_id)
actor_name depends only on actor_id (part of PK, not the whole PK).
This violates 2NF.

film_actor (film_id, actor_id)   : composite PK
actor (actor_id, actor_name)     : actor_name depends only on actor_id

So yes, the golden rule:
One PK per table.
All other attributes must depend completely on that PK, not part of it.

''';

# 3. Third Normal Form (3NF):

#  a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies

#  present and outline the steps to normalize the table to 3NF.

'''
In the Sakila database, the customer table violates 3NF because of transitive dependencies.
For example, customer_id determines address_id, which in turn determines city_id and country_id.
Thus, non-key attributes like city and country are indirectly dependent on customer_id.

To normalize into 3NF, we separate address, city, and country into their own tables
and reference them via foreign keys. This eliminates transitive dependencies and
ensures that all non-key attributes depend only on the primary key.

Step 1: Check if in 2NF
PK = customer_id (single column).
All attributes depend fully on customer_id. So 2NF is satisfied.

Step 2: Check for 3NF

Rule: No transitive dependencies : non-key attributes should not depend on other
non-key attributes.

Here’s the issue:
customer_id → address_id → city_id → country_id
That means:
city depends on city_id (not directly on customer_id).
country depends on country_id (again, not directly on customer_id).
These are transitive dependencies : violates 3NF.

''';

# 4. Normalization Process:

#  a. Take a specific table in Sakila and guide through the process of normalizing it from the initial

#  unnormalized form

'''
customer_table:
customer_id	first_name	last_name	rental_id	rental_date	rental_time	  film_title	    rental_duration	rental_rate
1	          MARY	        SMITH	    76	    2005-05-24	22:53:30	  ACADEMY DINOSAUR	  6	              0.99
1	          MARY	        SMITH	    1383	  2005-05-27	09:21:49	  GANGS OF LEBANON	  6	              0.99
2         	PATRICIA	    JOHNSON	  76	    2005-05-24	22:53:30	  ACADEMY DINOSAUR	  6	              0.99
2	          PATRICIA	    JOHNSON	  973	    2005-05-26	07:44:23	  GLADIATOR WESTWARD	6	              0.99
3	          LINDA	        WILLIAMS	988	    2005-05-26	08:29:56	  GLADIATOR WESTWARD	6               0.99

1NF: All columns follow atomic nature and there are no repeated groups or arrays
2NF: first_name and last_name depend on customer_id (PK) rental_date, rental_time, film_title are depenent on rental_id - violates 2NF

so, we create a new table called rentals and have a relation with customer table via customer_id

rental_table:
rental_id	rental_date	rental_time	film_title	    rental_duration	rental_rate	customer_id
76	      2005-05-24	22:53:30	ACADEMY DINOSAUR	      6	            0.99	      1
1383	    2005-05-27	09:21:49	GANGS OF LEBANON	      6	            0.99	      1
973	      2005-05-26	07:44:23	GLADIATOR WESTWARD	    6	            0.99	      2
988	      2005-05-26	08:29:56	GLADIATOR WESTWARD	    6	            0.99	      3

now, this is how the customer table looks like:

latest_customer_table:
customer_id	first_name	  last_name
1	            MARY	        SMITH
2	            PATRICIA	    JOHNSON
3	            LINDA	        WILLIAMS

3NF: in rental_table, though if the film_title is not a key, rental_duration and rental_rate are dependent on film_title
     creates a transitive dependency (indirect dependency) ie., rental_duration and rental_rate are indirectly dependent on rental_id via film_title
     so film_title comes under 3NF and not 2NF

latest_rental_table:
rental_id	rental_date	rental_time	customer_id	film_id
76	      2005-05-24	22:53:30	        1	      1
1383	    2005-05-27	09:21:49	        1	      2
973	      2005-05-26	07:44:23	        2	      3
988	      2005-05-26	08:29:56	        3	      3

film_table:
film_id	film_title	      rental_duration	rental_rate
1	      ACADEMY DINOSAUR	      6	          0.99
2	      GANGS OF LEBANON	      6	          0.99
3	      GLADIATOR WESTWARD	    6	          0.99

film_table and rental_table are joined via film_id
rental_table and customer_table are joined via customer_id

''';

# 5. CTE Basics:

#  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they

#  have acted in from the actor

'''
with actors as (
select a.actor_id, a.first_name, a.last_name
from actor a
),
acted_films as (
select fa.actor_id, count(fa.film_id) as acted_films_count
from film_actor fa
group by 1
)
select acts.actor_id, first_name, last_name, acted_films_count
from actors acts
join acted_films af on af.actor_id = acts.actor_id
order by 4 desc

''';

# 6. CTE with Joins:

#  a. Create a CTE that combines information from the film and language tables to display the film title,

#  language name, and rental rate.

'''
with cte1 as (
select f.title, f.rental_rate, f.language_id
from film f
)
select title, l.name as language_name, rental_rate
from language l
join cte1 on l.language_id = cte1.language_id
order by 3 desc

''';

# 7.CTE for Aggregation:

#  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)

#  from the customer and payment tables.

'''
with customer_info as (
select c.customer_id, c.first_name, c.last_name
from customer c
)
select p.customer_id, first_name, last_name, sum(p.amount) as customer_wise_total_revenue_made
from payment p
join customer_info ci on ci.customer_id = p.customer_id
group by 1,2,3
order by 4 desc

''';

# 8.CTE with Window Functions:

#  a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

'''
with ranking_films_based_on_rental_duration as (
select f.film_id, f.title, f.rental_duration, dense_rank() over(order by rental_duration desc) as rnk
from film f
)
select *
from ranking_films_based_on_rental_duration
order by rnk, title

''';

# 9. CTE and Filtering:

#  a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the

#  customer table to retrieve additional customer details.

'''
with customers_rental_count as (
select r.customer_id, count(r.rental_id) as rental_counts_per_customer
from rental r
group by 1
)
select c.*, rental_counts_per_customer
from customer c
join customers_rental_count crc on crc.customer_id = c.customer_id
where rental_counts_per_customer > 2
order by rental_counts_per_customer

''';

# 10. CTE for Date Calculations:

#  a. Write a query using a CTE to find the total number of rentals made each month, considering the

#  rental_date from the rental table

'''
with month_wise_rental_count as (
select date_format(r.rental_date, '%m-%Y') as month_year, count(r.rental_id) as rental_count
from rental r
group by 1
)
select *
from month_wise_rental_count
order by rental_count desc

''';

# 11. CTE and Self-Join:

#  a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film

#  together, using the film_actor table.

'''
with actor_pairs as (
    select
        fa1.film_id,
        fa1.actor_id as actor1_id,
        fa2.actor_id as actor2_id
    from film_actor fa1
    join film_actor fa2
        on fa1.film_id = fa2.film_id
       and fa1.actor_id < fa2.actor_id
)
select
    ap.film_id,
    a1.first_name as actor1_first,
    a1.last_name as actor1_last,
    a2.first_name as actor2_first,
    a2.last_name as actor2_last
from actor_pairs ap
join actor a1 on ap.actor1_id = a1.actor_id
join actor a2 on ap.actor2_id = a2.actor_id
order by ap.film_id, actor1_first, actor2_first;

''';

# 12. CTE for Recursive Search:

#  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,

#  considering the reports_to column

'''
with recursive staff_hierarchy as (
    -- Anchor member: start with the chosen manager
    select
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    from staff s
    where s.staff_id = 1   -- replace with manager_id you want to search

    union all

    -- Recursive member: find employees reporting to current staff
    select
        e.staff_id,
        e.first_name,
        e.last_name,
        e.reports_to
    from staff e
    inner join staff_hierarchy sh on e.reports_to = sh.staff_id
)
select *
from staff_hierarchy;

''';

