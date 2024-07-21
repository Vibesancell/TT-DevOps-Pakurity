# Use an older version of Python as the base image
FROM python:3.6-slim

# Install dependencies for Google Cloud BigQuery
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install google-cloud-bigquery google-auth

# Copy the script into the container
COPY insert_row.py /app/insert_row.py

# Set the Google Cloud Project ID as an environment variable
ENV GOOGLE_CLOUD_PROJECT tt-devops-427513

# Set the working directory
WORKDIR /app

# Run the script when the container starts
CMD ["python", "insert_row.py"]

# Specify a volume to mount local Google Cloud configurations
VOLUME ["/root/.config/gcloud"]
