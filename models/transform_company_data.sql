

WITH raw_company_data AS (
    -- Select the raw data from the select_company_data model
    SELECT
        COMPANY_ID,
        TRIM(COMPANY_NAME) AS COMPANY_NAME -- Trim any extra spaces from the company name
    FROM {{ ref('select_company_data') }} -- Referencing the select_company_data model
)
 
-- Apply transformations
SELECT 
    COMPANY_ID,
    COMPANY_NAME,
    UPPER(COMPANY_NAME) AS TRANSFORMED_COMPANY_NAME, -- New column: transforming company name to uppercase
    CURRENT_DATE AS EXTRACTED_DATE -- New column: capturing the current date as extracted date
FROM raw_company_data;