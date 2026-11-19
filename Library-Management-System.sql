-- ============================================================
-- Library Management System | PostgreSQL
-- Author: Richie Johns Kareekunnel
-- Database: library_db
-- Description: End-to-end Library Management System covering
-- schema design, CRUD, CTAS, analysis and stored procedures.
-- How to run: psql -U postgres -f library_management_system.sql
-- ============================================================

DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
\c library_db;

-- ============================================================
-- 1. SCHEMA
-- ============================================================

DROP TABLE IF EXISTS return_status;
DROP TABLE IF EXISTS issued_status;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS branch;

CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(50),
    contact_no VARCHAR(15)
);

CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(30) NOT NULL,
    position VARCHAR(30),
    salary DECIMAL(10,2),
    branch_id VARCHAR(10),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE members (
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(30) NOT NULL,
    member_address VARCHAR(50),
    reg_date DATE
);

CREATE TABLE books (
    isbn VARCHAR(50) PRIMARY KEY,
    book_title VARCHAR(80) NOT NULL,
    category VARCHAR(30),
    rental_price DECIMAL(10,2),
    status VARCHAR(10) CHECK (status IN ('yes','no','damaged')),
    author VARCHAR(30),
    publisher VARCHAR(50)
);

CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(30),
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(50),
    issued_emp_id VARCHAR(10),
    FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn)
);

CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(30),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50),
    book_quality VARCHAR(20),
    FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

-- ============================================================
-- 2. SEED DATA
-- ============================================================

INSERT INTO members(member_id, member_name, member_address, reg_date) VALUES
('C101','Alice Johnson','123 Main St','2021-05-15'),
('C102','Bob Smith','456 Elm St','2021-06-20'),
('C103','Carol Davis','789 Oak St','2021-07-10'),
('C104','Dave Wilson','567 Pine St','2021-08-05'),
('C105','Eve Brown','890 Maple St','2021-09-25'),
('C106','Frank Thomas','234 Cedar St','2021-10-15'),
('C107','Grace Taylor','345 Walnut St','2021-11-20'),
('C108','Henry Anderson','456 Birch St','2021-12-10'),
('C109','Ivy Martinez','567 Oak St','2022-01-05'),
('C110','Jack Wilson','678 Pine St','2022-02-25'),
('C118','Sam','133 Pine St','2024-06-01'),
('C119','John','143 Main St','2024-05-01');

INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) VALUES
('B001','E109','123 Main St','+919099988676'),
('B002','E109','456 Elm St','+919099988677'),
('B003','E109','789 Oak St','+919099988678'),
('B004','E110','567 Pine St','+919099988679'),
('B005','E110','890 Maple St','+919099988680');

INSERT INTO employees(emp_id, emp_name, position, salary, branch_id) VALUES
('E101','John Doe','Clerk',60000.00,'B001'),
('E102','Jane Smith','Clerk',45000.00,'B002'),
('E103','Mike Johnson','Librarian',55000.00,'B001'),
('E104','Emily Davis','Assistant',40000.00,'B001'),
('E105','Sarah Brown','Assistant',42000.00,'B001'),
('E106','Michelle Ramirez','Assistant',43000.00,'B001'),
('E107','Michael Thompson','Clerk',62000.00,'B005'),
('E108','Jessica Taylor','Clerk',46000.00,'B004'),
('E109','Daniel Anderson','Manager',57000.00,'B003'),
('E110','Laura Martinez','Manager',41000.00,'B005'),
('E111','Christopher Lee','Assistant',65000.00,'B005');

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) VALUES
('978-0-553-29698-2','The Catcher in the Rye','Classic',7.00,'yes','J.D. Salinger','Little, Brown and Company'),
('978-0-330-25864-8','Animal Farm','Classic',5.50,'yes','George Orwell','Penguin Books'),
('978-0-14-118776-1','One Hundred Years of Solitude','Literary Fiction',6.50,'yes','Gabriel Garcia Marquez','Penguin Books'),
('978-0-525-47535-5','The Great Gatsby','Classic',8.00,'yes','F. Scott Fitzgerald','Scribner'),
('978-0-141-44171-6','Jane Eyre','Classic',4.00,'yes','Charlotte Bronte','Penguin Classics'),
('978-0-307-37840-1','The Alchemist','Fiction',2.50,'yes','Paulo Coelho','HarperOne'),
('978-0-679-76489-8','Harry Potter and the Sorcerers Stone','Fantasy',7.00,'yes','J.K. Rowling','Scholastic'),
('978-0-7432-4722-4','The Da Vinci Code','Mystery',8.00,'yes','Dan Brown','Doubleday'),
('978-0-09-957807-9','A Game of Thrones','Fantasy',7.50,'yes','George R.R. Martin','Bantam'),
('978-0-393-05081-8','A Peoples History of the United States','History',9.00,'yes','Howard Zinn','Harper Perennial'),
('978-0-19-280551-1','The Guns of August','History',7.00,'yes','Barbara W. Tuchman','Oxford University Press'),
('978-0-307-58837-1','Sapiens: A Brief History of Humankind','History',8.00,'no','Yuval Noah Harari','Harper Perennial'),
('978-0-375-41398-8','The Diary of a Young Girl','History',6.50,'no','Anne Frank','Bantam'),
('978-0-14-044930-3','The Histories','History',5.50,'yes','Herodotus','Penguin Classics'),
('978-0-393-91257-8','Guns, Germs, and Steel','History',7.00,'yes','Jared Diamond','W. W. Norton & Company'),
('978-0-7432-7357-1','1491: New Revelations of the Americas Before Columbus','History',6.50,'no','Charles C. Mann','Vintage Books'),
('978-0-679-64115-3','1984','Dystopian',6.50,'yes','George Orwell','Penguin Books'),
('978-0-14-143951-8','Pride and Prejudice','Classic',5.00,'yes','Jane Austen','Penguin Classics'),
('978-0-452-28240-7','Brave New World','Dystopian',6.50,'yes','Aldous Huxley','Harper Perennial'),
('978-0-670-81302-4','The Road','Dystopian',7.00,'yes','Cormac McCarthy','Knopf'),
('978-0-385-33312-0','The Shining','Horror',6.00,'yes','Stephen King','Doubleday'),
('978-0-451-52993-5','Fahrenheit 451','Dystopian',5.50,'yes','Ray Bradbury','Ballantine Books'),
('978-0-345-39180-3','Dune','Science Fiction',8.50,'yes','Frank Herbert','Ace'),
('978-0-06-025492-6','Where the Wild Things Are','Children',3.50,'yes','Maurice Sendak','HarperCollins'),
('978-0-06-112241-5','The Kite Runner','Fiction',5.50,'yes','Khaled Hosseini','Riverhead Books'),
('978-0-06-440055-8','Charlotte''s Web','Children',4.00,'yes','E.B. White','Harper & Row'),
('978-0-679-77644-3','Beloved','Fiction',6.50,'yes','Toni Morrison','Knopf'),
('978-0-14-027526-3','A Tale of Two Cities','Classic',4.50,'yes','Charles Dickens','Penguin Books'),
('978-0-7434-7679-3','The Stand','Horror',7.00,'yes','Stephen King','Doubleday'),
('978-0-451-52994-2','Moby Dick','Classic',6.50,'yes','Herman Melville','Penguin Books'),
('978-0-06-112008-4','To Kill a Mockingbird','Classic',5.00,'yes','Harper Lee','J.B. Lippincott & Co.'),
('978-0-7432-4722-5','Angels & Demons','Mystery',7.50,'yes','Dan Brown','Doubleday'),
('978-0-7432-7356-4','The Hobbit','Fantasy',7.00,'yes','J.R.R. Tolkien','Houghton Mifflin Harcourt');

INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) VALUES
('IS106','C106','Animal Farm','2024-03-10','978-0-330-25864-8','E104'),
('IS107','C107','One Hundred Years of Solitude','2024-03-11','978-0-14-118776-1','E104'),
('IS108','C108','The Great Gatsby','2024-03-12','978-0-525-47535-5','E104'),
('IS109','C109','Jane Eyre','2024-03-13','978-0-141-44171-6','E105'),
('IS110','C110','The Alchemist','2024-03-14','978-0-307-37840-1','E105'),
('IS111','C109','Harry Potter and the Sorcerers Stone','2024-03-15','978-0-679-76489-8','E105'),
('IS112','C109','A Game of Thrones','2024-03-16','978-0-09-957807-9','E106'),
('IS113','C109','A Peoples History of the United States','2024-03-17','978-0-393-05081-8','E106'),
('IS114','C109','The Guns of August','2024-03-18','978-0-19-280551-1','E106'),
('IS115','C109','The Histories','2024-03-19','978-0-14-044930-3','E107'),
('IS116','C110','Guns, Germs, and Steel','2024-03-20','978-0-393-91257-8','E107'),
('IS117','C110','1984','2024-03-21','978-0-679-64115-3','E107'),
('IS118','C101','Pride and Prejudice','2024-03-22','978-0-14-143951-8','E108'),
('IS119','C110','Brave New World','2024-03-23','978-0-452-28240-7','E108'),
('IS120','C110','The Road','2024-03-24','978-0-670-81302-4','E108'),
('IS121','C102','The Shining','2024-03-25','978-0-385-33312-0','E109'),
('IS122','C102','Fahrenheit 451','2024-03-26','978-0-451-52993-5','E109'),
('IS123','C103','Dune','2024-03-27','978-0-345-39180-3','E109'),
('IS124','C104','Where the Wild Things Are','2024-03-28','978-0-06-025492-6','E110'),
('IS125','C105','The Kite Runner','2024-03-29','978-0-06-112241-5','E110'),
('IS126','C105','Charlotte''s Web','2024-03-30','978-0-06-440055-8','E110'),
('IS127','C105','Beloved','2024-03-31','978-0-679-77644-3','E110'),
('IS128','C105','A Tale of Two Cities','2024-04-01','978-0-14-027526-3','E110'),
('IS129','C105','The Stand','2024-04-02','978-0-7434-7679-3','E110'),
('IS130','C106','Moby Dick','2024-04-03','978-0-451-52994-2','E101'),
('IS131','C106','To Kill a Mockingbird','2024-04-04','978-0-06-112008-4','E101'),
('IS132','C106','The Hobbit','2024-04-05','978-0-7432-7356-4','E106'),
('IS133','C107','Angels & Demons','2024-04-06','978-0-7432-4722-5','E106'),
('IS134','C107','The Diary of a Young Girl','2024-04-07','978-0-375-41398-8','E106'),
('IS135','C107','Sapiens','2024-04-08','978-0-307-58837-1','E108'),
('IS136','C107','1491','2024-04-09','978-0-7432-7357-1','E102'),
('IS137','C107','The Catcher in the Rye','2024-04-10','978-0-553-29698-2','E103'),
('IS138','C108','The Great Gatsby','2024-04-11','978-0-525-47535-5','E104'),
('IS139','C109','Harry Potter and the Sorcerers Stone','2024-04-12','978-0-679-76489-8','E105'),
('IS140','C110','Animal Farm','2024-04-13','978-0-330-25864-8','E102');

INSERT INTO return_status(return_id, issued_id, return_book_name, return_date, return_book_isbn, book_quality) VALUES
('RS104','IS106','Animal Farm','2024-05-01','978-0-330-25864-8','Good'),
('RS105','IS107','One Hundred Years of Solitude','2024-05-03','978-0-14-118776-1','Good'),
('RS106','IS108','The Great Gatsby','2024-05-05','978-0-525-47535-5','Good'),
('RS107','IS109','Jane Eyre','2024-05-07','978-0-141-44171-6','Good'),
('RS108','IS110','The Alchemist','2024-05-09','978-0-307-37840-1','Good'),
('RS109','IS111','Harry Potter and the Sorcerers Stone','2024-05-11','978-0-679-76489-8','Good'),
('RS110','IS112','A Game of Thrones','2024-05-13','978-0-09-957807-9','Good'),
('RS111','IS113','A Peoples History','2024-05-15','978-0-393-05081-8','Good'),
('RS112','IS114','The Guns of August','2024-05-17','978-0-19-280551-1','Good'),
('RS113','IS115','The Histories','2024-05-19','978-0-14-044930-3','Good'),
('RS114','IS116','Guns, Germs, and Steel','2024-05-21','978-0-393-91257-8','Good'),
('RS115','IS117','1984','2024-05-23','978-0-679-64115-3','Good'),
('RS116','IS118','Pride and Prejudice','2024-05-25','978-0-14-143951-8','Good'),
('RS117','IS119','Brave New World','2024-05-27','978-0-452-28240-7','Good'),
('RS118','IS120','The Road','2024-05-29','978-0-670-81302-4','Good');

-- ============================================================
-- 3. CRUD OPERATIONS
-- ============================================================
-- Task 1: Create a new book
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2','To Kill a Mockingbird','Classic',6.00,'yes','Harper Lee','J.B. Lippincott & Co.')
ON CONFLICT (isbn) DO NOTHING;

-- Task 2: Update member address
UPDATE members SET member_address='125 Main St' WHERE member_id='C101';

-- Task 3: Delete a record
DELETE FROM issued_status WHERE issued_id='IS121';

-- Task 4: Books issued by employee E101
SELECT * FROM issued_status WHERE issued_emp_id='E101';

-- Task 5: Members who issued >1 book (FIXED: grouped by member, not employee)
SELECT ist.issued_member_id, m.member_name, COUNT(ist.issued_id) AS total_books_issued
FROM issued_status ist JOIN members m ON m.member_id=ist.issued_member_id
GROUP BY ist.issued_member_id, m.member_name HAVING COUNT(ist.issued_id)>1;

-- Task 5b: Employees who processed >1 issue
SELECT ist.issued_emp_id, e.emp_name, COUNT(ist.issued_id) AS total_books_issued
FROM issued_status ist JOIN employees e ON e.emp_id=ist.issued_emp_id
GROUP BY ist.issued_emp_id, e.emp_name HAVING COUNT(ist.issued_id)>1;

-- ============================================================
-- 4. CTAS
-- ============================================================
DROP TABLE IF EXISTS book_issued_summary;
CREATE TABLE book_issued_summary AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS total_book_issued_cnt
FROM books b LEFT JOIN issued_status ist ON b.isbn=ist.issued_book_isbn
GROUP BY b.isbn, b.book_title;

-- ============================================================
-- 5. DATA ANALYSIS
-- ============================================================
-- Task 7: Books in Classic
SELECT * FROM books WHERE category='Classic';
-- Task 8: Total rental income by category
SELECT b.category, SUM(b.rental_price) AS total_rental_income
FROM books b JOIN issued_status ist ON b.isbn=ist.issued_book_isbn
GROUP BY b.category ORDER BY total_rental_income DESC;
-- Task 9: Members registered last 180 days
SELECT * FROM members WHERE reg_date > CURRENT_DATE - INTERVAL '180 days';
-- Task 10: Employees + branch manager
SELECT e.emp_id, e.emp_name, b.branch_id, m.emp_name AS manager_name
FROM employees e JOIN branch b ON e.branch_id=b.branch_id
JOIN employees m ON b.manager_id=m.emp_id;
-- Task 11: Expensive books CTAS
DROP TABLE IF EXISTS expensive_books;
CREATE TABLE expensive_books AS SELECT * FROM books WHERE rental_price > 5;
-- Task 12: Books not yet returned
SELECT ist.issued_id, ist.issued_member_id, ist.issued_book_name, ist.issued_date, ist.issued_book_isbn
FROM issued_status ist LEFT JOIN return_status rs ON ist.issued_id=rs.issued_id
WHERE rs.issued_id IS NULL;

-- ============================================================
-- 6. ADVANCED
-- ============================================================
-- Task 13: Overdue books (30-day period)
SELECT m.member_name, ist.issued_book_name AS book_title, ist.issued_date,
       (CURRENT_DATE - ist.issued_date) - 30 AS days_overdue
FROM issued_status ist JOIN members m ON ist.issued_member_id=m.member_id
LEFT JOIN return_status rs ON ist.issued_id=rs.issued_id
WHERE rs.issued_id IS NULL AND CURRENT_DATE - ist.issued_date > 30
ORDER BY days_overdue DESC;

-- Task 14: Branch Performance Report
SELECT b.branch_id, b.branch_address,
       COUNT(DISTINCT ist.issued_id) AS total_books_issued,
       COUNT(DISTINCT rs.issued_id) AS total_books_returned,
       COALESCE(SUM(bo.rental_price),0) AS total_rental_revenue
FROM branch b LEFT JOIN employees e ON b.branch_id=e.branch_id
LEFT JOIN issued_status ist ON e.emp_id=ist.issued_emp_id
LEFT JOIN return_status rs ON ist.issued_id=rs.issued_id
LEFT JOIN books bo ON ist.issued_book_isbn=bo.isbn
GROUP BY b.branch_id, b.branch_address ORDER BY b.branch_id;

-- Task 15: Active Members CTAS (last 6 months)
DROP TABLE IF EXISTS active_members;
CREATE TABLE active_members AS
SELECT DISTINCT m.member_id, m.member_name, m.member_address, m.reg_date
FROM members m JOIN issued_status ist ON m.member_id=ist.issued_member_id
WHERE ist.issued_date >= CURRENT_DATE - INTERVAL '6 months';

-- Task 16: Top 3 employees by issues processed
SELECT e.emp_name, COUNT(ist.issued_id) AS books_processed, e.branch_id
FROM employees e JOIN issued_status ist ON e.emp_id=ist.issued_emp_id
GROUP BY e.emp_id, e.emp_name, e.branch_id
ORDER BY books_processed DESC LIMIT 3;

-- Task 17: High-risk / damaged books
SELECT m.member_name, b.book_title, COUNT(ist.issued_id) AS damaged_book_issue_count
FROM issued_status ist JOIN members m ON ist.issued_member_id=m.member_id
JOIN books b ON ist.issued_book_isbn=b.isbn
WHERE b.status='damaged'
GROUP BY m.member_id, m.member_name, b.isbn, b.book_title
HAVING COUNT(ist.issued_id) > 2 ORDER BY damaged_book_issue_count DESC;

-- ============================================================
-- 7. STORED PROCEDURES (NEW: completed from your work)
-- ============================================================
CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10), p_book_quality VARCHAR(10))
LANGUAGE plpgsql AS $$
DECLARE v_isbn VARCHAR(50); v_book_name VARCHAR(80);
BEGIN
  INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
  VALUES(p_return_id, p_issued_id, CURRENT_DATE, p_book_quality);
  SELECT issued_book_isbn, issued_book_name INTO v_isbn, v_book_name
  FROM issued_status WHERE issued_id=p_issued_id;
  UPDATE books SET status='yes' WHERE isbn=v_isbn;
  RAISE NOTICE 'Thank you for returning the book: %', v_book_name;
END; $$;

CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(30), p_issued_book_isbn VARCHAR(30), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql AS $$
DECLARE v_status VARCHAR(10);
BEGIN
  SELECT status INTO v_status FROM books WHERE isbn=p_issued_book_isbn;
  IF v_status='yes' THEN
    INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
    VALUES(p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);
    UPDATE books SET status='no' WHERE isbn=p_issued_book_isbn;
    RAISE NOTICE 'Book issued successfully for isbn: %', p_issued_book_isbn;
  ELSE
    RAISE NOTICE 'Sorry, book unavailable: %', p_issued_book_isbn;
  END IF;
END; $$;

-- Task 20: Overdue fines CTAS - $0.50 per overdue day
DROP TABLE IF EXISTS overdue_fines;
CREATE TABLE overdue_fines AS
SELECT m.member_id, COUNT(ist.issued_id) AS overdue_books,
       SUM(((CURRENT_DATE - ist.issued_date)-30)*0.50) AS total_fines,
       COUNT(ist.issued_id) AS books_issued
FROM issued_status ist JOIN members m ON m.member_id=ist.issued_member_id
LEFT JOIN return_status rs ON rs.issued_id=ist.issued_id
WHERE rs.issued_id IS NULL AND (CURRENT_DATE - ist.issued_date) > 30
GROUP BY m.member_id;
