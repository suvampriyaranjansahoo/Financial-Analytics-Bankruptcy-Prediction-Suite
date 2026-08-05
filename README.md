# Bankruptcy Early-Warning Screener

[![CI](https://github.com/suvampriyaranjansahoo/bankruptcy-early-warning-screener/actions/workflows/ci.yml/badge.svg)](https://github.com/suvampriyaranjansahoo/bankruptcy-early-warning-screener/actions/workflows/ci.yml)
![Python](https://img.shields.io/badge/Python-3.11%2B-3776AB?logo=python&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-dashboard-FF4B4B?logo=streamlit&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

An analyst-first financial-distress screening tool that combines interpretable accounting signals with an optional machine-learning probability. It is designed to support credit, equity-research, and due-diligence workflows—not to replace professional judgement.

## Why it matters

Financial distress is usually visible in the statements before it becomes headline news. The screener converts a compact set of balance-sheet, income-statement, and cash-flow inputs into:

- **Altman Z-Score** — a capital-structure and operating-performance risk signal.
- **Altman Z''-Score** — the non-manufacturing/private-company variant.
- **Piotroski F-Score** — a nine-signal financial-strength framework.
- **ML risk probability** — optional, calibrated from a labelled dataset after local training.

## Product preview

The Streamlit app gives senior analysts a concise credit memo view: risk band, scorecard, ratio drivers, data-quality checks, and a plain-English interpretation. It deliberately presents model outputs as screening signals and exposes the underlying formulas.

## Quick start

```bash
git clone https://github.com/suvampriyaranjansahoo/bankruptcy-early-warning-screener.git
cd bankruptcy-early-warning-screener
python -m venv .venv
# Windows: .venv\Scripts\activate
pip install -r requirements.txt
streamlit run app/streamlit_app.py
```

Run checks:

```bash
pytest -q
python -m src.pipeline --input data/sample_financials.csv --output data/processed/screened_companies.csv
```

## Repository guide

| Path | Purpose |
|---|---|
| `app/` | Deployment-ready Streamlit application |
| `src/` | Reusable scoring, ratios, validation, ML, and batch pipeline |
| `data/sample_financials.csv` | Synthetic, safe-to-share demonstration dataset |
| `sql/` | SQLite-compatible analytical schema and views |
| `docs/` | Methodology, governance, data dictionary, and deployment notes |
| `tests/` | Formula and pipeline tests |

## ML workflow

The repository intentionally does **not** ship a fitted model. Put an approved labelled dataset in `data/raw/` with a `bankrupt` target, then run:

```bash
python -m src.train --input data/raw/your_labelled_data.csv --model-out models/risk_model.joblib
```

The app automatically uses `models/risk_model.joblib` when present; otherwise it remains a transparent score-based screener.

## Responsible use

This tool is an early-warning aid, not a bankruptcy determination, credit decision, investment recommendation, or audit opinion. Validate inputs against filings, consider industry and macro conditions, and apply independent review before a material decision. See [Model governance](docs/07_Model_Governance.md).

## Sources and methodology

See [Methodology](docs/03_Methodology.md), [Data Dictionary](docs/04_Data_Dictionary.md), and [References](docs/References.md). The included sample data is synthetic and should not be interpreted as actual company financials.

## License

MIT — see [LICENSE](LICENSE).
