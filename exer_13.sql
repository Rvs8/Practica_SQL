CREATE OR REPLACE FUNCTION keepcoding.clean_integer(input_value INT)
RETURNS INT
AS (
  IFNULL(input_value , -999999)
);
