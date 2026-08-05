-- ==========================================================
-- File: 07C_03_Data_Quality_Check.sql
-- Purpose: Data Quality Validation (Actual Dataset)
-- ==========================================================

SET search_path TO bankruptcy;

SELECT COUNT(*) AS total_records FROM company_financials;

SELECT *
FROM (
SELECT company_name, year, COUNT(*) AS duplicate_count
FROM company_financials
GROUP BY company_name, year
HAVING COUNT(*) > 1
) d;

SELECT
SUM(CASE WHEN company_name IS NULL THEN 1 ELSE 0 END) AS missing_company_name,
SUM(CASE WHEN status_label IS NULL THEN 1 ELSE 0 END) AS missing_status,
SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year
FROM company_financials;

SELECT status_label, COUNT(*)
FROM company_financials
GROUP BY status_label;

SELECT
MIN(year) AS min_year,
MAX(year) AS max_year
FROM company_financials;
