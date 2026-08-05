# Bankruptcy dataset files

These versioned CSV files support reproducible EDA, SQL analysis, and machine-learning experiments.

| File | Description |
|---|---|
| `american_bankruptcy.csv` | Original dataset used as the raw analytical starting point. |
| `american_bankruptcy_cleaned.csv` | Dataset after cleaning and quality processing. |
| `american_bankruptcy_model_ready.csv` | Final model input with `status_label`, `year`, and `X1`–`X18`. |

The fields `X1`–`X18` are anonymised in the underlying dataset. The files are included for portfolio reproducibility; do not use the data for decisions about a real company without establishing provenance, licensing, and fitness for purpose.
