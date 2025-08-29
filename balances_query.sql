create table users (
Account int primary key,
Names varchar(50) not null
)
ALTER TABLE users 
RENAME COLUMN account TO account_number;

select * from users

insert into users(account,names) 
values

(12300001, 'Ram'),
(12300002, 'Tim'),
(12300003, 'Shyam');

select * from users

create table transaction(
trans_id int,
account_number int,
amount decimal(10,2),
transaction_on date);
)

--update table name 
ALTER TABLE transaction RENAME TO transactions;

select * from transactions

insert into transactions(trans_id,account_number,amount,transaction_on)
values
(1, 12300001, 8000, '2022-03-01'),
(2, 12300001, 8000, '2022-03-01'),
(3, 12300001, -3000, '2022-03-02'),
(4, 12300002, 4000, '2022-03-12'),
(5, 12300003, 7000, '2022-02-07'),
(6, 12300003, 7000, '2022-03-07'),
(7, 12300003, -4000, '2022-03-11');

select * from transactions

-- Qus )) Construct a SQL query to display the names and balances of people who have a balance
--greater than $10,000. The balance of an account is equal to the sum of the amounts of all
--transactions involving that account. You can return the result table in any order.

select u.names ,sum(amount)  
from users u join
transactions t
on u.account_number = t.account_number
group by u.names 
having sum(amount) > 10000

-- another method

SELECT u.names, 
       SUM(t.amount) AS balance
FROM users u
JOIN transactions t
  ON u.account_number = t.account_number
GROUP BY u.names
HAVING SUM(t.amount) > 10000
ORDER BY balance DESC;

