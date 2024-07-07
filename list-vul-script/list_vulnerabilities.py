import google.auth
from google.cloud import artifactregistry_v1
from google.cloud.devtools import containeranalysis_v1
from google.protobuf.json_format import MessageToDict
from google.api_core.exceptions import DeadlineExceeded
from google.api_core.retry import Retry

# Authenticate using the default credentials
credentials, project_id = google.auth.default()

# Set up the Artifact Registry client with the authenticated credentials
artifact_registry_client = artifactregistry_v1.ArtifactRegistryClient(credentials=credentials)

# Set up the Container Analysis client with the authenticated credentials
container_analysis_client = containeranalysis_v1.ContainerAnalysisClient(credentials=credentials)

# Set up the Grafeas client
grafeas_client = container_analysis_client.get_grafeas_client()

# Repository details
location = "us-central1"
repository = "registry"
image_path = "us-central1-docker.pkg.dev/tt-devops-427513/registry/vibesan/tt-devops@sha256:3157e20686919d5e267d672e5beab4f5f0dc423089bac2df37e2631bbd900f94"

# List vulnerabilities for the specified image
def list_vulnerabilities(image_path):
    print(f"Checking vulnerabilities for image: {image_path}")
    
    # Set a custom timeout and retry strategy
    timeout = 300.0  # Increase the timeout to 300 seconds
    retry = Retry(deadline=300)  # Retry for up to 300 seconds

    try:
        # Get the vulnerability occurrences for the image
        filter_str = f'resourceUrl="https://{image_path}"'
        print(f"Using filter: {filter_str}")

        occurrences = grafeas_client.list_occurrences(
            parent=f"projects/{project_id}",
            filter=filter_str,
            timeout=timeout,
            retry=retry
        )
        
        occurrences_list = list(occurrences)
        if not occurrences_list:
            print("No vulnerabilities found for the image.")
        else:
            print(f"Found {len(occurrences_list)} vulnerabilities.")
        
        # Print the vulnerabilities
        for occurrence in occurrences_list:
            try:
                vulnerability = MessageToDict(occurrence)
                print(vulnerability)
            except Exception as e:
                print(occurrence)

    except DeadlineExceeded:
        print("The request timed out. Try increasing the timeout and retry values.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    list_vulnerabilities(image_path)
