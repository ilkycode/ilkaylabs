USE sakila;
SELECT title AS Film_Title FROM sakila.film;

SELECT DISTINCT name AS language FROM sakila.language;

SELECT COUNT(store_id) FROM sakila.store;

SELECT COUNT(staff_id) FROM sakila.staff;

SELECT first_name FROM sakila.staff;