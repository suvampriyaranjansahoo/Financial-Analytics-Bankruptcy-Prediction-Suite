# SQL analytical layer

Run `schema.sql`, load validated records into `company_financials`, then run `views.sql`. `queries.sql` creates a transparent distress-review queue. The schema uses SQLite types for portability; it can be adapted to PostgreSQL by replacing the import mechanism and adding roles/audit columns.
