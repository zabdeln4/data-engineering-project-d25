from airflow import DAG
from airflow.providers.google.cloud.operators.gcs import GCSDeleteObjectsOperator
from airflow.providers.google.cloud.transfers.postgres_to_gcs import PostgresToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.providers.http.sensors.http import HttpSensor
from datetime import datetime


# DAG configuration
DEFAULT_ARGS = {
    'owner': 'Ziad',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1
}

BUCKET_NAME='ready-d25-postgres-to-gcs'
PROJECT_ID='ready-de-25'
DATASET_ID='olist_ziad'


with DAG(
    dag_id='data_transfer_olist_ziad',
    default_args=DEFAULT_ARGS,
    description='Transfer data from PostgreSQL and API to BigQuery - Ready Talent Data Engineering Project (D25)',
    schedule=None,
    start_date=datetime(2025, 1, 1),
    catchup=False
) as dag:


    # # # Cleanup bucket
    # cleanup_gcs_bucket = GCSDeleteObjectsOperator(
    #     task_id='cleanup_gcs_bucket',
    #     bucket_name=BUCKET_NAME,
    #     prefix=''  # Specify the prefix or objects to delete
    # )

    # PostgreSQL to GCS transfer tasks
    postgres_tables = {
        "customers": "SELECT * FROM customers",
        "geolocation": "SELECT * FROM geolocation",
        "order_items": "SELECT * FROM order_items",
        "order_reviews": "SELECT review_id, order_id, review_score FROM order_reviews",
        "orders": "SELECT * FROM orders",
        "products": "SELECT * FROM products",
        "product_category_name_translation": "SELECT * FROM product_category_name_translation"
    }

    for table_name, query in postgres_tables.items():
        export_to_gcs = PostgresToGCSOperator(
            task_id=f'export_{table_name}_to_gcs',
            postgres_conn_id='postgres_z',
            sql=query,
            bucket=BUCKET_NAME,
            filename=f'ziad/olist/{table_name}.csv',
            export_format='csv',
        )

        load_to_bq = GCSToBigQueryOperator(
            task_id=f'load_{table_name}_to_bq',
            bucket=BUCKET_NAME,
            source_objects=[f'ziad/olist/{table_name}.csv'],
            destination_project_dataset_table=f'{PROJECT_ID}.{DATASET_ID}.{table_name}',
            source_format='csv',
            skip_leading_rows=1,
            autodetect=True,
            write_disposition='WRITE_TRUNCATE'
        )

        export_to_gcs >> load_to_bq

    # Fetch API data and load to BigQuery
    api_endpoints = {
        "order_payments": "https://us-central1-ready-de-25.cloudfunctions.net/order_payments_table",
        "sellers": "https://us-central1-ready-de-25.cloudfunctions.net/sellers_table"
    }

    for table_name, endpoint in api_endpoints.items():
        check_api = HttpSensor(
            task_id=f'check_{table_name}_api',
            http_conn_id='http_z',
            endpoint=endpoint,
            response_check=lambda response: response.status_code == 200,
            poke_interval=5,
            timeout=20
        )

        load_api_to_bq = GCSToBigQueryOperator(
            task_id=f'load_{table_name}_to_bq',
            bucket=BUCKET_NAME,
            source_objects=[f'ziad/olist/{table_name}.csv'],
            destination_project_dataset_table=f'{PROJECT_ID}.{DATASET_ID}.{table_name}',
            source_format='csv',
            write_disposition='WRITE_TRUNCATE'
        )

        check_api >> load_api_to_bq

    # Cleanup bucket after processing
    # cleanup_gcs_bucket.set_upstream([load_to_bq])
