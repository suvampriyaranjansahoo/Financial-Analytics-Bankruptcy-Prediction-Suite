# Analysis notebook guide

This folder contains the executed analytical notebooks used to build the project. They are retained as an auditable portfolio record; the deployable application is deliberately separated in `app/` and `src/`.

## Recommended review order

| Phase | Notebooks | What it demonstrates |
|---|---|---|
| Data understanding | `01_Data_Understanding`, `01_Data_Profiling_Executed`, `02_Data_Quality_Assessment` | Dataset structure, types, completeness, and data-quality checks |
| Exploratory analysis | `03A_Univariate_EDA_Executed`, `03B_Bivariate_EDA_Executed`, `03C_Correlation_Outlier_Analysis_Executed`, `03D_Time_Trends_Executive_Insights_Executed` | Distribution, relationship, outlier, correlation, and time-trend analysis |
| Business analysis | `04_Business_Insights_Executive_Report_Executed` | Analyst-facing findings and recommendations |
| Data preparation | `04_Data_Cleaning_and_Preprocessing`, `05A`–`05G` | Cleaning, target encoding, splits, missing values, feature engineering, scaling, feature selection, imbalance handling, and preprocessing pipelines |
| Modelling | `06A`–`06J` | Baseline through final-model selection, including Logistic Regression, Decision Tree, Random Forest, XGBoost, LightGBM, CatBoost, and SVM |
| Explainability | `07A`–`07D` | Global and local SHAP, LIME, and executive explainability reporting |
| Validation | `08A`, `08C`–`08G` | Learning curves, calibration, errors, robustness, cross-validation, and fairness checks |
| Deployment research | `09A`–`09H` | Serialization, batch scoring, API, Streamlit, Docker, monitoring, and end-to-end demonstration |

## Notes for reviewers

- Files labelled `Executed` preserve outputs from the original analysis. They are useful evidence but should be rerun after a change to data, dependencies, or methodology.
- A small number of notebooks are alternative/professional/rebuilt variants of the same step. Treat the latest named version as the preferred portfolio artefact and use the other versions as implementation history.
- The source dataset has anonymised fields (`X1`–`X18`). Do not infer accounting definitions without a verified source data dictionary.
- Raw, cleaned, and model-ready datasets are excluded from version control to avoid publishing licensed or sensitive data. See `data/README.md` for the expected local files.
