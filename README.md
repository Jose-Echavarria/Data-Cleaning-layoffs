Layoffs Data Cleaning Project
This project focuses on cleaning and standardizing a dataset of company layoffs. The data is loaded into staging tables, deduplicated, and cleaned for more consistent analysis. Using SQL, I’ve removed duplicates, standardized text fields, corrected dates, and handled NULL values for accuracy and ease of use.

Project Breakdown

1.Data Preparation
* Created a staging table (layoffs_staging) and copied all data from the main layoffs table.
* Used a Common Table Expression (CTE) to identify duplicates by grouping similar rows and assigning row numbers.

2. Deduplication Process
* Created a secondary staging table, layoffs_staging2, to store de-duplicated data.
* Removed duplicate entries by retaining only the first instance of each duplicate set.

3. Standardization of Data
* Trimmed white spaces from the company field.
* Consolidated variations of industry names, like unifying all “Crypto” entries under one label.
* Standardized country names (e.g., changing “United States of America” to “United States”).

4. Date Formatting
* Converted date entries to a standard DATE format using STR_TO_DATE to enhance readability and sorting.

5. Handling NULL Values
* Addressed NULL or empty values in critical fields like industry by updating entries based on company data when available.
* Deleted rows with NULL values in essential fields (total_laid_off and percentage_laid_off) to maintain data integrity.

6. Column Cleanup
* Removed the row_num column, which was only needed for the deduplication process.
