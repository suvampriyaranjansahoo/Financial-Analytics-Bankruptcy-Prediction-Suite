-- ==========================================================
-- Project  : Bankruptcy Risk Prediction Platform
-- Module   : SQL Analytics
-- File     : 07J_10_Stored_Procedures_and_Functions.sql
-- Database : PostgreSQL
-- Author   : Suvam Priyaranjan Sahoo
-- Purpose  : Create reusable procedures and functions.
-- ==========================================================

SET search_path TO bankruptcy;

-- ==========================================================
-- Procedure 1: Insert Prediction History
-- ==========================================================
CREATE OR REPLACE PROCEDURE sp_insert_prediction_history(
    p_company_name TEXT,
    p_year INT,
    p_prediction VARCHAR,
    p_probability NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO prediction_history
    (company_name, prediction_year, prediction_label, probability)
    VALUES
    (p_company_name, p_year, p_prediction, p_probability);
END;
$$;

-- ==========================================================
-- Procedure 2: Company Prediction History
-- ==========================================================
CREATE OR REPLACE PROCEDURE sp_get_company_history(
    p_company_name TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Prediction history for %', p_company_name;
END;
$$;

-- ==========================================================
-- Function: Bankruptcy Rate
-- ==========================================================
CREATE OR REPLACE FUNCTION fn_bankruptcy_rate()
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    rate NUMERIC;
BEGIN
    SELECT ROUND(
        100.0 * SUM(CASE WHEN status_label <> 'alive' THEN 1 ELSE 0 END) / COUNT(*),
        2
    )
    INTO rate
    FROM company_financials;

    RETURN rate;
END;
$$;

-- ==========================================================
-- Verification
-- ==========================================================
CALL sp_insert_prediction_history(
    'ABC Industries',
    2025,
    'Bankrupt',
    0.93
);

SELECT fn_bankruptcy_rate();
