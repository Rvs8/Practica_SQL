SELECT 
  det.ivr_id,
  CASE 
    WHEN COUNTIF(step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK') > 0 THEN 1
    ELSE 0
  END AS info_by_phone_lg
FROM keepcoding.ivr_detail AS det
GROUP BY det.ivr_id;
