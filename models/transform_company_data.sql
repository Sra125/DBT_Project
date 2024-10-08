-- models/transform_company_data.sql
 {{ config(materialized='table') }} -- Set to 'view' since we are working with a view in Snowflake

-- Log message to indicate the model execution has started
{{ log("Executing: transform_company_data model", info=True) }}
 
WITH raw_company_data AS (
    -- Log message to indicate the data extraction from select_company_data model
    {{ log("Extracting raw data from select_company_data model", info=True) }}
 
    -- Select the raw data
    SELECT
        COMPANY_ID,
        TRIM(COMPANY_NAME) AS COMPANY_NAME -- Trim any extra spaces from the company name
    FROM {{ ref('select_company_data') }} -- Referencing the select_company_data model
)
 
-- Log message to indicate transformation is being applied
{{ log("Applying transformations: converting company name to uppercase and adding current date", info=True) }}
 
-- Apply transformations
SELECT
    COMPANY_ID,
    COMPANY_NAME,
    UPPER(COMPANY_NAME) AS TRANSFORMED_COMPANY_NAME, -- New column: transforming company name to uppercase
    CURRENT_DATE AS EXTRACTED_DATE -- New column: capturing the current date as extracted date
FROM raw_company_data


