# Results and evidence

The notebook portfolio contains the executed EDA, data preparation, model-comparison, explainability, and validation work for the American Bankruptcy dataset (78,682 company-year records, 1999–2018, approximately 6.6% failed observations).

The documented model-comparison experiment used a stratified 80/20 split with `random_state=42`. The retained portfolio results identify XGBoost as the preferred research model, with reported ROC-AUC of 85.7%, recall of 68.7%, precision of 23.7%, and F1 of 35.3%. These metrics should be interpreted in the context of the highly imbalanced target: the model is suited to triage, not an autonomous decision.

Reproduce and challenge every result before using it operationally. A production evaluation should use time-aware out-of-sample validation and report recall for distress cases, precision, ROC-AUC, PR-AUC, calibration, confusion matrices, and results by material segment.
