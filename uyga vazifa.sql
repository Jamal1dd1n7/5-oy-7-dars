DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS book_reviews;

CREATE TABLE IF NOT EXISTS authors(
	author_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS publishers(
	publisher_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    founded_year INT CHECK(founded_year > 0)
);

CREATE TABLE IF NOT EXISTS books(
	book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT REFERENCES authors(author_id) ON DELETE CASCADE,
    publisher_id INT REFERENCES publishers(publisher_id) ON DELETE SET NULL,
    genre VARCHAR(50) NOT NULL,
    publish_date DATE NOT NULL,
    price NUMERIC(10, 2) CHECK(price >= 0)
);

CREATE TABLE IF NOT EXISTS book_reviews(
	comment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INT REFERENCES books(book_id) ON DELETE CASCADE,
    review_text TEXT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review_date DATE NOT NULL
);

INSERT INTO authors (name, birth_date, country) VALUES
('J.K. Rowling', '1965-07-31', 'United Kingdom'),
('George Orwell', '1903-06-25', 'United Kingdom'),
('F. Scott Fitzgerald', '1896-09-24', 'United States'),
('Jane Austen', '1775-12-16', 'United Kingdom'),
('Mark Twain', '1835-11-30', 'United States');

INSERT INTO publishers (name, city, founded_year) VALUES
('Penguin Random House', 'New York', 1927),
('HarperCollins', 'New York', 1989),
('Oxford University Press', 'Oxford', 1586),
('Macmillan Publishers', 'London', 1843),
('Scholastic', 'New York', 1920);

INSERT INTO books (title, author_id, publisher_id, genre, publish_date, price) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 5, 'Fantasy', '1997-06-26', 29.99),
('1984', 2, 3, 'Dystopian', '1949-06-08', 19.99),
('The Great Gatsby', 3, 2, 'Novel', '1925-04-10', 15.99),
('Pride and Prejudice', 4, 1, 'Romance', '1813-01-28', 12.99),
('Adventures of Huckleberry Finn', 5, 4, 'Adventure', '1885-12-10', 18.99),
('Animal Farm', 2, 3, 'Satire', '1945-08-17', 9.99),
('Emma', 4, 1, 'Romance', '1815-12-23', 14.99),
('The Catcher in the Rye', 3, 2, 'Novel', '1951-07-16', 17.99),
('The Adventures of Tom Sawyer', 5, 4, 'Adventure', '1876-06-01', 13.99),
('Fantastic Beasts and Where to Find Them', 1, 5, 'Fantasy', '2001-03-01', 24.99);

INSERT INTO book_reviews (book_id, review_text, rating, review_date) VALUES
(1, 'Amazing story and characters!', 5, '2023-01-10'),
(2, 'A must-read classic.', 5, '2023-01-15'),
(3, 'Thought-provoking and engaging.', 4, '2023-02-01'),
(4, 'A timeless romance.', 5, '2023-02-10'),
(5, 'An adventurous tale full of fun.', 4, '2023-03-05');

SELECT * FROM authors;
SELECT * FROM publishers;
SELECT * FROM books;
SELECT * FROM book_reviews;

SELECT title AS book_title, price AS book_price FROM books
ORDER BY book_price DESC;

SELECT * FROM books WHERE genre = 'Fantasy';

SELECT * FROM books ORDER BY price DESC LIMIT 3;

SELECT * FROM books WHERE genre IN ('Fantasy', 'Novel');

SELECT * FROM books WHERE price BETWEEN 15 AND 30;

SELECT * FROM books WHERE title LIKE '%Adventures%';

SELECT * FROM authors WHERE name LIKE 'J%';

SELECT * FROM books WHERE publisher_id IS NULL;

SELECT genre, COUNT(*) AS book_count FROM books GROUP BY genre;
SELECT country, COUNT(*) AS author_count FROM authors GROUP BY country;

SELECT 
    b.title AS book_title,
    a.name AS author_name,
    p.name AS publisher_name,
    b.price
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id;

SELECT COUNT(*) AS total_books, AVG(price) AS avg_price, SUM(price) AS total_revenue FROM books;
SELECT COUNT(*) AS total_reviews, AVG(rating) AS avg_rating FROM book_reviews;

