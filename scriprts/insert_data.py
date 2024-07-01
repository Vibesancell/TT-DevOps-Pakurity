from google.cloud import bigquery
import random
import string

client = bigquery.Client()

# Name dataset and table
dataset_id = 'prod_tt_devops_dataset'
table_id = 'prod_tt_devops_table'

# Generate random data
rows = []
for i in range(1000):
    tag = random.choice(string.ascii_uppercase)
    count = random.randint(0, 9)
    row = {"Id": i + 1, "Tag": tag, "Count": count}
    rows.append(row)

# Uploads data in table
table_ref = client.dataset(dataset_id).table(table_id)
table = client.get_table(table_ref)
errors = client.insert_rows(table, rows)

if not errors:
    print(f"The data has been successfully loaded into the table {table_id}.")
else:
    print(f"An error occurred while loading data: {errors}")