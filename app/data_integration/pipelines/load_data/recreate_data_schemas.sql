DROP SCHEMA IF EXISTS e_data CASCADE;
CREATE SCHEMA e_data;

SELECT util.create_chunking_functions('e_data');

DROP SCHEMA IF EXISTS m_data CASCADE;
CREATE SCHEMA m_data;

SELECT util.create_chunking_functions('m_data');