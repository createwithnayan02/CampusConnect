## Project Information

 Project Title: CampusConnect — College Internship & Placement Management System

 Developed By: Nayan Mishra

 Course: Bachelor of Technology (B.Tech) — Information Technology

 College: Priyadarshini College of Engineering, Nagpur

 Academic Year: 2026–27

 Project Type: DBMS Mini Project



## Features

- View registered students
- View available internship and placement opportunities
- Submit job applications
- View submitted applications
- Store company information
- Store student skills
- Maintain interview records
- Maintain application status history
- Relational database with primary and foreign keys
- Database constraints for data integrity
- Indexes for frequently used database operations
- Transaction handling using COMMIT and ROLLBACK

---

## Technologies Used

- Python
- Flask
- PostgreSQL
- HTML
- CSS
- psycopg2
- pgAdmin
- Git and GitHub

---

## Database Structure

The database contains the following tables:

1. students
2. companies
3. jobs
4. skills
5. student_skills
6. applications
7. interviews
8. application_status_history

The database demonstrates one-to-many and many-to-many relationships between different entities.

---

## Project Structure

CampusConnect/
│
├── static/
│   └── style.css
│
├── templates/
│   ├── index.html
│   ├── students.html
│   ├── jobs.html
│   ├── apply.html
│   └── applications.html
│
├── app.py
├── database.py
├── requirements.txt
├── campusconnect.sql
├── campusconnect_backup.sql
├── .gitignore
└── README.md

---

## Database Setup

### 1. Install PostgreSQL

Install PostgreSQL and pgAdmin on the system.

### 2. Create the Database

Create a PostgreSQL database named:

campusconnect

### 3. Import the Database

The repository contains SQL files for the database schema and sample data.

- `campusconnect.sql` contains the database schema.
- `campusconnect_backup.sql` contains the database backup with sample data.

The SQL files can be executed or imported using pgAdmin.
---

## Python Setup

Create a virtual environment:

python -m venv venv

Activate the virtual environment on Windows:

.\venv\Scripts\Activate.ps1

Install the required packages:

pip install -r requirements.txt

---

## Database Connection

The Flask application connects to PostgreSQL through `database.py`.

Before running the application, configure the PostgreSQL connection details according to the local PostgreSQL installation.

---

## Running the Application

Start the Flask application using:

python app.py

Then open the following address in a web browser:

http://127.0.0.1:5000

---

## Main Pages

### Home Page

Provides navigation to the main functions of the system.

### Students

Displays registered students and their academic details.

### Jobs

Displays currently available internship and placement opportunities.

### Apply for Job

Allows a student to submit an application for an available job.

### Applications

Displays submitted applications and their current status.

---

## DBMS Concepts Demonstrated

The project demonstrates the following DBMS concepts:

- Relational database design
- Primary keys
- Foreign keys
- Composite primary keys
- NOT NULL constraints
- UNIQUE constraints
- CHECK constraints
- DEFAULT values
- One-to-many relationships
- Many-to-many relationships
- Normalization up to 3NF
- SQL JOIN operations
- Indexing
- Transactions
- COMMIT
- ROLLBACK

---

## Sample Database Records

The current project database contains sample records for:

- 15 students
- 5 companies
- 8 jobs
- 10 skills
- 46 student-skill mappings
- 22 applications
- 8 interviews
- 10 application status history records

---

## Project Purpose

This project was developed as a DBMS mini project to demonstrate practical implementation of relational database design, SQL, normalization, constraints, relationships, indexing, and transaction management using a web-based application.

---

## Future Scope

The system can be extended in the future with:

- User authentication
- Administrator dashboard
- Advanced job filtering
- Company-side job management
- Placement statistics and reports
- Resume management
- Automated notifications