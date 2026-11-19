Library Management System | PostgreSQL
Author: Richie Johns Kareekunnel
Database: library_db | Level: Intermediate | Tech: PostgreSQL, PL/pgSQL

End-to-end Library Management System — schema design, CRUD, CTAS, business analysis and stored procedures.
Built to answer real management questions: overdue books, branch performance, rental revenue, active members and fines.

Business Questions Answered
Which books are overdue and by how many days?
How much rental revenue by category and by branch?
Which books have not been returned?
Who are the top 3 employees by books processed?
Who are active members (issued in last 6 months)?
What are overdue fines at $0.50 / day?
Project Structure
library-management-system-sql/
├── library_management_system.sql  # Complete project - run this one file
├── README.md
└── docs/data_dictionary.md
Database Schema - 6 Tables
Table	Purpose
branch	Branch + manager
employees	Staff + branch link
members	Library members
books	Book catalogue + status
issued_status	Books issued
return_status	Books returned + quality
ERD: branch (1) -> employees (N), employees (1) -> issued_status (N), members (1) -> issued_status (N), books (1) -> issued_status (N)

How To Run
# 1. Clone
git clone https://github.com/RICHIEANALYTICS/library-management-system-sql.git

# 2. Run in PostgreSQL
psql -U postgres -f library_management_system.sql

# 3. Test procedures
CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL add_return_records('RS138', 'IS135', 'Good');
Key SQL Skills Demonstrated
Database design, PK / FK, CHECK constraints
CRUD, JOINs (INNER / LEFT / Self-Join), GROUP BY / HAVING
Subqueries, CTAS, Views-style summary tables
Window-style aggregation, Date arithmetic (CURRENT_DATE - INTERVAL)
Stored Procedures in PL/pgSQL, RAISE NOTICE, transaction logic
Reporting: Branch Performance, Overdue Fines, Active Members
What I Fixed / Improved
Task 5 corrected: members grouped by member_id (not employee)
Task 17 completed: damaged-book logic with HAVING > 2
Task 20 completed: Overdue fines CTAS with $0.50/day
Added book_quality to return_status, CHECK on book status, ON CONFLICT handling
Learning Note
Built independently through hands-on practice following SQL mentorship on database design and querying.

Connect
LinkedIn: linkedin.com/in/richie- | GitHub: github.com/RICHIEANALYTICS
