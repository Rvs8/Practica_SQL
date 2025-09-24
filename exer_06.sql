SELECT
  ivr_id AS calls_ivr_id,

  -- Seleccionamos un solo número de teléfono por llamada
  (
    SELECT customer_phone
    FROM keepcoding.ivr_steps AS st
    WHERE st.ivr_id = ca.ivr_id
      AND customer_phone IS NOT NULL
    LIMIT 1
  ) AS cust_phone

FROM keepcoding.ivr_calls AS ca;
