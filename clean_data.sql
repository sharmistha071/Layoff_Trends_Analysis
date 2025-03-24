/* Data Cleaning Project 
Steps
- Remove Duplicates
- Standardize the Data
- Null values or blank values 
- Remove Any columns(if it is irrevelant no required for ETL process)

*/
/***************************Step 01 *************************************/

SELECT 
	* 
FROM 
	world_layoffs.layoffs;
    
-- Creating an intermediate table --

CREATE TABLE world_layoffs.layoffs_staging
LIKE world_layoffs.layoffs;

-- populating data into staging from layoofs table
INSERT INTO world_layoffs.layoffs_staging
SELECT * FROM world_layoffs.layoffs;
 
-- identify duplicates

/* As we dont have an id can't use this query 
SELECT 
	MIN(id) 
FROM 
	world_layoffs.layoffs_staging
GROUP BY company, location, industry, total_laid_off, percentage_laid_off, date;

*/


SELECT 
	*,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country,funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging;

WITH duplicate_cte AS(
SELECT 
	*,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging
)

SELECT 
	* 
FROM 
	duplicate_cte
WHERE 
	row_num > 1;
    
SELECT 
	* 
FROM world_layoffs.layoffs_staging
WHERE company = 'Casper';


WITH duplicate_cte AS(
SELECT 
	*,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging
)

DELETE 
FROM 
	duplicate_cte
WHERE 
	row_num > 1;
   
/* Create anothe intermediate table with row_nums
	then we are goint to identify row with row_nums>1 
    if so, then delete that row
    otherwise keep it 
*/
   
CREATE TABLE world_layoffs.layoffs_staging_2 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_ci;


INSERT INTO world_layoffs.layoffs_staging_2
SELECT 
	*,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging;

/* Deleting the duplicates */

SET SQL_SAFE_UPDATES = 0;

DELETE
FROM 
 world_layoffs.layoffs_staging_2
WHERE 
	row_num > 1;
    
SET SQL_SAFE_UPDATES = 1;

/* Deleting the duplicates */

SELECT
	*
FROM 
 world_layoffs.layoffs_staging_2;

/***************************Step 01 Ends*************************************/

/***************************Step 02 standardizing the data*************************************/
 
-- Trimming space --

SELECT 
	DISTINCT(company),
    TRIM(company)
FROM world_layoffs.layoffs_staging_2;

UPDATE world_layoffs.layoffs_staging_2
SET company = TRIM(company);

SELECT 
	*
FROM world_layoffs.layoffs_staging_2;

SELECT 
	DISTINCT(industry)
FROM world_layoffs.layoffs_staging_2
ORDER BY industry;

UPDATE 
	world_layoffs.layoffs_staging_2
SET industry = 'Crypto'
WHERE 
	industry Like 'Crypto%';
    
SELECT 
	DISTINCT(country)
FROM world_layoffs.layoffs_staging_2
WHERE country LIKE 'UNITED State%'
ORDER BY country;

UPDATE 
	world_layoffs.layoffs_staging_2
SET country = 'United States' -- altenarive way TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'UNITED State%';

/* now let's change the format of date column from text to date, because with text we can't do timeseries */


UPDATE 
	world_layoffs.layoffs_staging_2
SET 
	`date` = STR_TO_DATE(`date`, '%m/%d/%Y');
    
-- still date colum type is text, so to modify it to date format

ALTER TABLE world_layoffs.layoffs_staging_2
MODIFY COLUMN `date` DATE;
    
/* ****************** STEP 03: working with null and blanck values ******************/

/* checking for empty industry value */
    
UPDATE 
	world_layoffs.layoffs_staging_2
SET 
	industry = NULL 
WHERE 
	industry = '';

SELECT 
	t1.industry,
    t2.industry
FROM 
	world_layoffs.layoffs_staging_2 t1
JOIN 
	world_layoffs.layoffs_staging_2 t2
	ON
		t1.company = t2.company
WHERE
	t1.industry is NULL
    AND t2.industry IS NOT NULL;
    
    
UPDATE 
	world_layoffs.layoffs_staging_2 t1
JOIN 
	world_layoffs.layoffs_staging_2 t2
    ON t1.company = t2.company
SET 
	t1.industry = t2.industry
WHERE 
	t1.industry IS NULL 
    AND t2.industry IS NOT NULL;

    
/* Deleting emptry total_laid off and percentage_total_laid_off value, as we can't do any analysis with this empty value */
    
DELETE
FROM 
	world_layoffs.layoffs_staging_2
WHERE 
	total_laid_off IS NULL
    AND percentage_laid_off IS NULL;

SELECT
	*
FROM 
	world_layoffs.layoffs_staging_2;

-- Deleteing extra column like row_num 

ALTER TABLE world_layoffs.layoffs_staging_2
DROP COLUMN row_num
    
    


    
    
    
    
    



