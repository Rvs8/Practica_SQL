CREATE TABLE keepcoding.ivr_detail AS
SELECT
  -- Datos de ivr_calls
  ca.ivr_id AS calls_ivr_id,
  ca.phone_number AS calls_phone_number,
  ca.ivr_result AS calls_ivr_result,
  ca.vdn_label AS calls_vdn_label,
  FORMAT_DATE("%Y%m%d", ca.start_date) AS calls_start_date_id,
  FORMAT_DATE("%Y%m%d", ca.end_date) AS calls_end_date_id,
  ca.total_duration AS calls_total_duration,
  ca.customer_segment AS calls_customer_segment,
  ca.ivr_language AS calls_ivr_language,
  ca.steps_module AS calls_steps_module,
  ca.module_aggregation AS calls_module_aggregation,

  -- Datos de ivr_modules
  mo.module_sequence,
  mo.module_name,
  mo.module_duration,
  mo.module_result,

  -- Datos de ivr_steps
  st.step_sequence,
  st.step_name,
  st.step_result,
  st.step_description_error,
  st.document_type,
  st.document_identification,
  st.customer_phone,
  st.billing_account_id

FROM keepcoding.ivr_calls AS ca
INNER JOIN keepcoding.ivr_modules AS mo
  ON ca.ivr_id = mo.ivr_id
INNER JOIN keepcoding.ivr_steps AS st
  ON mo.ivr_id = st.ivr_id
  AND mo.module_sequence = st.module_sequence;
