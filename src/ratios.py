"""Defensive financial-ratio calculations used by the screening models."""
from __future__ import annotations

import math
from typing import Mapping


def safe_divide(numerator: float, denominator: float) -> float:
    """Return NaN rather than raising or silently substituting for a zero denominator."""
    if denominator is None or numerator is None or denominator == 0:
        return math.nan
    return float(numerator) / float(denominator)


def calculate_ratios(financials: Mapping[str, float]) -> dict[str, float]:
    """Calculate core accounting ratios from standard annual-statement fields."""
    get = lambda key: float(financials.get(key, math.nan))
    current_assets, current_liabilities = get("current_assets"), get("current_liabilities")
    cash, inventory = get("cash_and_equivalents"), get("inventory")
    assets, liabilities, equity = get("total_assets"), get("total_liabilities"), get("shareholders_equity")
    revenue, ebit, net_income, ocf = get("revenue"), get("ebit"), get("net_income"), get("operating_cash_flow")
    return {
        "working_capital": current_assets - current_liabilities,
        "current_ratio": safe_divide(current_assets, current_liabilities),
        "quick_ratio": safe_divide(current_assets - inventory, current_liabilities),
        "cash_ratio": safe_divide(cash, current_liabilities),
        "debt_to_assets": safe_divide(liabilities, assets),
        "debt_to_equity": safe_divide(liabilities, equity),
        "equity_ratio": safe_divide(equity, assets),
        "operating_margin": safe_divide(ebit, revenue),
        "net_margin": safe_divide(net_income, revenue),
        "return_on_assets": safe_divide(net_income, assets),
        "asset_turnover": safe_divide(revenue, assets),
        "cash_flow_to_assets": safe_divide(ocf, assets),
    }
