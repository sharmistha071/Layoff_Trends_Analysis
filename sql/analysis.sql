USE world_layoffs;

SELECT 
	*
FROM 
	layoffs_staging_2;
    
SELECT 
	MAX(total_laid_off), MAX(percentage_laid_off)
FROM 
	layoffs_staging_2;
	
SELECT 
	*
FROM 
	layoffs_staging_2
WHERE 
	percentage_laid_off = 1
ORDER BY
	total_laid_off DESC;
    
SELECT 
	company, SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	company
ORDER BY SUM(total_laid_off) DESC;

SELECT 
	MIN(`date`), MAX(`date`)
FROM 
	layoffs_staging_2;

SELECT 
	industry, SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	industry
ORDER BY SUM(total_laid_off) DESC;

SELECT 
	country, SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	country
ORDER BY SUM(total_laid_off) DESC;

SELECT 
	Year(`date`), SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	Year(`date`)
ORDER BY Year(`date`) DESC;

SELECT 
	stage, SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	stage
ORDER BY 2 DESC;


/* a large company with a layoff proportion of 0.05 could still show more people being laid off, 
then a smaller company with a layoff proportion of 0.7, 
even though this gives valuable insight that the past 3 years have hit small companies very hard */
SELECT 
	stage, ROUND(AVG(percentage_laid_off),2), SUM(total_laid_off)
FROM 
	layoffs_staging_2
GROUP BY 
	stage
ORDER BY 2 DESC;



-- Rolling sum of total Layoffs by year and Months

SELECT 
	SUBSTRING(`date`, 1,7) AS timeline, SUM(total_laid_off)
FROM 
	layoffs_staging_2
WHERE 
	SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY 
	timeline
ORDER BY 
	timeline;
	
WITH rolling_timeline AS
(
SELECT 
	SUBSTRING(`date`, 1, 7) AS timeline, SUM(total_laid_off) AS total_off
FROM 
	layoffs_staging_2
WHERE 
	SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY 
	timeline
ORDER BY 
	timeline
)

SELECT 
	timeline, 
    total_off, 
    SUM(total_off) OVER(ORDER BY timeline) AS rolling_total
FROM rolling_timeline;


-- how much a company lay off emplyee per year

SELECT 
	company, SUM(total_laid_off), YEAR(`date`)
FROM
	layoffs_staging_2
GROUP BY 
	 YEAR(`date`), company
ORDER BY 
	company;
    
-- identify companies that laid off highest in years

WITH rank_cte AS(
SELECT 
	company, SUM(total_laid_off) as total_off, YEAR(`date`) as year
FROM 
	layoffs_staging_2
GROUP BY 
	company, YEAR(`date`)
ORDER BY 
	company
)

SELECT
	company, year, total_off, RANK() OVER(PARTITION BY year ORDER BY total_off DESC) AS ranking
FROM 
	rank_cte
WHERE
	year IS NOT NULL;
    
-- identify top 5 companies that laid off highest laid off in years

WITH top_five_company_cte AS(
SELECT 
	company, 
    SUM(total_laid_off) AS total_off, 
    YEAR(`date`) as year,
    RANK() OVER(PARTITION BY YEAR(`date`) ORDER BY SUM(total_laid_off) DESC) AS ranking
FROM 
	layoffs_staging_2
GROUP BY 
	company, YEAR(`date`)
)

SELECT 
	*
FROM 
	top_five_company_cte
WHERE 
	ranking<6 AND year IS NOT NULL
	




	