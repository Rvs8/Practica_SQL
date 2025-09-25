CREATE TABLE keepcoding.ivr_summary AS
SELECT
  det.ivr_id,
  det.phone_number,
  det.ivr_result,
  det.start_date,
  det.end_date,
  det.total_duration,
  det.customer_segment,
  det.ivr_language,

  -- Campo vdn_aggregation (Ejercicio 4)
  CASE
    WHEN STARTS_WITH(calls.vdn_label, 'ATC') THEN 'FRONT'
    WHEN STARTS_WITH(calls.vdn_label, 'TECH') THEN 'TECH'
    WHEN calls.vdn_label = 'ABSORTION' THEN 'ABSORTION'
    ELSE 'RESTO'
  END AS vdn_aggregation,

  -- Indicadores derivados del detalle (steps_module, module_aggregation)
  COUNT(DISTINCT det.step_name) AS steps_module,
  STRING_AGG(DISTINCT det.module_name, ', ' ORDER BY det.module_name) AS module_aggregation,

  -- Campos document_type, document_identification (Ejercicio 5)
  MAX(CASE WHEN det.document_type IS NOT NULL THEN det.document_type ELSE NULL END) AS doc_type,
  MAX(CASE WHEN det.document_identification IS NOT NULL THEN det.document_identification ELSE NULL END) AS doc_identification,

  -- Campo customer_phone (Ejercicio 6)
  MAX(CASE WHEN det.step_name = 'CUSTOMERINFOBYPHONE.TX' THEN det.document_identification ELSE NULL END) AS cust_phone,

  -- Campo billing_account_id (Ejercicio 7)
  MAX(CASE WHEN det.step_name = 'BILLINGACCOUNT.TX' THEN det.document_identification ELSE NULL END) AS bill_account_id,

  -- Campo masiva_lg (Ejercicio 8)
  CASE 
    WHEN COUNTIF(det.module_name = 'AVERIA_MASIVA') > 0 THEN 1
    ELSE 0
  END AS masiva_lg,

  -- Campo info_by_phone_lg (Ejercicio 9)
  CASE 
    WHEN COUNTIF(det.step_name = 'CUSTOMERINFOBYPHONE.TX' AND det.step_result = 'OK') > 0 THEN 1
    ELSE 0
  END AS info_by_phone_lg,

  -- Campo info_by (Ejercicio 10)
  CASE 
    WHEN COUNTIF(det.step_name = 'CUSTOMERINFOBYDNI.TX' AND det.step_result = 'OK') > 0 THEN 1
    ELSE 0
  END AS info_by_dni_lg,

  -- Campo repeated_phone_24H (Ejercicio 11)
  CASE 
    WHEN EXISTS (
      SELECT 1
      FROM keepcoding.ivr_calls AS pre
      WHERE pre.phone_number = det.phone_number
        AND pre.start_date BETWEEN TIMESTAMP_SUB(det.start_date, INTERVAL 24 HOUR) AND det.start_date
        AND pre.ivr_id != det.ivr_id
    ) THEN 1
    ELSE 0
  END AS repeated_phone_24H,

  -- Campo cause_recall_phone_24H (Ejercicio 11)
  CASE 
    WHEN EXISTS (
      SELECT 1
      FROM keepcoding.ivr_calls AS nex
      WHERE nex.phone_number = det.phone_number
        AND nex.start_date BETWEEN det.start_date AND TIMESTAMP_ADD(det.start_date, INTERVAL 24 HOUR)
        AND nex.ivr_id != det.ivr_id
    ) THEN 1
    ELSE 0
  END AS cause_recall_phone_24H

FROM keepcoding.ivr_detail AS det

-- JOIN para obtener vdn_label desde ivr_calls
LEFT JOIN keepcoding.ivr_calls AS calls
  ON det.ivr_id = calls.ivr_id

GROUP BY
  det.ivr_id, det.phone_number, det.ivr_result, calls.vdn_label,
  det.start_date, det.end_date, det.total_duration,
  det.customer_segment, det.ivr_language;
