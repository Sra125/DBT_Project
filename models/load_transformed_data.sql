-- models/load_transformed_data.sql
 
{{ config(materialized='table') }}  -- Set the materialization to 'table'
 
WITH transformed_company_data AS (
    -- Select the data from the transform_company_data model
    SELECT 
        COMPANY_ID,
        COMPANY_NAME,
        TRANSFORMED_COMPANY_NAME,
        EXTRACTED_DATE
    FROM {{ ref('transform_company_data') }} -- Referencing the transform_company_data model
)
 
-- Select the transformed data to create the table
SELECT * 
FROM transformed_company_data;