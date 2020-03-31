import json
import pathlib

from data_integration.commands.sql import ExecuteSQL, Copy
from data_integration.pipelines import Pipeline, Task
from app.data_integration.pipelines.load_data.create_table import create_table_sql

customers_table = json.load(open(pathlib.Path(__file__).parent / 'customers/customers_table.json'))

pipeline = Pipeline(
    id="ecommerce",
    description="Jobs related with loading data from the Olist back-end database",
    max_number_of_parallel_tasks=5,
    base_path=pathlib.Path(__file__).parent,
    labels={"Schema": "ec_data"})

pipeline.add_initial(
    Task(id="initialize_schemas", description="Recreates the data schema",
         commands=[
             ExecuteSQL(sql_file_name='../recreate_data_schemas.sql',
                        file_dependencies=[pathlib.Path(__file__).parent.parent/'recreate_data_schemas.sql'])]))

pipeline.add(
    Task(
        id="load_customers_data",
        description="Loads the customers data from the production DB",
        commands=[
            ExecuteSQL(sql_file_name='customers/create_customers_data_table.sql'),
            Copy(sql_file_name='customers/load_customers_data.sql', source_db_alias='olist',
                 target_db_alias='dwh', target_table='ec_data.customers')
        ]))

pipeline.add(
    Task(
        id="load_geolocation_data",
        description="Loads geolocation data from the production DB, "
                    "containing information Brazilian zip codes and its lat/lng coordinates",
        commands=[
            ExecuteSQL(sql_file_name='geolocation/create_geolocation_data_table.sql'),
            Copy(sql_file_name='geolocation/load_geolocation_data.sql', source_db_alias='olist',
                 target_db_alias='dwh', target_table='ec_data.geolocation')
        ]))

pipeline.add(
    Task(
        id="load_order_items_data",
        description="Loads the order items data from the production DB",
        commands=[
            ExecuteSQL(sql_file_name='order_items/create_order_items_data_table.sql'),
            Copy(sql_file_name='order_items/load_order_items_data.sql', source_db_alias='olist',
                 target_db_alias='dwh', target_table='ec_data.order_items')
        ]))

pipeline.add(
    Task(
        id="load_order_payments_data",
        description="Loads the order payments data from the production DB",
        commands=[
            ExecuteSQL(sql_file_name='order_payments/create_order_payments_data_table.sql'),
            Copy(sql_file_name='order_payments/load_order_payments_data.sql', source_db_alias='olist',
                 target_db_alias='dwh', target_table='ec_data.order_payments')
        ]))

pipeline.add(
    Task(
        id="load_order_reviews_data",
        description="Loads the order reviews data from the production DB",
        commands=[
            ExecuteSQL(sql_file_name='order_reviews/create_order_reviews_data_table.sql'),
            Copy(sql_file_name='order_reviews/load_order_reviews_data.sql', source_db_alias='olist',
                 target_db_alias='dwh', target_table='ec_data.order_reviews',
                 delimiter_char=';')
        ]))