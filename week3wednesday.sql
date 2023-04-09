#List all films whose length is longer than the average of all the films.
use sakila;
SELECT title FROM film
WHERE length > (SELECT AVG(length) FROM film);

#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, COUNT(inventory_id) FROM film
INNER JOIN inventory inventory ON film.film_id = inventory.film_id
GROUP BY title
HAVING title = "Hunchback Impossible" ;

SELECT count(inventory_id) FROM inventory 
           WHERE film_id IN (
               SELECT film_id
               FROM film
               WHERE title = "Hunchback Impossible");


#Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name FROM actor 
WHERE actor_id IN (SELECT actor_id FROM film_actor 
            WHERE film_id IN (SELECT film_id FROM film
              WHERE title = 'Alone Trip'));

#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title FROM film 
WHERE film_id IN (SELECT film_id FROM film_category 
            WHERE category_id IN (SELECT category_id FROM category
              WHERE name = 'Family'));

#Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.


SELECT first_name, last_name, email FROM customer 
WHERE address_id IN (SELECT address_id FROM address 
            WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (
            SELECT country_id FROM country
              WHERE country = 'Canada')));

#JOIN

SELECT a.first_name, a.last_name, a.email 
FROM customer a 
INNER JOIN address b ON a.address_id = b.address_id 
INNER JOIN city c ON c.city_id = b.city_id 
INNER JOIN country d ON d.country_id = c.country_id
WHERE country = 'Canada'
GROUP BY a.first_name, a.last_name, a.email;

#optional
#Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT title FROM film WHERE film_id IN(
SELECT film_id FROM film_actor WHERE actor_id IN(
SELECT actor_id, COUNT(film_id) as profilic from film_actor
GROUP BY actor_id
ORDER BY profilic DESC
LIMIT 1));


SELECT title FROM film
WHERE film_id IN (
SELECT film_id FROM film_actor
WHERE actor_id = '107');


#Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT title FROM film WHERE film_id IN (
  SELECT film_id FROM inventory WHERE inventory_id IN (
    SELECT inventory_id FROM rental WHERE customer_id IN (
      SELECT customer_id FROM payment
       GROUP BY customer_id
         ORDER BY SUM(amount) DESC)));
         
#Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).

SELECT first_name, last_name FROM customer WHERE customer_id IN(
 SELECT customer_id FROM payment 
  GROUP BY customer_id
   HAVING SUM(amount) > (SELECT (SUM(amount) / COUNT(DISTINCT(customer_id))) FROM payment));
