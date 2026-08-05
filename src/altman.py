"""Altman Z and Z'' score implementations with explicit applicability labels."""
from __future__ import annotations

from .ratios import safe_divide


def risk_band_z(score: float) -> str:
    if score < 1.81:
        return "Distress"
    if score <= 2.99:
        return "Grey"
    return "Safe"


def risk_band_z_double_prime(score: float) -> str:
    if score < 1.10:
        return "Distress"
    if score <= 2.60:
        return "Grey"
    return "Safe"


def altman_z(financials: dict[str, float]) -> dict[str, float | str]:
    """Original public-manufacturing Z score (Altman, 1968)."""
    ta = financials["total_assets"]
    terms = {
        "x1_working_capital_to_assets": safe_divide(financials["current_assets"] - financials["current_liabilities"], ta),
        "x2_retained_earnings_to_assets": safe_divide(financials["retained_earnings"], ta),
        "x3_ebit_to_assets": safe_divide(financials["ebit"], ta),
        "x4_market_equity_to_liabilities": safe_divide(financials["market_capitalization"], financials["total_liabilities"]),
        "x5_sales_to_assets": safe_divide(financials["revenue"], ta),
    }
    score = 1.2 * terms["x1_working_capital_to_assets"] + 1.4 * terms["x2_retained_earnings_to_assets"] + 3.3 * terms["x3_ebit_to_assets"] + 0.6 * terms["x4_market_equity_to_liabilities"] + terms["x5_sales_to_assets"]
    return {**terms, "altman_z_score": score, "altman_z_band": risk_band_z(score)}


def altman_z_double_prime(financials: dict[str, float]) -> dict[str, float | str]:
    """Z'' score for non-manufacturing/private-company screening."""
    ta = financials["total_assets"]
    x1 = safe_divide(financials["current_assets"] - financials["current_liabilities"], ta)
    x2 = safe_divide(financials["retained_earnings"], ta)
    x3 = safe_divide(financials["ebit"], ta)
    x4 = safe_divide(financials["shareholders_equity"], financials["total_liabilities"])
    score = 6.56 * x1 + 3.26 * x2 + 6.72 * x3 + 1.05 * x4
    return {"altman_z_double_prime_score": score, "altman_z_double_prime_band": risk_band_z_double_prime(score)}
