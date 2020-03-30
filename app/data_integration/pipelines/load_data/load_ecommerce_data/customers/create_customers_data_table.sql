--This table has information about the customer and its location. Use it to identify unique customers in the orders table and to find the orders delivery location.
--At our system each order is assigned to a unique customer_id.
--This means that the same customer will get different ids for different orders.
--The purpose of having a customer_unique_id on the table is to allow you to identify customers that made repurchases at the store.
--Otherwise you would find that each order had a different customer associated with.
DROP TABLE IF EXISTS e_data.customers CASCADE;
CREATE TABLE e_data.customers
(
    customer_id              TEXT, --key to the orders table. Each order has a unique customer_id.
    customer_unique_id       TEXT, --unique identifier of a customer.
    customer_zip_code_prefix TEXT, --first five digits of customer zip code
    customer_city            TEXT, --customer city name
    customer_state           TEXT  --customer state
);