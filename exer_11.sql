SELECT 
  ca.ivr_id,
  ca.phone_number,
  ca.start_date,

  -- ¿hubo otra llamada con el mismo número en las 24h anteriores?
  CASE 
    WHEN EXISTS (
      SELECT 1
      FROM keepcoding.ivr_calls AS pre
      WHERE pre.phone_number = ca.phone_number
        AND pre.start_date BETWEEN TIMESTAMP_SUB(ca.start_date, INTERVAL 24 HOUR) AND ca.start_date
        AND pre.ivr_id != ca.ivr_id
    ) THEN 1
    ELSE 0
  END AS repeated_phone_24H,

  -- ¿hubo otra llamada con el mismo número en las 24h siguientes?
  CASE 
    WHEN EXISTS (
      SELECT 1
      FROM keepcoding.ivr_calls AS nex
      WHERE nex.phone_number = ca.phone_number
        AND nex.start_date BETWEEN ca.start_date AND TIMESTAMP_ADD(ca.start_date, INTERVAL 24 HOUR)
        AND nex.ivr_id != ca.ivr_id
    ) THEN 1
    ELSE 0
  END AS cause_recall_phone_24H

FROM keepcoding.ivr_calls AS ca;
