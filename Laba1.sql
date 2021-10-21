CREATE DATABASE `Library`;
USE `Library`;
CREATE TABLE `Autor`(
    `id` int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `autor_name` char(120),
    `birthday` date,
    `death_date` date
    );
CREATE TABLE `Genre`(
    `id` int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name_genre` char(50),
    );
CREATE TABLE `Books` (
    `id` int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name_book` char(50),
    `description` text,
    `release_date` date,
    `autor_id` int UNSIGNED NOT NULL,
    CONSTRAINT `autor_id` FOREIGN KEY(`autor_id`) REFERENCES `Autor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    `genre_id` int UNSIGNED NOT NULL,
    CONSTRAINT `genre_id` FOREIGN KEY(`genre_id`) REFERENCES `Genre`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO `genre` (`name_genre`) VALUES ("Detective");
INSERT INTO `genre` (`name_genre`) VALUES ("Romance");
INSERT INTO `genre` (`name_genre`) VALUES ("Fantasy");

INSERT INTO `autor` (`autor_name`, `birthday`, `death_date`) VALUES ("Agatha Christie","1890-09-15","1976-01-12");
INSERT INTO `autor` (`autor_name`, `birthday`, `death_date`) VALUES ("Lev Tolstoy","1828-09-09","1910-11-20");
INSERT INTO `autor` (`autor_name`, `birthday`, `death_date`) VALUES ("Hans Andersen","1805-04-02","1875-08-04");
INSERT INTO `autor` (`autor_name`, `birthday`) VALUES ("Ernest Cline","1972-03-29");

INSERT INTO `books` (`name_book`, `description`, `release_date`, `autor_id`, `genre_id`) VALUES ("Murder alphabetically","One of the most significant novels by Agatha Christie","1936-01-01",1,1);
INSERT INTO `books` (`name_book`, `description`, `release_date`, `autor_id`, `genre_id`) VALUES ("War and Piece","A novel describing Russian society during the era of wars against Napoleon","1867-03-24",2,2);
INSERT INTO `books` (`name_book`, `description`, `release_date`, `autor_id`, `genre_id`) VALUES ("Mermaid","A book about a young mermaid and her choice","1837-04-07",3,3);
INSERT INTO `books` (`name_book`, `description`, `release_date`, `autor_id`, `genre_id`) VALUES ("Ready Player One","A sci-fi novel by a screenwriter about the dystopia of the future world","2011-08-16",4,3);
INSERT INTO `books` (`name_book`, `description`, `release_date`, `autor_id`, `genre_id`) VALUES ("Devil","Tolstoy's tale of the irresistible power of sensual love","1911-05-11",2,2);


SELECT `name_book`, `release_date`, `name_genre` FROM `books`, `genre`
WHERE `release_date` > '1990.01.01' AND `genre`.`id` = `Books`.`genre_id`;

SELECT DISTINCT autor_name, COUNT(DISTINCT name_book) FROM `books`
JOIN `autor` ON `autor`.`id` = `books`.`autor_id`
GROUP BY `autor_id`;

SELECT DISTINCT `name_book`, `release_date` FROM `books`, `autor`
WHERE `autor_id` = 1
ORDER BY `release_date` DESC;

INSERT INTO `genre`
VALUES(4, 'Comedy');
INSERT INTO `genre`
VALUES(5, 'Adventures');
SELECT DISTINCT `name_genre`, `name_book` FROM `genre`
LEFT JOIN `books` ON `genre`.`id` = `books`.`genre_id`
ORDER BY `name_genre`;

SELECT `name_book`, `autor_name`, `name_genre` FROM `genre`, `books`, `autor`
WHERE `autor`.`id` = `books`.`autor_id` AND `books`.`genre_id` = `genre`.`id`;

SELECT `autor_name` FROM `autor`, `genre`, `books`
WHERE `autor`.`id` = `books`.`autor_id` AND `books`.`genre_id` = `genre`.`id` AND `name_genre` = 'Fantasy'
GROUP BY `autor_name`, `name_genre`;

SELECT `autor_name` FROM `autor`, `books`
WHERE `autor`.`id` = `books`.`autor_id` AND `name_book` = 'Mermaid';

SELECT `name_genre` FROM `genre`
LEFT JOIN `books` ON `genre`.`id` = `books`.`genre_id`
WHERE `books`.`genre_id` IS NULL
GROUP BY `name_genre`;

SELECT `name_book`, `description` FROM `books`, `autor`
WHERE `autor`.`id` = `books`.`autor_id` AND `birthday` Between '1901.01.01' AND '2000.12.31';

SELECT DATEDIFF(MAX(`release_date`), MIN(`release_date`)) / 365 AS `Разница между первой и последней книгой Льва Толстого в годах:` FROM `books`
WHERE `autor_id` = 2;

SELECT `autor_name` FROM `autor`
WHERE `autor_name` LIKE 'E%' AND `birthday` BETWEEN '1972.01.01' AND '1972.12.31';

CREATE VIEW zapros_9 
AS SELECT `autor_name` FROM `autor`
WHERE `autor_name` LIKE 'E*' OR `birthday` BETWEEN '1901.01.01' AND '2000.12.31';
SELECT * FROM `zapros_9`
WHERE `autor_name` LIKE 'E%';

UPDATE `books`
SET `release_date` = '1978-04-25'
WHERE `name_book` = 'War and Piece';

DELETE `books`.* FROM `books`, `genre`
WHERE `books`.`genre_id` = `genre`.`id` AND `name_genre` = 'Detective';