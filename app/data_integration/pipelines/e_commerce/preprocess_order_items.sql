DROP TABLE IF EXISTS ec_tmp.order_items CASCADE;

CREATE TABLE ec_tmp.order_items
(
  order_item_id       INTEGER          NOT NULL, --sequential number identifying number of items included in the same order.
  order_id            TEXT             NOT NULL, --order unique identifier
  product_id          TEXT             NOT NULL, --product unique identifier
  seller_id           TEXT             NOT NULL, --seller unique identifier
  shipping_limit_date TIMESTAMP WITH TIME ZONE,  --Shows the seller shipping limit date for handling the order over to the logistic partner.
  price               DOUBLE PRECISION NOT NULL, --item price
  freight_value       DOUBLE PRECISION NOT NULL  --item freight value item (if an order has more than one item the freight value is split between items)
);
INSERT INTO ec_tmp.order_items
SELECT order_item_id,
       order_id,
       product_id,
       seller_id,
       shipping_limit_date,
       price,
       freight_value
FROM ec_data.order_items;

SELECT util.add_index('ec_tmp', 'order_items', column_names := ARRAY ['order_item_id', 'order_id', 'product_id']);
