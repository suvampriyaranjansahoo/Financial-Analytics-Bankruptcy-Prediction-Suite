-- ==========================================================
-- File: 07E_05_Exploratory_Data_Analysis.sql
-- Purpose: Business KPI & Exploratory Analysis
-- ==========================================================

SET search_path TO bankruptcy;

-- Total companies
SELECT COUNT(*) AS total_companies
FROM company_financials;

-- Company status distribution
SELECT
    status_label,
    COUNT(*) AS companies
FROM company_financials
GROUP BY status_label
ORDER BY companies DESC;

-- Records by year
SELECT
    year,
    COUNT(*) AS companies
FROM company_financials
GROUP BY year
ORDER BY year;

-- Average of financial indicators
SELECT
    AVG(X1) AS avg_x1,
    AVG(X2) AS avg_x2,
    AVG(X3) AS avg_x3,
    AVG(X4) AS avg_x4,
    AVG(X5) AS avg_x5
FROM company_financials;

-- Top companies by X1
SELECT
    company_name,
    year,
    X1
FROM company_financials
ORDER BY X1 DESC
LIMIT 10;

-- Bottom companies by X1
SELECT
    company_name,
    year,
    X1
FROM company_financials
ORDER BY X1 ASC
LIMIT 10;
