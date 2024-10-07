-- models/load_transformed_data.sql
 
-- Create the table in the target schema and load the transformed data
CREATE OR REPLACE TABLE "FINANCE"."TRANSFORM_DATA"."COMPANY_TRANSFORMED" AS
WITH transformed_company_data AS (
    -- Select the data from the transform_company_data model
    SELECT 
        COMPANY_ID,
        COMPANY_NAME,
        TRANSFORMED_COMPANY_NAME,
        EXTRACTED_DATE
    FROM {{ ref('transform_company_data') }} -- Referencing the transform_company_data model
)
 
-- Insert the transformed data into the newly created table
SELECT * FROM transformed_company_data;