# Data policy and reproducibility

The original work uses three local files, which are intentionally excluded from Git because raw financial datasets can carry redistribution restrictions and make repositories heavy:

| Local file | Purpose |
|---|---|
| `american_bankruptcy.csv` | Original source extract |
| `american_bankruptcy_cleaned.csv` | Cleaned analytical dataset |
| `american_bankruptcy_model_ready.csv` | Model-ready dataset with target and `X1`–`X18` features |

Place approved versions under `data/raw/` or `data/processed/` when reproducing the analysis. Do not commit raw records, credentials, or models without confirming that redistribution is permitted.

`data/sample_financials.csv` is synthetic and safe to use in the Streamlit demo.
