-- models/select_company_data.sql
 
WITH company_data AS (
    SELECT
        COMPANY_ID,
        COMPANY_NAME
    FROM
        "FINANCE_ECONOMICS"."CYBERSYN"."COMPANY_INDEX"
)
SELECT * 
FROM company_data;