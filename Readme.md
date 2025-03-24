Project Title
SQL Data Cleaning for Layoffs Dataset

Overview
This project focuses on cleaning a layoff dataset using SQL. The dataset contains encoding issues, duplicate values, missing values and inconsistent formats. The goal is to use SQL queries to clean and standardize he data for analysis.

Project Structure
data/raw_data.csv → The original dataset.
sql/create_table.sql → Script to create the database and table.
sql/clean_data.sql → SQL queries for data cleaning.
sql/export_cleaned_data.sql → Script to export the cleaned data.
data/cleaned_data.csv → Final cleaned dataset.

Data Cleaning Steps
Fix Encoding Issues: Convert special characters (e.g., D√ºsseldorf → Düsseldorf).
Remove Duplicates: Identify and delete duplicate rows.
Handle Missing Values: Fill null values or remove incomplete records.
Standardize Text: Convert company/location names to lowercase.
Fix Date Formats: Ensure consistent date format.
Handle Outliers: Identify and remove extreme values.

Tools Used
MySQL / PostgreSQL → SQL database
Pandas (for exporting cleaned data)
MySQL Workbench (for SQL execution)

💻 How to Run
Clone the repository:
sh
git clone https://github.com/yourusername/sql-data-cleaning-project.git
cd layoff_project

Create the database:

source sql/create_table.sql;

📌 Importing CSV into MySQL Using Workbench
This project imports and cleans a dataset using MySQL. Below are the steps to import the CSV file using MySQL Workbench.

1️⃣ Create the Database and Table
Before importing the data, create a table in MySQL. You can run the following script:

sql

CREATE DATABASE layoffs_db;
USE layoffs_db;

CREATE TABLE layoffs (
id INT AUTO_INCREMENT PRIMARY KEY,
company VARCHAR(255),
location VARCHAR(255),
industry VARCHAR(255),
num_layoffs INT,
date DATE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
2️⃣ Import CSV Using MySQL Workbench
Follow these steps to import data/raw_data.csv into the layoffs table:

Open MySQL Workbench and connect to your database.
Go to "Table Data Import Wizard"
In the Navigator Panel, right-click on your database (e.g., layoffs_db).
Select Table Data Import Wizard.
Select the CSV file
Click Browse, navigate to data/raw_data.csv, and click Next.
Map the CSV columns to the table
Ensure the CSV headers match the MySQL table columns.
Click Next and then Finish.
Verify the import
Run:

Cleaning the Data with SQL
After importing, clean the data using clean_data.sql.

Run:
source sql/clean_data.sql;

Run data cleaning queries:
source sql/clean_data.sql;

Export cleaned data:

source sql/export_cleaned_data.sql;
