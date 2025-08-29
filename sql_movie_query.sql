CREATE TABLE movies (
id INT PRIMARY KEY,
movie VARCHAR(255),
description VARCHAR(255),
rating DECIMAL(3,1)
);

select * from movies

INSERT INTO movies (id, movie, description, rating) VALUES
(1, 'War', 'thriller', 8.9),
(2, 'Dhakkad', 'action', 2.1),
(3, 'Gippi', 'boring', 1.2),
(4, 'Dangal', 'wrestling', 8.6),
(5, 'P.K.', 'Sci-Fi', 9.1);

select * from movies

-- Qus 1 )) Write an SQL query to report the movies with an odd-numbered ID and a description that is not"boring".
--Return the result table ordered by rating in descending order.

select * from movies
where id  %2 = 1
and description != 'boring'
order by rating desc;

--another method

select * from movies
where id  %2 = 1
and description <> 'boring'
order by rating desc;

-- another method

select * from movies
where mod(id , 2 )= 1
and description != 'boring'
order by rating desc;




