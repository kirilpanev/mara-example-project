DROP TABLE IF EXISTS ec_tmp.customers CASCADE;

CREATE TABLE ec_tmp.customers
(
  customer_id TEXT NOT NULL, -- Unique identifier of a customer
  geolocation_id TEXT           -- integer representation of a zip_code_prefix
);
-- Customers get different ids for different orders -> Deduplication on customer_unique_id
-- Keep the last order's customer data across distinct customer_unique_id
INSERT INTO ec_tmp.customers
SELECT DISTINCT customer_unique_id                                    AS customer_id,
                first_value(zip_code_prefix::INTEGER)
                            over (partition by customer_unique_id
                              order by order_purchase_timestamp desc) AS geolocation_id
FROM ec_data.customers
     LEFT JOIN ec_data.orders using (customer_id);

SELECT util.add_index('ec_tmp', 'customers', column_names := ARRAY ['customer_id']);
