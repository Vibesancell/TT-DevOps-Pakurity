import os
import random
import string
from google.cloud import bigquery
from google.auth import compute_engine

credentials = compute_engine.Credentials()

client = bigquery.Client(credentials=credentials, project="tt-devops-427513")

dataset_id = "prod_tt_devops_dataset"
table_id = "prod_tt_devops_table"

rows_to_insert = [
    {"Id": i, "Tag": random.choice(string.ascii_uppercase), "Count": random.randint(0, 9)}
    for i in range(1000)
]

errors = client.insert_rows_json(f"{dataset_id}.{table_id}", rows_to_insert)
if errors:
    print(f"Errors occurred while inserting rows: {errors}")
else:
    print("Rows successfully inserted.")
