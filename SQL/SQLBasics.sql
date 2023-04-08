use bank;
SELECT client_id,district_id FROM bank.client
WHERE district_id = 1
LIMIT 5;

SELECT client_id,district_id FROM bank.client
WHERE district_id = 72
ORDER BY client_id DESC
LIMIT 5;

SELECT amount FROM bank.loan
ORDER BY amount 
LIMIT 3;

SELECT DISTINCT status FROM bank.loan
ORDER BY status;

SELECT loan_id, payments FROM bank.loan
ORDER BY payments DESC
LIMIT 1;

SELECT account_id, amount FROM bank.loan
ORDER BY account_id
LIMIT 5;

SELECT account_id, amount FROM bank.loan
WHERE duration=60
ORDER BY amount
LIMIT 5;

SELECT DISTINCT k_symbol FROM `order`;


#In the `order` table, what are the `order_id`s of the client with the `account_id` 34?
SELECT order_id FROM `order`
WHERE account_id = 34;

#In the `order` table, which `account_id`s were responsible for orders between `order_id` 29540 and `order_id` 29560 (inclusive)?
SELECT DISTINCT account_id FROM `order`
WHERE order_id >= 29540 AND order_id <= 29560;

#In the `order` table, what are the individual amounts that were sent to (`account_to`) id 30067122?
SELECT amount FROM `order`
WHERE account_to = 30067122;

#In the `trans` table, show the `trans_id`, `date`, `type` and `amount` of the 10 first transactions from `account_id` 793 in chronological order, from newest to oldest.
SELECT trans_id, date, type, amount FROM bank.trans
WHERE account_id = 793
ORDER BY date DESC
LIMIT 10;

#In the `client` table, of all districts with a `district_id` lower than 10, how many clients are from each `district_id`? Show the results sorted by the `district_id` in ascending order.

SELECT district_id, COUNT(district_id) FROM bank.client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id;

#In the `card` table, how many cards exist for each `type`? Rank the result starting with the most frequent `type`.

SELECT type, COUNT(type) FROM bank.card
GROUP BY type
ORDER BY COUNT(type) DESC;

#Using the `loan` table, print the top 10 `account_id`s based on the sum of all of their loan amounts.
SELECT account_id, amount FROM loan
ORDER BY amount
LIMIT 10;


#In the `loan` table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

SELECT COUNT(loan_id), date FROM loan
WHERE date < 930907
GROUP BY date
ORDER BY date DESC;

#In the `loan` table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

SELECT DISTINCT duration, date FROM loan
WHERE date LIKE "9712%"
ORDER BY duration,date;

#In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

SELECT account_id, type, SUM(amount) as total_amount FROM trans 
WHERE account_id = 396
GROUP BY type
Order by type;

#From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

ALTER TABLE trans 
RENAME COLUMN type TO transaction_type;

UPDATE trans
SET transaction_type = REPLACE(transaction_type,'VYDAJ','OUTGOING');
UPDATE trans
SET transaction_type = REPLACE(transaction_type,'PRIJEM','INCOMING');

SELECT account_id, transaction_type FROM trans;

#From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.

ALTER TABLE trans ADD incoming int(15);

UPDATE  trans
SET     incoming = amount
WHERE transaction_type = 'INCOMING';

ALTER TABLE trans ADD outgoing int(15);

UPDATE  trans
SET     outgoing = amount
WHERE transaction_type = 'OUTGOING';

SELECT * FROM trans;

SELECT account_id, SUM(incoming) as inco, SUM(outgoing) as outgo FROM trans
WHERE account_id = 396;
