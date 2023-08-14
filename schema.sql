CREATE DATABASE IF NOT EXISTS `schema`;
USE `schema`;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	`email` varchar(20) not null,
	`firstName` varchar(20) not null,
    `lastName` varchar(20) not null,
    `username` varchar(20) not null,
    `password` varchar(20) not null,
    primary key(`username`)
);

INSERT INTO users(`email`, `firstName`, `lastName`, `username`, `password`) VALUES 
    ('yo@yahoo.com', 'abc', 'def', 'user0', 'pass0');
    
SELECT * FROM users WHERE `username`= 'user0' AND `password` = 'pass0';
INSERT INTO users(`email`, `firstName`, `lastName`, `username`, `password`) VALUES
    ('go@google.com', 'john', 'deoe', 'user1', 'pass1');

SELECT * FROM users;
    
    