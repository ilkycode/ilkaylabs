USE sakila;
SELECT actor_id, COUNT(film_id) AS total FROM film_actor
GROUP BY actor_id
ORDER BY total DESC
LIMIT 1;

SELECT  a.first_name, a.last_name , b.actor_id, COUNT(film_id) as totals
FROM actor a 
INNER JOIN film_actor b ON a.actor_id = b.actor_id
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;


#Most active customer (the customer that has rented the most number of films)

SELECT customer_id , COUNT(rental_id) as rental FROM rental
GROUP BY customer_id
ORDER BY rental DESC
LIMIT 1;

SELECT  a.first_name, a.last_name , b.customer_id, COUNT(rental_id) as rental
FROM customer a 
INNER JOIN rental b ON a.customer_id = b.customer_id
GROUP BY customer_id
ORDER BY rental DESC
LIMIT 1;

#List number of films per category.

SELECT a.category_id, a.name, COUNT(film_id) AS number_film
FROM category a
INNER JOIN film_category b
ON a.category_id = b.category_id
GROUP BY category_id
ORDER BY category_id;

#Display the first and last names, as well as the address, of each staff member.

SELECT a.first_name, a.last_name, b.address
FROM staff a
INNER JOIN address b
ON a.address_id = b.address_id;

#get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.

SELECT a.title, b.name
FROM film a
INNER JOIN `language` b
ON a.language_id = b.language_id
WHERE title LIKE "M%" AND name = "English" OR "italian" 
ORDER BY title DESC;

#Display the total amount rung up by each staff member in August of 2005.

SELECT a.staff_id, a.first_name, a.last_name, b.payment_date, b.amount
FROM staff a
INNER JOIN payment b
ON a.staff_id = b.staff_id
WHERE payment_date LIKE "2005-08%";

#List each film and the number of actors who are listed for that film.

SELECT  a.title , COUNT(actor_id) as totals
FROM film a 
INNER JOIN film_actor b ON a.film_id = b.film_id
GROUP BY title
ORDER BY totals DESC;

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT a.customer_id, a.first_name ,a.last_name, SUM(amount) as total
FROM customer a 
INNER JOIN payment b ON a.customer_id = b.customer_id
GROUP BY customer_id
ORDER BY last_name;


#Write sql statement to check if you can find any actor who never particiapted in any film.

SELECT  a.actor_id , COUNT(film_id) as totals
FROM film_actor a 
INNER JOIN film b ON a.film_id = b.film_id
GROUP BY actor_id;

#get the addresses that have NO customers, and ends with the letter "e"


SELECT a.address_id, a.first_name, a.last_name, b.payment_date, b.amount
FROM staff a
INNER JOIN payment b
ON a.address_id = b.address_id
WHERE address LIKE "%e";
