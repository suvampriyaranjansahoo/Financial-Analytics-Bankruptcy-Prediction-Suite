# Python pipeline

`src.pipeline` reads annual financial data, validates each company-year, calculates ratios and both Altman models, and calculates Piotroski signals where a previous year exists. It writes a compact screening output that can feed a dashboard or database.

Keep raw source data outside Git. The `.gitignore` retains only a safe sample dataset and empty folder markers.
