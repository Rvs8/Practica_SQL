SELECT
  ca.ivr_id AS calls_ivr_id,
  (
    SELECT billing_account_id
    FROM keepcoding.ivr_steps AS st
    WHERE st.ivr_id = ca.ivr_id
      AND billing_account_id IS NOT NULL
      AND billing_account_id != 'UNKNOWN'
    LIMIT 1
  ) AS bill_ac_id

FROM keepcoding.ivr_calls AS ca;

