--This table includes data about the products sold by Olist.
DROP TABLE IF EXISTS ec_data.products CASCADE;
CREATE TABLE ec_data.products
(
    product_id            TEXT,    --unique product identifier
    product_category_name TEXT,    --root category of product, in Portuguese.
    product_name_length   INTEGER, --number of characters extracted from the product name.
    description_length    INTEGER, --number of characters extracted from the product description.
    product_photos_qty    INTEGER, --number of product published photos
    product_weight_g      INTEGER, --product weight measured in grams.
    product_lenght_cm     INTEGER, --product length measured in centimeters.
    product_height_cm     INTEGER, --product height measured in centimeters.
    product_width_cm      INTEGER  --product width measured in centimeters.
);