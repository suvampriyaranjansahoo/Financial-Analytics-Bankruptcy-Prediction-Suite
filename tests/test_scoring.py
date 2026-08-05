import pytest
from src.altman import altman_z, altman_z_double_prime
from src.piotroski import piotroski_f_score
from src.scoring import screen_company


@pytest.fixture
def healthy():
    return {"company": "Test Co", "fiscal_year": 2024, "revenue": 2570, "gross_profit": 860, "ebit": 180, "net_income": 109, "operating_cash_flow": 198, "current_assets": 840, "current_liabilities": 520, "cash_and_equivalents": 185, "inventory": 295, "total_assets": 1790, "total_liabilities": 900, "shareholders_equity": 890, "retained_earnings": 505, "long_term_debt": 330, "market_capitalization": 2600, "shares_outstanding": 93}


def test_z_scores_return_safe_for_strong_profile(healthy):
    assert altman_z(healthy)["altman_z_band"] == "Safe"
    assert altman_z_double_prime(healthy)["altman_z_double_prime_band"] == "Safe"


def test_piotroski_contains_nine_signals(healthy):
    prior = {**healthy, "net_income": 82, "operating_cash_flow": 156, "current_assets": 760, "current_liabilities": 510, "total_assets": 1680, "long_term_debt": 360, "gross_profit": 780, "revenue": 2400, "shares_outstanding": 95}
    output = piotroski_f_score(healthy, prior)
    assert output["piotroski_f_score"] == 9


def test_balance_sheet_validation_rejects_bad_input(healthy):
    bad = {**healthy, "shareholders_equity": 100}
    with pytest.raises(ValueError, match="Balance-sheet"):
        screen_company(bad)
