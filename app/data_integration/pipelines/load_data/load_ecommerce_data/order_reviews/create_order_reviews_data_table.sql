--This table includes data about the reviews made by the customers.
--After a customer purchases the product from Olist Store a seller gets notified to fulfill that order.
--Once the customer receives the product, or the estimated delivery date is due,
--the customer gets a satisfaction survey by email where he can give a note for the purchase experience and write down some comments.
DROP TABLE IF EXISTS ec_data.order_reviews CASCADE;
CREATE TABLE ec_data.order_reviews
(
    review_id               TEXT,                     --unique review identifier
    order_id                TEXT,                     --unique order identifier
    review_score            INTEGER,                  --Note ranging from 1 to 5 given by the customer on a satisfaction survey.
    review_comment_title    TEXT,                     --Comment title from the review left by the customer, in Portuguese.
    review_comment_message  TEXT,                     --Comment message from the review left by the customer, in Portuguese.
    review_creation_date    TIMESTAMP WITH TIME ZONE, --Shows the date in which the satisfaction survey was sent to the customer.
    review_answer_timestamp TIMESTAMP WITH TIME ZONE  --Shows satisfaction survey answer timestamp.
);