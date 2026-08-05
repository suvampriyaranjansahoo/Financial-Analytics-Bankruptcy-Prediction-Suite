.PHONY: install test screen run

install:
	python -m pip install -r requirements.txt

test:
	python -m pytest -q

screen:
	python -m src.pipeline --input data/sample_financials.csv --output data/processed/screened_companies.csv

run:
	streamlit run app/streamlit_app.py
