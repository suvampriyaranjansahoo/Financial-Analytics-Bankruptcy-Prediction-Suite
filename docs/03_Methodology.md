# Methodology

## Financial ratios

Inputs are annual, company-level financial-statement values on a consistent basis and currency unit. The pipeline calculates liquidity, leverage, margin, return-on-assets, turnover, and cash-flow ratios. A zero denominator returns a missing value instead of an artificial ratio.

## Altman models

The original Z-Score is `1.2X1 + 1.4X2 + 3.3X3 + 0.6X4 + X5`, where X1 is working capital/assets, X2 retained earnings/assets, X3 EBIT/assets, X4 market value of equity/liabilities, and X5 sales/assets. Its standard thresholds are distress `<1.81`, grey `1.81–2.99`, and safe `>2.99`.

Z'' is `6.56X1 + 3.26X2 + 6.72X3 + 1.05X4`, using book equity/liabilities for X4. Thresholds used here are distress `<1.10`, grey `1.10–2.60`, and safe `>2.60`.

These are screening models, not universal bankruptcy probabilities. Applicability depends on sector, accounting regime, and firm type.

## Piotroski F-Score

Nine binary signals evaluate profitability, cash generation, change in ROA, accrual quality, leverage, liquidity, dilution, gross margin, and asset turnover. The prior year is required. Scores 0–4 are weak, 5–7 average, and 8–9 strong.
