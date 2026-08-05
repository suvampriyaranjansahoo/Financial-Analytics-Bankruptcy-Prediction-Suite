"""Input checks that prevent misleading score calculations."""
from __future__ import annotations

REQUIRED_FIELDS = ("company", "fiscal_year", "revenue", "gross_profit", "ebit", "net_income", "operating_cash_flow", "current_assets", "current_liabilities", "cash_and_equivalents", "inventory", "total_assets", "total_liabilities", "shareholders_equity", "retained_earnings", "long_term_debt", "market_capitalization", "shares_outstanding")


def validate_financials(record: dict) -> list[str]:
    errors = [f"Missing {field}" for field in REQUIRED_FIELDS if field not in record or record[field] is None]
    for field in ("total_assets", "total_liabilities", "current_liabilities"):
        if field in record and float(record[field]) <= 0:
            errors.append(f"{field} must be positive")
    if "shareholders_equity" in record and abs(float(record["shareholders_equity"]) - (float(record["total_assets"]) - float(record["total_liabilities"]))) > 1.0:
        errors.append("Balance-sheet check failed: assets less liabilities differs materially from equity")
    return errors
