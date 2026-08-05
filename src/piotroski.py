"""Piotroski F-Score implementation requiring current and prior-year values."""
from __future__ import annotations

from .ratios import safe_divide


def piotroski_f_score(current: dict[str, float], prior: dict[str, float]) -> dict[str, int | str]:
    """Calculate the nine binary Piotroski signals (Piotroski, 2000)."""
    roa, prior_roa = safe_divide(current["net_income"], current["total_assets"]), safe_divide(prior["net_income"], prior["total_assets"])
    cfo = current["operating_cash_flow"]
    leverage, prior_leverage = safe_divide(current["long_term_debt"], current["total_assets"]), safe_divide(prior["long_term_debt"], prior["total_assets"])
    liquidity, prior_liquidity = safe_divide(current["current_assets"], current["current_liabilities"]), safe_divide(prior["current_assets"], prior["current_liabilities"])
    margin, prior_margin = safe_divide(current["gross_profit"], current["revenue"]), safe_divide(prior["gross_profit"], prior["revenue"])
    turnover, prior_turnover = safe_divide(current["revenue"], current["total_assets"]), safe_divide(prior["revenue"], prior["total_assets"])
    signals = {
        "f_roa_positive": int(roa > 0), "f_cfo_positive": int(cfo > 0), "f_roa_improving": int(roa > prior_roa),
        "f_accrual_quality": int(cfo > current["net_income"]), "f_leverage_decreasing": int(leverage < prior_leverage),
        "f_liquidity_improving": int(liquidity > prior_liquidity), "f_no_dilution": int(current["shares_outstanding"] <= prior["shares_outstanding"]),
        "f_margin_improving": int(margin > prior_margin), "f_turnover_improving": int(turnover > prior_turnover),
    }
    score = sum(signals.values())
    band = "Strong" if score >= 8 else "Average" if score >= 5 else "Weak"
    return {**signals, "piotroski_f_score": score, "piotroski_band": band}
