DROP TABLE IF EXISTS ec_tmp.sellers CASCADE;

CREATE TABLE ec_tmp.sellers
(
  seller_id   TEXT NOT NULL, -- seller unique identifier
  geolocation_id TEXT NOT NULL  -- integer representation of a zip_code_prefix
);

INSERT INTO ec_tmp.sellers
SELECT seller_id,
       zip_code_prefix::INTEGER AS geolocation_id
FROM ec_data.sellers;

SELECT util.add_index('ec_tmp', 'sellers', column_names := ARRAY ['seller_id']);
