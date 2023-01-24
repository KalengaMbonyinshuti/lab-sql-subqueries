USE SAKILA;
/*
1.How many copies of the film Hunchback Impossible exist in the inventory system?
*/
SELECT f.title, count(*) from sakila.inventory as i right join sakila.film as f 
on f.last_update = i.last_update where (f.title ="Hunchback Impossible");

/*2. List all films whose length is longer than the average of all the films*/

select avg(length) from sakila.film group by length 
having avg(length)>(select avg(length) from sakila.film);


/*3. Use subqueries to display all actors who appear in the film Alone Trip.
*/
select* from (select a.first_name, a.last_name, title from sakila.film as
 f left join sakila.actor as a on  a.last_update=f.last_update group by a.first_name, a.last_name, title)  as sub1
WHERE title = 'Alone Trip';

/*4. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
 Identify all movies categorized as family films.
*/
select f.title from sakila.film as f left join sakila.category as c on 
c.last_update = f.last_update group by f.title;

/*
5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
Note that to create a join, you will have to identify the correct tables with their primary
 keys and foreign keys, that will help you get the relevant information.
*/
select co.country, cu.first_name, cu.last_name from sakila.customer as cu right join sakila.country as co on
 co.last_update = cu.last_update where country='canada';
 
/*
6. Which are films starred by the most prolific actor? Most prolific actor  is defined as the actor that has 
acted in the most number of films. First you will  have to find the most prolific actor and then 
use that actor_id to find the different films that he/she starred.
*/

SELECT count(a.first_name ) from sakila.film as f left join sakila.actor as a on
 f.last_update =a.last_update group by a.first_name having count(a.first_name) ='1';
 

/*
7. Films rented by most profitable customer. You can use the customer table and payment table to find the most
 profitable customer ie the customer that has made the largest sum of payments
*/

SELECT SUM(amount), CONCAT(first_name,' ',last_name) FROM sakila.customer
JOIN sakila.payment USING (customer_id)
GROUP BY customer_id
HAVING sum(amount) > (SELECT avg(total_payment) FROM (
SELECT customer_id, SUM(amount) as total_payment FROM sakila.payment
GROUP BY customer_id) sub1)
ORDER BY SUM(amount) DESC;
