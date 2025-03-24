# **Layoff Trends Analysis**

## **Overview**
This project explores layoff trends using data analysis techniques to uncover patterns in workforce reductions across different industries, companies, and time periods. By leveraging **Exploratory Data Analysis (EDA)**, we aim to understand the factors driving layoffs and their impact on the job market.

## **Objectives**
- Identify **layoff trends** across industries, companies and time periods
- Examine the **impact of company size** on layoffs
- Investigate external factors influencing layoffs (e.g., economic downturns, AI advancements, pandemics)
- Provide **data-driven insights** for businesses, policymakers, and job seekers

## **Dataset**
- **Source:** This dataset is continution of layoff dataset cleaning project. 
- **Features:** Includes columns such as `Company`, `Industry`, `Date`, `Location`, `Total Laid Off`, `Percentage Laid Off`, `stage`.
- **Data Cleaning:** Handled missing values, remove duplicates, formatted date fields, and standardized company names done in previous project

  
Project Structure
data/raw_data.csv → The original dataset.
sql/create_table.sql → Script to create the database and table.
sql/clean_data.sql → SQL queries for data cleaning.
sql/export_cleaned_data.sql → Script to export the cleaned data.
data/cleaned_data.csv → Final cleaned dataset.

## **Tools & Technologies Used**
- **Python** (Pandas, NumPy, Matplotlib, Seaborn, Plotly)
- **MySQL** → SQL database for quering
- **MySQL Workbench** (for SQL execution)
- **Jupyter Notebook** for interactive analysis
- **Tableau/Power BI** for visualization

