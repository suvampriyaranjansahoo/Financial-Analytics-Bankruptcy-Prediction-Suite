# Bankruptcy Risk Prediction Platform

An end-to-end machine learning system that predicts company bankruptcy risk from historical financial statements — covering data engineering, model comparison, explainability, and a PostgreSQL analytics layer.

## Business Problem

Roughly 6.6% of companies in this dataset went bankrupt. Catching that risk early — using nothing but a company's own reported financials — supports lending, investment, and credit-risk decisions before the outcome becomes obvious. This project builds and honestly evaluates that early-warning system.

## Dataset

- **78,682** company-year records, **1999-2018**
- **18 anonymized financial features** (X1-X18) per company-year
- Target: `status_label` — **alive** (73,462) vs. **failed** (5,220)

![Class Distribution](readme_assets/eda_class_distribution.png)

The failure rate isn't constant over time — it spikes in specific years, consistent with real economic cycles:

![Bankruptcy Rate by Year](readme_assets/eda_failure_rate_by_year.png)

Financial features are correlated in expected ways (several strong clusters), which is one reason tree-based models outperform plain logistic regression here:

![Correlation Heatmap](readme_assets/eda_correlation_heatmap.png)

## Model Comparison

Six models were trained and evaluated on an identical 80/20 stratified split (`random_state=42`):

![Model Comparison](readme_assets/model_comparison_roc_auc.png)

| Model | Accuracy | Precision | Recall | F1 | ROC-AUC |
|---|---|---|---|---|---|
| **XGBoost** | 83.3% | 23.7% | 68.7% | **35.3%** | **85.7%** |
| LightGBM | 81.0% | 21.6% | 70.6% | 33.1% | 85.4% |
| Random Forest | 86.8% | 25.4% | 51.4% | 34.0% | 83.5% |
| CatBoost | 75.9% | 17.9% | 73.6% | 28.8% | 83.4% |
| SVM (RBF)* | 44.9% | 9.3% | 84.0% | 16.8% | 68.3% |
| Logistic Regression | 56.2% | 9.9% | 69.2% | 17.3% | 65.9% |

*SVM trained on a stratified 20k-row subsample of the training set — RBF + probability estimates don't scale to 63k rows in reasonable time, a real constraint rather than a shortcut.

**XGBoost was selected as the production model** — best ROC-AUC and F1, with a meaningfully better recall/precision balance than the linear baseline.

**Honest interpretation:** the model catches roughly 2 out of 3 real bankruptcies (69% recall) with a moderate false-alarm rate — about 1 in 4 "at risk" flags are real (24% precision). That makes it a strong triage tool for narrowing which companies deserve closer manual review, not a stand-alone verdict.

## Explainability (SHAP)

Global feature impact across the test set — which financial variables push predictions toward bankruptcy risk:

![SHAP Summary](readme_assets/shap_global_summary.png)

Ranked by average impact on the model's output:

![SHAP Feature Importance](readme_assets/shap_global_importance_bar.png)

Local explanation for one company the model correctly flagged as high-risk, showing exactly which features drove that individual prediction:

![SHAP Waterfall](readme_assets/shap_waterfall_failed_company.png)

*Note: X1-X18 are anonymized in the source data (no official column dictionary). Feature impact is reported by code (X6, X8, etc.) rather than a business name, to avoid asserting a mapping that isn't confirmed.*

## Tech Stack

- **Python** — pandas, scikit-learn, XGBoost, LightGBM, CatBoost, SHAP
- **SQL (PostgreSQL)** — schema design, data cleaning, feature engineering, window functions, CTEs, views, stored procedures (10-part portfolio in `/sql`)
- **Power BI** — executive, financial analysis, and prediction dashboards
- **FastAPI + Streamlit** — REST API and interactive web app for serving predictions
- **Docker** — containerized deployment

## Project Structure
```
├── notebooks/          # EDA, model training, tuning, explainability
├── sql/                 # 10-part PostgreSQL portfolio (schema → stored procedures)
├── models/              # Serialized production model (XGBoost)
├── dashboards/          # Power BI files
├── api/                 # FastAPI + Streamlit deployment
└── readme_assets/       # Charts used in this README
```

## Key Findings

- XGBoost outperforms both linear and other tree-based models on this dataset, at a practical (not marginal) margin over the logistic regression baseline
- The dataset is heavily imbalanced (~6.6% failure rate) — accuracy alone is a misleading metric here, which is why the model was selected on ROC-AUC and F1 instead
- SHAP explainability confirms the model's flagged risk factors are consistent and stable across companies, not noise
- SQL layer is fully normalized and reproducible: schema creation → import → cleaning → feature engineering → analytics → stored procedures, runnable end-to-end against PostgreSQL

## Limitations

- Financial features are anonymized (X1-X18), which limits how precisely findings can be explained in business terms
- SVM results are based on a training subsample, not the full dataset, due to computational cost
- No macroeconomic or industry-sector variables are included — bankruptcy risk here is inferred from financials alone
