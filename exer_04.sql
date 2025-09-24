SELECT
  ivr_id AS calls_ivr_id,
  CASE
    WHEN STARTS_WITH(vdn_label, 'ATC') THEN 'FRONT'
    WHEN STARTS_WITH(vdn_label, 'TECH') THEN 'TECH'
    WHEN vdn_label = 'ABSORTION' THEN 'ABSORTION'
    ELSE 'RESTO'
  END AS vdn_aggregation
FROM keepcoding.ivr_calls;

