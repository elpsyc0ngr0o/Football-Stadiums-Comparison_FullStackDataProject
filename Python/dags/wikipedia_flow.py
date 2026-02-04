import os
import sys
from datetime import datetime
import adlfs
from airflow import DAG
from airflow.operators.python import PythonOperator

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipelines.wikipedia_pipeline import extract_wikipedia_data, transform_wikipedia_data, write_wikipedia_data

dag = DAG(
    dag_id='wikipedia_flow',
    default_args={
        "owner":"Mithun Regikumar",
        "start_date": datetime(2024,6,1),
    },
    schedule=None,
    catchup=False

)

extract_data_from_wikipedia_data = PythonOperator(
    task_id='extract_data_from_wikipedia_data',
    python_callable=extract_wikipedia_data,
    op_kwargs={"url": "https://en.wikipedia.org/wiki/List_of_association_football_stadiums_by_capacity"},
    dag=dag
)

transform_wikipedia_data = PythonOperator(
    task_id='transform_wikipedia_data',
    python_callable=transform_wikipedia_data,
    dag=dag
)

write_wikipedia_data = PythonOperator(
    task_id='write_wikipedia_data',
    python_callable=write_wikipedia_data,
    dag=dag
)

extract_data_from_wikipedia_data >> transform_wikipedia_data >> write_wikipedia_data
