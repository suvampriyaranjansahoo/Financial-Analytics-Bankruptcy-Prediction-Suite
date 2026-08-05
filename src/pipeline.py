"""Batch screening command: python -m src.pipeline --input file.csv --output output.csv."""
from __future__ import annotations
import argparse
import pandas as pd
from .scoring import screen_company


def run(input_path: str, output_path: str) -> pd.DataFrame:
    data = pd.read_csv(input_path).sort_values(["company", "fiscal_year"])
    records = []
    for company, group in data.groupby("company", sort=False):
        rows = group.to_dict("records")
        for i, current in enumerate(rows):
            records.append(screen_company(current, rows[i - 1] if i else None))
    output = pd.DataFrame(records)
    output.to_csv(output_path, index=False)
    return output


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Screen company financial statements for distress signals.")
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    run(args.input, args.output)
