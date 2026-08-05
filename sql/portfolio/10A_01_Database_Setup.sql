-- ==========================================================
-- Project: Bankruptcy Risk Prediction Platform
-- File   : 07A_01_Database_Setup.sql
-- Database: PostgreSQL
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS bankruptcy;
SET search_path TO bankruptcy;

CREATE TABLE company_financials (
    company_id BIGSERIAL PRIMARY KEY,
    current_assets NUMERIC(18,4),
    current_liabilities NUMERIC(18,4),
    working_capital NUMERIC(18,4),
    retained_earnings NUMERIC(18,4),
    ebit NUMERIC(18,4),
    total_assets NUMERIC(18,4),
    total_liabilities NUMERIC(18,4),
    sales NUMERIC(18,4),
    equity NUMERIC(18,4),
    cash_flow NUMERIC(18,4),
    bankruptcy_label SMALLINT CHECK (bankruptcy_label IN (0,1)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prediction_history (
    prediction_id BIGSERIAL PRIMARY KEY,
    company_id BIGINT REFERENCES company_financials(company_id),
    bankruptcy_probability NUMERIC(6,4),
    predicted_class SMALLINT CHECK (predicted_class IN (0,1)),
    prediction_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    model_version VARCHAR(50)
);

CREATE TABLE model_metadata (
    model_id BIGSERIAL PRIMARY KEY,
    model_name VARCHAR(100),
    model_version VARCHAR(50),
    algorithm VARCHAR(100),
    training_date DATE,
    accuracy NUMERIC(5,2),
    precision_score NUMERIC(5,2),
    recall_score NUMERIC(5,2),
    f1_score NUMERIC(5,2),
    roc_auc NUMERIC(5,2)
);

CREATE TABLE batch_prediction_logs (
    batch_id BIGSERIAL PRIMARY KEY,
    file_name VARCHAR(255),
    total_records INTEGER,
    processed_records INTEGER,
    failed_records INTEGER,
    execution_time_seconds NUMERIC(10,2),
    execution_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_company_bankruptcy ON company_financials(bankruptcy_label);
CREATE INDEX idx_prediction_company ON prediction_history(company_id);
