SELECT
  ca.ivr_id AS calls_ivr_id,

  (
    SELECT customer_phone
    FROM keepcoding.ivr_steps AS st
    WHERE st.ivr_id = ca.ivr_id
      AND customer_phone IS NOT NULL
      AND customer_phone != 'UNKNOWN'
    LIMIT 1
  ) AS cust_phone

FROM keepcoding.ivr_calls AS ca;

