# Bankruptcy Early-Warning Screener

![Python](https://img.shields.io/badge/Python-3.11%2B-3776AB?logo=python&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-dashboard-FF4B4B?logo=streamlit&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

An analyst-first financial-distress screening project that combines financial-statement analysis, interpretable bankruptcy models, and machine-learning experimentation. It supports credit, equity-research, and due-diligence workflows; it is not a substitute for professional judgement.

## Business problem

Financial distress is often visible in company financial statements before it becomes obvious externally. This project turns annual financial inputs into a transparent, prioritised review workflow using:

- **Altman Z-Score** — capital structure and operating-performance signal.
- **Altman Z''-Score** — complementary non-manufacturing/private-company screen.
- **Piotroski F-Score** — nine financial-strength signals.
- **Machine-learning models** — comparative bankruptcy-risk research using labelled data.

## Dataset

The project uses an American Bankruptcy dataset with **78,682 company-year records** from **1999–2018**, 18 anonymised financial variables, and a binary status label. The observed failure rate is approximately 6.6%.

Because the fields are anonymised, model feature names are kept as `X1`–`X18`; no unsupported financial-statement mapping is asserted.

## Model evaluation

The existing project experiments compare Logistic Regression, Random Forest, XGBoost, LightGBM, CatBoost, and SVM. For an imbalanced bankruptcy target, evaluation should focus on recall, precision, F1, ROC-AUC, PR-AUC, and calibration—not accuracy alone.

Any published production result must clearly state its training period, target definition, validation method, and model version.

## Quick start

```bash
git clone https://github.com/suvampriyaranjansahoo/Financial-Analytics-Bankruptcy-Prediction-Suite.git
cd Financial-Analytics-Bankruptcy-Prediction-Suite
python -m venv .venv
# Windows: .venv\Scripts\activate
pip install -r requirements.txt
streamlit run app/streamlit_app.py
```

Run the automated checks and sample batch screen:

```bash
pytest -q
python -m src.pipeline --input data/sample_financials.csv --output data/processed/screened_companies.csv
```

## Repository guide

| Path | Purpose |
|---|---|
| `app/` | Streamlit analyst dashboard |
| `src/` | Scoring, validation, batch pipeline, and ML training utilities |
| `data/` | Safe sample data plus ignored raw/processed folders |
| `sql/` | SQLite-compatible analytical schema and views |
| `docs/` | Methodology, data dictionary, governance, and deployment guidance |
| `tests/` | Formula and pipeline tests |
| `notebooks/` | EDA, modelling, explainability, and model-comparison workbooks |

## Deployment

The Streamlit app can be deployed with Streamlit Community Cloud using `app/streamlit_app.py`, or with Docker:

```bash
docker build -t bankruptcy-screener .
docker run -p 8501:8501 bankruptcy-screener
```

See [deployment guidance](docs/08_Deployment.md) and [model governance](docs/07_Model_Governance.md).

## Responsible use

This is an early-warning and research tool, not a bankruptcy determination, credit decision, investment recommendation, or audit opinion. Validate source data, apply sector context, consider macroeconomic conditions, and require human review before a material decision.

## References

- Altman, E. I. (1968). *Financial Ratios, Discriminant Analysis and the Prediction of Corporate Bankruptcy*.
- Piotroski, J. D. (2000). *Value Investing: The Use of Historical Financial Statement Information to Separate Winners from Losers*.
- U.S. Securities and Exchange Commission, EDGAR filing database.

## License

MIT — see [LICENSE](LICENSE).
