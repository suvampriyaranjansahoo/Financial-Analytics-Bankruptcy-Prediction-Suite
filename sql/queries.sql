-- Priority review queue: companies in the original Altman distress zone.
SELECT company, fiscal_year, ROUND(altman_z_score, 2) AS altman_z_score,
       ROUND(current_ratio, 2) AS current_ratio, ROUND(debt_to_assets, 2) AS debt_to_assets
FROM vw_financial_health
WHERE altman_z_score < 1.81
ORDER BY altman_z_score ASC;
