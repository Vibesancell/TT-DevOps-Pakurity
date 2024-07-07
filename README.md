# DevSecOps Engineer Test Job Repository

Welcome to the repository for the DevSecOps Engineer test job at Pakurity. This repository showcases the implementation of various tasks using specified technologies. Below is an overview of the repository structure and the purpose of each component.

## Technologies Used
- **Terraform**: For infrastructure as code on Google Cloud Platform (GCP).
- **Docker**: For containerization of applications.
- **Minikube**: For running Kubernetes clusters locally.
- **Google Artifact Registry**: For storing and managing container images.
- **Python**: Used in scripts and Dockerfile.

## Repository Structure

### 1. `.github/workflows`
This directory contains GitHub Actions workflows:
- **`main.yml`**: This workflow automates the creation of resources on GCP using Terraform. It sets up the necessary infrastructure as per the specified configurations.

### 2. `insert-data`
This directory is divided into two parts:
- **`image`**:
  - **`insert_data_script.py`**: A script to insert data.
  - **`Dockerfile`**: Builds a Docker image for the data insertion script.
- **`minikube-job`**:
  - **`job.yaml`**: A Kubernetes manifest for running the data insertion task on Minikube. *Note: The image referenced in this manifest is from the Docker registry instead of the Google Artifact Registry.*

### 3. `list-vul-script`
- **`vulnerability_check.py`**: A script that performs a vulnerability check on the Docker image stored in the Google Artifact Registry.

### 4. `terraform`
This directory contains Terraform configurations for setting up the infrastructure:
- **`envs`**:
  - **`prod`**: Contains environment-specific configurations. For this test job, only the `prod` environment is set up.
- **`modules`**:
  - Contains reusable Terraform modules for creating various resources.

### Special Notes
- The Dockerfile uses an older version of Python intentionally to demonstrate vulnerability detection.

### Running the Workflow
- The GitHub Actions workflow will automatically trigger on push to the main branch, creating the required resources on GCP.

### Conclusion
- This repository demonstrates a comprehensive approach to DevSecOps tasks using modern tools and practices. By following the structure and instructions, you can recreate the setup and understand the implementation details. 

