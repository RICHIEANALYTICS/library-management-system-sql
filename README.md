Library Management System | PostgreSQL
Author: Richie Johns Kareekunnel
Database: library_db | Tech: PostgreSQL, SQL

Library Management System in PostgreSQL — database setup, CRUD, CTAS and data analysis. 17 tasks in total.

What This Project Covers
Database Setup: 6 tables — branch, employees, members, books, issued_status, return_status

Tasks Covered — 17 Tasks

CRUD Operations
Task 1: Create a New Book Record
Task 2: Update an Existing Member's Address
Task 3: Delete a Record from the Issued Status Table
Task 4: Retrieve All Books Issued by a Specific Employee
Task 5: List Members Who Have Issued More Than One Book

CTAS
Task 6: Create Summary Table — book_issued_summary (each book + total issued count)
Data Analysis & Findings
Task 7: Retrieve All Books in a Specific Category
Task 8: Find Total Rental Income by Category
Task 9: List Members Who Registered in the Last 180 Days
Task 10: List Employees with Their Branch Manager's Name and Branch Details
Task 11: Create a Table of Books with Rental Price Above a Threshold — expensive_books
Task 12: Retrieve the List of Books Not Yet Returned

Advanced SQL Operations
Task 13: Identify Members with Overdue Books (30-day return period)
Task 14: Branch Performance Report — books issued, books returned, total revenue
Task 15: CTAS — Create a Table of Active Members (issued in last 6 months)
Task 16: Find Employees with the Most Book Issues Processed (Top 3)
Task 17: Identify Members Issuing High-Risk Books (status = 'damaged', more than twice)

Project Structure

library-management-system-sql/
├── Library-Management-System-ORIGINAL.sql  # Complete project - Tasks 1 to 17
├── README.md
└── LICENSE

How To Run
# 1. Clone
git clone https://github.com/RICHIEANALYTICS/library-management-system-sql.git

# 2. Run in PostgreSQL
psql -U postgres -f Library-Management-System-ORIGINAL.sql

Key SQL Skills Demonstrated

Database design, Primary Key / Foreign Key
CRUD Operations
JOINs (INNER / LEFT / Self-Join), GROUP BY / HAVING
CTAS (Create Table As Select)
Date functions — CURRENT_DATE - INTERVAL
Aggregations — COUNT, SUM, COUNT(DISTINCT)
Connect
LinkedIn: linkedin.com/in/richie- | GitHub: github.com/RICHIEANALYTICS

