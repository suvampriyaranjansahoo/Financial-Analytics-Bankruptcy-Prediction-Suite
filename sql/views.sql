CREATE VIEW IF NOT EXISTS vw_financial_health AS
SELECT
    company, fiscal_year,
    current_assets / current_liabilities AS current_ratio,
    total_liabilities / total_assets AS debt_to_assets,
    net_income / total_assets AS return_on_assets,
    operating_cash_flow / total_assets AS cash_flow_to_assets,
    1.2 * ((current_assets - current_liabilities) / total_assets)
      + 1.4 * (retained_earnings / total_assets)
      + 3.3 * (ebit / total_assets)
      + 0.6 * (market_capitalization / total_liabilities)
      + (revenue / total_assets) AS altman_z_score
FROM company_financials;
