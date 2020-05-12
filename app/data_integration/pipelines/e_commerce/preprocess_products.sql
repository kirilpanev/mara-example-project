DROP TABLE IF EXISTS ec_tmp.products CASCADE;

CREATE TABLE ec_tmp.products
(
  product_id       TEXT NOT NULL, --unique product identifier
  product_category TEXT,          --root category of product, in Portuguese.
  photos_quantity  INTEGER,       --number of product published photos
  weight_g         INTEGER,       --product weight measured in grams.
  length_cm        INTEGER,       --product length measured in centimeters.
  height_cm        INTEGER,       --product height measured in centimeters.
  width_cm         INTEGER        --product width measured in centimeters.
);
INSERT INTO ec_tmp.products
SELECT product_id,
       coalesce(product_category_name_translation.product_category_name_english,
                products.product_category_name) AS product_category,
       photos_quantity,
       weight_g,
       length_cm,
       height_cm,
       width_cm
FROM ec_data.products
     LEFT JOIN ec_data.product_category_name_translation USING (product_category_name);

SELECT util.add_index('ec_tmp', 'products', column_names := ARRAY ['product_id']);
