-- models/transform_company_data.sql
 {{ config(materialized='view') }} -- Set to 'view' since we are working with a view in Snowflake

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
FROM raw_company_data;

-- Log row count to confirm the number of rows after the transformation
{% set row_count_query %}
    SELECT COUNT(*) AS row_count
    FROM {{ ref('select_company_data') }}
{% endset %}
 
{% set row_count_result = run_query(row_count_query) %}
{{ log("Number of rows transformed: " ~ row_count_result.column_names[0] ~ " = " ~ row_count_result.columns[0].values[0], info=True) }}
 
-- Optionally log a sample of transformed data for confirmation (first 5 rows)
{% set sample_data_query %}
    SELECT COMPANY_ID, COMPANY_NAME, UPPER(COMPANY_NAME) AS TRANSFORMED_COMPANY_NAME, CURRENT_DATE AS EXTRACTED_DATE
    FROM {{ ref('select_company_data') }}
    LIMIT 5
{% endset %}
 
{% set sample_data_result = run_query(sample_data_query) %}
{{ log("Sample transformed data:", info=True) }}
{% for row in sample_data_result.columns[0].values %}
    {{ log("COMPANY_ID: " ~ row ~ ", COMPANY_NAME: " ~ sample_data_result.columns[1].values[loop.index0] ~ ", TRANSFORMED_COMPANY_NAME: " ~ sample_data_result.columns[2].values[loop.index0] ~ ", EXTRACTED_DATE: " ~ sample_data_result.columns[3].values[loop.index0], info=True) }}
{% endfor %}