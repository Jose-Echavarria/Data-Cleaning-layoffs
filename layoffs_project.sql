-- Remove duplicate data

CREATE TABLE layoffs_staging
LIKE layoffs;

insert layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

WITH duplicate_cte as (
SELECT *,
row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off, 
`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_staging2` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2;

insert into layoffs_staging2
SELECT *,
row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off, 
`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging;

DELETE 
from layoffs_staging2
where row_num > 1;

SELECT *
from layoffs_staging2
where row_num > 1;

-- Standardize the Data

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT distinct industry
from layoffs_staging2
order by 1;

SELECT industry
FROM layoffs_staging2
WHERE industry lIKE 'crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging2;

SELECT distinct country
FROM layoffs_staging2
order by 1;

SELECT *
FROM layoffs_staging2
WHERE country like 'United States%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country like 'United States%';

SELECT *
FROM layoffs_staging2
WHERE country like 'United States%';

SELECT `date`,
STR_TO_DATE (`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE (`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
modify column `date` DATE;

SELECT `date`
FROM layoffs_staging2;

-- NULL values or blank values

SELECT *
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select industry
FROM layoffs_staging2
WHERE industry is null or industry = '';

SELECT *
FROM layoffs_staging2
where company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
from layoffs_staging2 as T1
join layoffs_staging2 as T2 on T1.company = T2.company 							
WHERE (T1.industry is null or T1.industry = '')
AND T2.industry is not null;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT company, industry
FROM layoffs_staging2
where company = "Airbnb";

SELECT company, industry
FROM layoffs_staging2;

DELETE
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
FROM layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- remove Any columns 

ALTER TABLE layoffs_staging2
DROP Column row_num;

SELECT * 
FROM layoffs_staging2



