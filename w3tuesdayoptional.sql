USE sakila;

#Write a query to display for each store its store ID, city, and country.

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

#Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id , SUM(amount) as dollars
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON payment.staff_id = staff.staff_id
GROUP BY store_id;


#What is the average running time(length) of films by category?

SELECT category.category_id , category.name , AVG(length) as avglen
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film.film_id = film_category.film_id
GROUP BY category_id;

#Which film categories are longest(length) (find Top 5)? (Hint: You can rely on question 3 output.)

SELECT category.category_id , category.name , AVG(length) as avglen
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film.film_id = film_category.film_id
GROUP BY category_id
ORDER BY avglen DESC
LIMIT 5;

#Display the top 5 most frequently(number of times) rented movies in descending order.

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;

#List the top five genres in gross revenue in descending order.

SELECT category.category_id , category.name , SUM(amount) as sumamount
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film.film_id = film_category.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category_id
ORDER BY sumamount DESC
LIMIT 5;


#Is "Academy Dinosaur" available for rent from Store 1?

SELECT store.store_id , film.title
FROM store
JOIN inventory ON store.store_id = inventory.store_id
JOIN film ON film.film_id = inventory.film_id
WHERE film.title = "Academy Dinosaur" AND store.store_id = "1";
#yes 4 of them are available