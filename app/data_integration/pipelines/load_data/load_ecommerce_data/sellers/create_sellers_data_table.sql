--This table includes data about the sellers that fulfilled orders made at Olist.
--Use it to find the seller location and to identify which seller fulfilled each product.
DROP TABLE IF EXISTS ec_data.sellers CASCADE;
CREATE TABLE ec_data.sellers
(
    seller_id              TEXT, --seller unique identifier
    seller_zip_code_prefix TEXT, --first 5 digits of seller zip code
    seller_city            TEXT, --seller city name
    seller_state           TEXT  --seller state
);