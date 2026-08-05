-- ==========================================================
-- File: 07B_02_Data_Import.sql
-- Purpose: Import cleaned bankruptcy dataset into PostgreSQL
-- ==========================================================

SET search_path TO bankruptcy;

-- Option 1: Using PostgreSQL COPY (recommended)
COPY company_financials(
    current_assets,
    current_liabilities,
    working_capital,
    retained_earnings,
    ebit,
    total_assets,
    total_liabilities,
    sales,
    equity,
    cash_flow,
    bankruptcy_label
)
FROM '/path/to/american_bankruptcy_cleaned.csv'
DELIMITER ','
CSV HEADER;

-- Verify import
SELECT COUNT(*) AS total_records
FROM company_financials;

-- Preview data
SELECT *
FROM company_financials
LIMIT 10;
