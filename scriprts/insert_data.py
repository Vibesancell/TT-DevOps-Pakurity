from google.cloud import bigquery
import random
import string
import google.auth
import google.auth.impersonated_credentials

# Impersonate a service account
target_scopes = ["https://www.googleapis.com/auth/bigquery"]
creds, pid = google.auth.default()
print(f"Obtained default credentials for the project {pid}")

# Replace with the email of the target service account you want to impersonate
target_service_account_email = "tt-devops-sa@tt-devops-427513.iam.gserviceaccount.com"

tcreds = google.auth.impersonated_credentials.Credentials(
    source_credentials=creds,
    target_principal=target_service_account_email,
    target_scopes=target_scopes,
)

# Create BigQuery client with impersonated credentials
client = bigquery.Client(credentials=tcreds)

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
