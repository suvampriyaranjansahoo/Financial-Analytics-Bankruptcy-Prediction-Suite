"""Streamlit front end for a transparent financial distress screen."""
from pathlib import Path
import sys
import pandas as pd
import plotly.graph_objects as go
import streamlit as st

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from src.scoring import screen_company

st.set_page_config(page_title="Early-Warning Screener", page_icon="⚠️", layout="wide")
st.title("Bankruptcy Early-Warning Screener")
st.caption("An interpretable financial-distress screen for analyst review — not a lending or investment decision.")

@st.cache_data
def load_demo() -> pd.DataFrame:
    return pd.read_csv(ROOT / "data" / "sample_financials.csv")

with st.sidebar:
    st.header("Screening context")
    use_demo = st.toggle("Use included demonstration data", value=True)
    uploaded = None if use_demo else st.file_uploader("Upload annual financials CSV", type="csv")
    st.info("Amounts should use one consistent unit (for example, USD millions). The model uses ratios, so the unit itself does not affect the score.")

data = load_demo() if use_demo else (pd.read_csv(uploaded) if uploaded else None)
if data is None:
    st.stop()

required = {"company", "fiscal_year"}
if not required.issubset(data.columns):
    st.error("CSV must include company and fiscal_year. Download the sample template to match the full schema.")
    st.stop()

company = st.selectbox("Company", sorted(data.company.unique()))
company_data = data.loc[data.company.eq(company)].sort_values("fiscal_year")
year = st.selectbox("Fiscal year", company_data.fiscal_year.tolist(), index=len(company_data) - 1)
current = company_data.loc[company_data.fiscal_year.eq(year)].iloc[0].to_dict()
prior_rows = company_data.loc[company_data.fiscal_year.lt(year)]
prior = prior_rows.iloc[-1].to_dict() if not prior_rows.empty else None

try:
    result = screen_company(current, prior)
except ValueError as exc:
    st.error(f"Data-quality check: {exc}")
    st.stop()

band = result["altman_z_double_prime_band"]
color = {"Safe": "#00A878", "Grey": "#F4B942", "Distress": "#D94841"}[band]
st.markdown(f"<div style='padding:1rem 1.25rem;border-left:7px solid {color};background:#f6f8fa;border-radius:6px'><strong>{company} — {year}</strong><br>Overall Altman Z'' screen: <strong>{band.upper()}</strong>. Review the drivers below before making any decision.</div>", unsafe_allow_html=True)

c1, c2, c3, c4 = st.columns(4)
c1.metric("Altman Z", f"{result['altman_z_score']:.2f}", result["altman_z_band"])
c2.metric("Altman Z''", f"{result['altman_z_double_prime_score']:.2f}", result["altman_z_double_prime_band"])
c3.metric("Piotroski F", str(result.get("piotroski_f_score", "—")), result.get("piotroski_band", "Needs prior year"))
c4.metric("Current ratio", f"{result['current_ratio']:.2f}x")

left, right = st.columns([1.05, 1])
with left:
    st.subheader("Risk interpretation")
    st.write("**Altman Z:** below 1.81 = distress; 1.81–2.99 = grey; above 2.99 = safe.")
    st.write("**Altman Z'':** below 1.10 = distress; 1.10–2.60 = grey; above 2.60 = safe.")
    st.write("**Piotroski F:** 0–4 = weak; 5–7 = average; 8–9 = strong.")
    st.caption("Model applicability matters. Original Z was developed for public manufacturing firms. Z'' is provided as a complementary screen for other firms.")
with right:
    st.subheader("Core ratio profile")
    labels = ["Liquidity", "Leverage", "Profitability", "Cash flow"]
    values = [min(result["current_ratio"] / 2, 1.5), max(0, 1 - result["debt_to_assets"]), max(0, result["return_on_assets"] * 10), max(0, result["cash_flow_to_assets"] * 10)]
    fig = go.Figure(go.Bar(x=values, y=labels, orientation="h", marker_color="#215A8E"))
    fig.update_layout(height=270, margin=dict(l=10, r=10, t=10, b=10), xaxis_title="Normalised directional indicator", yaxis_title=None)
    st.plotly_chart(fig, use_container_width=True)

st.subheader("Analyst data sheet")
display_cols = ["revenue", "ebit", "net_income", "operating_cash_flow", "total_assets", "total_liabilities", "shareholders_equity", "market_capitalization"]
st.dataframe(pd.DataFrame({"Metric": display_cols, "Value": [current[x] for x in display_cols]}), hide_index=True, use_container_width=True)
with st.expander("Formula transparency"):
    st.code("Z = 1.2X₁ + 1.4X₂ + 3.3X₃ + 0.6X₄ + 1.0X₅\nZ'' = 6.56X₁ + 3.26X₂ + 6.72X₃ + 1.05X₄", language="text")
    st.write("See `docs/03_Methodology.md` for variable definitions and limitations.")

st.download_button("Download selected record", company_data.to_csv(index=False), f"{company}_{year}_financials.csv", "text/csv")
