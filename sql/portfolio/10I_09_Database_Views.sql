-- ==========================================================
-- Project  : Bankruptcy Risk Prediction Platform
-- Module   : SQL Analytics
-- File     : 07I_09_Database_Views.sql
-- Database : PostgreSQL
-- Author   : Suvam Priyaranjan Sahoo
-- Purpose  : Create reusable SQL views for analytics,
--            dashboards, and reporting.
-- ==========================================================

SET search_path TO bankruptcy;

-- ==========================================================
-- View 1: Company Overview
-- ==========================================================
CREATE OR REPLACE VIEW vw_company_overview AS
SELECT
    company_name,
    year,
    status_label,
    X1,X2,X3,X4,X5
FROM company_financials;

-- ==========================================================
-- View 2: Yearly Summary
-- ==========================================================
CREATE OR REPLACE VIEW vw_yearly_summary AS
SELECT
    year,
    COUNT(*) AS total_companies,
    AVG(X1) AS avg_x1,
    AVG(X2) AS avg_x2,
    AVG(X3) AS avg_x3
FROM company_financials
GROUP BY year;

-- ==========================================================
-- View 3: High Financial Performance
-- ==========================================================
CREATE OR REPLACE VIEW vw_high_x1_companies AS
SELECT *
FROM company_financials
WHERE X1 > (
    SELECT AVG(X1) FROM company_financials
);

-- ==========================================================
-- View 4: Active Companies
-- ==========================================================
CREATE OR REPLACE VIEW vw_active_companies AS
SELECT *
FROM company_financials
WHERE status_label='alive';

-- ==========================================================
-- Verification Queries
-- ==========================================================
SELECT * FROM vw_company_overview LIMIT 10;
SELECT * FROM vw_yearly_summary;
SELECT * FROM vw_high_x1_companies LIMIT 10;
SELECT * FROM vw_active_companies LIMIT 10;
