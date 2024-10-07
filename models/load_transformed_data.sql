{{ config(materialized='incremental') }}  -- Set the materialization to 'table'
 
-- Log message to indicate the model execution has started
{{ log("Executing: load_transformed_data model", info=True) }}
 
WITH transformed_company_data AS (
    -- Log message to indicate data extraction from transform_company_data model
    {{ log("Extracting data from transform_company_data model", info=True) }}
 
    -- Select the data from the transform_company_data model
    SELECT
        COMPANY_ID,
        COMPANY_NAME,
        TRANSFORMED_COMPANY_NAME,
        EXTRACTED_DATE
    FROM {{ ref('transform_company_data') }} -- Referencing the transform_company_data model
)
 
-- Log message to confirm data selection from transformed_company_data
{{ log("Selecting transformed data to create the load_transformed_data table", info=True) }}
 
-- Select the transformed data to create the table
SELECT *
FROM transformed_company_data