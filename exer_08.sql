SELECT 
  ca.ivr_id,
  CASE 
    WHEN COUNTIF(mo.module_name = 'AVERIA_MASIVA') > 0 THEN 1
    ELSE 0
  END AS masiva_lg
FROM keepcoding.ivr_calls AS ca
LEFT JOIN keepcoding.ivr_modules AS mo
  ON ca.ivr_id = mo.ivr_id
GROUP BY ca.ivr_id;
