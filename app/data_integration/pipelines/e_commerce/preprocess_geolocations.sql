DROP TABLE IF EXISTS ec_tmp.geolocations CASCADE;

CREATE TABLE ec_tmp.geolocations
(
  geolocation_id  INTEGER          NOT NULL, -- Unique integer representation of the zip_code_prefix
  zip_code_prefix TEXT             NOT NULL, -- First 5 digits of zip code
  latitude        DOUBLE PRECISION NOT NULL,
  longitude       DOUBLE PRECISION NOT NULL,
  city            TEXT             NOT NULL,
  state           TEXT             NOT NULL
);
INSERT INTO ec_tmp.geolocations
SELECT zip_code_prefix::INTEGER AS geolocation_id,
       zip_code_prefix,
       min(latitude)            AS latitude,
       min(longitude)           AS longitude,
       initcap(min(city))       AS city,
       min(state)               AS state
FROM ec_data.geolocation
GROUP BY zip_code_prefix;

SELECT util.add_index('ec_tmp', 'geolocations', column_names := ARRAY ['geolocation_id']);
