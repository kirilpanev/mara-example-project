--This table has information Brazilian zip codes and its lat/lng coordinates.
--Use it to plot maps and find distances between sellers and customers.
DROP TABLE IF EXISTS e_data.geolocation CASCADE;
CREATE TABLE e_data.geolocation
(
    geolocation_zip_code_prefix TEXT,             --first 5 digits of zip code
    geolocation_lat             DOUBLE PRECISION, --latitude
    geolocation_lng             DOUBLE PRECISION, --longitude
    geolocation_city            TEXT,             --city name
    geolocation_state           TEXT              --state
);