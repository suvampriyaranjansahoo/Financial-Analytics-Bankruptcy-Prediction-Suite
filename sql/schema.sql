-- SQLite-compatible analytical store. Monetary fields use a consistent reporting unit.
CREATE TABLE IF NOT EXISTS company_financials (
    company TEXT NOT NULL,
    fiscal_year INTEGER NOT NULL,
    revenue REAL NOT NULL,
    gross_profit REAL NOT NULL,
    ebit REAL NOT NULL,
    net_income REAL NOT NULL,
    operating_cash_flow REAL NOT NULL,
    current_assets REAL NOT NULL,
    current_liabilities REAL NOT NULL,
    cash_and_equivalents REAL NOT NULL,
    inventory REAL NOT NULL,
    total_assets REAL NOT NULL CHECK(total_assets > 0),
    total_liabilities REAL NOT NULL CHECK(total_liabilities > 0),
    shareholders_equity REAL NOT NULL,
    retained_earnings REAL NOT NULL,
    long_term_debt REAL NOT NULL,
    market_capitalization REAL NOT NULL,
    shares_outstanding REAL NOT NULL,
    PRIMARY KEY (company, fiscal_year)
);
