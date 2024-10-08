-- models/select_company_data.sql
 {{ config(materialized='view') }} -- Set to 'view' since we are working with a view in Snowflake

-- Log message to indicate the model execution has started
{{ log("Executing: select_company_data model", info=True) }}
 
WITH company_data AS (
    -- Log message to indicate the data extraction from the source table
    {{ log("Extracting data from FINANCE_ECONOMICS.CYBERSYN.COMPANY_INDEX", info=True) }}
    SELECT
        COMPANY_ID,
        COMPANY_NAME
    FROM
        "FINANCE_ECONOMICS"."CYBERSYN"."COMPANY_INDEX"
)
 
-- Log message to indicate the data selection is complete
{{ log("Selecting all records from company_data", info=True) }}
 
SELECT *
FROM company_data;