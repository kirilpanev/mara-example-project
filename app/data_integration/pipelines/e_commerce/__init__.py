import pathlib

import etl_tools.utils
from data_integration.commands.files import Compression
from data_integration.commands.sql import ExecuteSQL
from data_integration.parallel_tasks.files import ParallelReadFile, ReadMode
from data_integration.parallel_tasks.sql import ParallelExecuteSQL
from data_integration.pipelines import Pipeline, Task
from etl_tools.create_attributes_table import CreateAttributesTable

pipeline = Pipeline(
    id="e_commerce",
    description="Builds cubes related to the e-commerce public data by Olist",
    base_path=pathlib.Path(__file__).parent,
    labels={"Schema": "ec_dim"})

pipeline.add_initial(
    Task(id="initialize_schemas",
         description="Recreates the schemas of the pipeline",
         commands=[
             ExecuteSQL(sql_file_name="recreate_schemas.sql")
         ]))

pipeline.add(
    Task(id="preprocess_orders",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_orders.sql")
         ]))

pipeline.add(
    Task(id="preprocess_order_items",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_order_items.sql")
         ]))

pipeline.add(
    Task(id="preprocess_products",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_products.sql")
         ]))

pipeline.add(
    Task(id="preprocess_sellers",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_sellers.sql")
         ]))

pipeline.add(
    Task(id="preprocess_customers",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_customers.sql")
         ]))

pipeline.add(
    Task(id="preprocess_geolocations",
         description="",
         commands=[
             ExecuteSQL(sql_file_name="preprocess_geolocations.sql")
         ]))


# pipeline.add(
#     ParallelExecuteSQL(
#         id="create_repo_activity_data_set",
#         description="Creates a flat data set table for Github repo activities",
#         sql_statement="SELECT gh_tmp.insert_repo_activity_data_set(@chunk@::SMALLINT);",
#         parameter_function=etl_tools.utils.chunk_parameter_function,
#         parameter_placeholders=["@chunk@"],
#         commands_before=[
#             ExecuteSQL(sql_file_name="create_repo_activity_data_set.sql")
#         ]),
#     upstreams=["transform_repo_activity"])
#
# pipeline.add(
#     CreateAttributesTable(
#         id="create_repo_activity_data_set_attributes",
#         source_schema_name='gh_dim_next',
#         source_table_name='repo_activity_data_set'),
#     upstreams=['create_repo_activity_data_set'])
#
# pipeline.add(
#     Task(id="constrain_tables",
#          description="Adds foreign key constrains between the dim tables",
#          commands=[
#              ExecuteSQL(sql_file_name="constrain_tables.sql", echo_queries=False)
#          ]),
#     upstreams=["transform_repo_activity"])

pipeline.add_final(
    Task(id="replace_schema",
         description="Replaces the current ec_dim schema with the contents of ec_dim_next",
         commands=[
             ExecuteSQL(sql_statement="SELECT util.replace_schema('ec_dim', 'ec_dim_next');")
         ]))
