# PostgreSQL analysis portfolio

These numbered scripts document the original SQL workflow and are intended for PostgreSQL. Run them in order against a controlled local database after reviewing table names, CSV paths, and credentials.

| Order | Script | Focus |
|---:|---|---|
| 1 | `10A_01_Database_Setup.sql` | Database and base-table setup |
| 2 | `10B_02_Data_Import.sql` | Data import |
| 3 | `10C_03_Data_Quality_Check_Actual_Dataset.sql` | Quality checks |
| 4 | `10D_04_Data_Cleaning.sql` | Cleaning |
| 5 | `10E_05_Exploratory_Data_Analysis.sql` | EDA |
| 6 | `10F_06_Feature_Engineering.sql` | Feature engineering |
| 7 | `10G_07_Window_Functions.sql` | Window-function analysis |
| 8 | `10H_08_CTEs_and_Subqueries.sql` | CTEs and subqueries |
| 9 | `10I_09_Database_Views.sql` | Analytical views |
| 10 | `10J_10_Stored_Procedures_and_Functions.sql` | Stored procedures/functions |
| 11 | `10K_11_SQL_Interview_Portfolio.sql` | Interview-ready analytical queries |

The simpler SQLite-compatible schema in the parent `sql/` directory supports the deployable screening demo. This PostgreSQL portfolio is a separate, deeper data-analytics implementation.
