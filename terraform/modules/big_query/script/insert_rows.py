import os
import random
import string
from google.cloud import bigquery
from google.auth import default, exceptions

def get_credentials():
    try:
        credentials, _ = default()
        return credentials
    except exceptions.DefaultCredentialsError as e:
        print(f"Failed to obtain credentials: {e}")
        raise

def main():
    credentials = get_credentials()

    client = bigquery.Client(credentials=credentials, project="your-project-id")

    dataset_id = "example_dataset"
    table_id = "example_table"

    rows_to_insert = [
        {"Id": i, "Tag": random.choice(string.ascii_uppercase), "Count": random.randint(0, 9)}
        for i in range(1000)
    ]

    errors = client.insert_rows_json(f"{dataset_id}.{table_id}", rows_to_insert)
    if errors:
        print(f"Errors occurred while inserting rows: {errors}")
    else:
        print("Rows successfully inserted.")

if __name__ == "__main__":
    main()
