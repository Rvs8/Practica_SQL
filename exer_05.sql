SELECT
  ivr_id AS calls_ivr_id,
  (
    SELECT document_type
    FROM keepcoding.ivr_steps AS st
    WHERE st.ivr_id = ca.ivr_id
      AND document_type IS NOT NULL
    LIMIT 1
  ) AS doc_type,

  (
    SELECT document_identification
    FROM keepcoding.ivr_steps AS st
    WHERE st.ivr_id = ca.ivr_id
      AND document_identification IS NOT NULL
    LIMIT 1
  ) AS doc_identification

FROM keepcoding.ivr_calls AS ca;
