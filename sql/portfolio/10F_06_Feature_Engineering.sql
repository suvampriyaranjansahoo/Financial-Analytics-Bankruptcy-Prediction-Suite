-- ==========================================================
-- File: 07F_06_Feature_Engineering.sql
-- Purpose: Create analytical features from financial variables
-- ==========================================================

SET search_path TO bankruptcy;

-- Liquidity Index
ALTER TABLE company_financials
ADD COLUMN IF NOT EXISTS liquidity_index NUMERIC;

UPDATE company_financials
SET liquidity_index = X1 / NULLIF(X2,0);

-- Profitability Index
ALTER TABLE company_financials
ADD COLUMN IF NOT EXISTS profitability_index NUMERIC;

UPDATE company_financials
SET profitability_index = X3 / NULLIF(X4,0);

-- Efficiency Index
ALTER TABLE company_financials
ADD COLUMN IF NOT EXISTS efficiency_index NUMERIC;

UPDATE company_financials
SET efficiency_index = X5;

-- Verify engineered features
SELECT
company_name,
year,
liquidity_index,
profitability_index,
efficiency_index
FROM company_financials
LIMIT 20;
