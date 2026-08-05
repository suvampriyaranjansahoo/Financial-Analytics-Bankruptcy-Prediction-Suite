"""Reproducible baseline ML training for a labelled, approved dataset."""
from __future__ import annotations
import argparse
import joblib
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.impute import SimpleImputer
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

FEATURES = ["current_ratio", "quick_ratio", "debt_to_assets", "debt_to_equity", "operating_margin", "net_margin", "return_on_assets", "asset_turnover", "cash_flow_to_assets"]

def train(input_path: str, model_out: str) -> None:
    df = pd.read_csv(input_path)
    if "bankrupt" not in df:
        raise ValueError("Training data must contain a binary 'bankrupt' column.")
    missing = set(FEATURES) - set(df.columns)
    if missing:
        raise ValueError(f"Training data is missing engineered features: {sorted(missing)}")
    model = Pipeline([("prepare", ColumnTransformer([("numeric", Pipeline([("impute", SimpleImputer(strategy="median")), ("scale", StandardScaler())]), FEATURES)])), ("model", LogisticRegression(class_weight="balanced", max_iter=2000, random_state=42))])
    model.fit(df[FEATURES], df["bankrupt"])
    joblib.dump({"model": model, "features": FEATURES, "trained_rows": len(df)}, model_out)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True); parser.add_argument("--model-out", required=True)
    args = parser.parse_args(); train(args.input, args.model_out)
