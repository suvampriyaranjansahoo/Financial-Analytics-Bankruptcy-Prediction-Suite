SET search_path TO bankruptcy;

-- Remove duplicates
DELETE FROM company_financials a
USING company_financials b
WHERE a.company_id>b.company_id
AND a.company_name=b.company_name
AND a.year=b.year;

-- Trim text
UPDATE company_financials
SET company_name=TRIM(company_name),
    status_label=TRIM(status_label);

-- Fill NULLs for X1 with median
UPDATE company_financials
SET X1=(SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY X1) FROM company_financials)
WHERE X1 IS NULL;

SELECT COUNT(*) FROM company_financials;
