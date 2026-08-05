"""Single-company, explainable financial distress screening service."""
from __future__ import annotations

from .altman import altman_z, altman_z_double_prime
from .piotroski import piotroski_f_score
from .ratios import calculate_ratios
from .validation import validate_financials


def screen_company(current: dict, prior: dict | None = None) -> dict:
    errors = validate_financials(current)
    if errors:
        raise ValueError("; ".join(errors))
    result = {"company": current["company"], "fiscal_year": current["fiscal_year"]}
    result.update(calculate_ratios(current))
    result.update(altman_z(current))
    result.update(altman_z_double_prime(current))
    if prior:
        result.update(piotroski_f_score(current, prior))
    return result
