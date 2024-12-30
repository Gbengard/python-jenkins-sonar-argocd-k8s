# TodoApp CI/CD Pipeline with Jenkins and ArgoCD

This repository demonstrates a complete CI/CD pipeline using Jenkins for continuous integration and ArgoCD for continuous delivery. The pipeline automates code analysis, Docker image creation and pushing, and deployment updates for Kubernetes manifests.

## Pipeline Stages

### 1. **Static Code Analysis**
- **Tool Used:** SonarQube  
- The pipeline performs static code analysis using SonarQube to ensure code quality. It scans the source code and uploads the results to the SonarQube server for detailed analysis.

### 2. **Build Docker Image**
- The application is packaged as a Docker image using a Dockerfile available in the repository.
- The image is tagged with the current build number for versioning.

### 3. **Push Docker Image**
- The Docker image is pushed to Docker Hub or any specified container registry. 
- The pipeline authenticates with Docker Hub using credentials stored in Jenkins (`docker-cred`).

### 4. **Update Kubernetes Manifest and Push to GitHub**
- The Kubernetes manifest (`deploy.yaml`) is updated to reflect the new Docker image version.
- The updated manifest is committed and pushed to the GitHub repository. 
- This triggers ArgoCD to detect changes and deploy the updated application to the Kubernetes cluster.

## Prerequisites

### Tools and Technologies
- **Jenkins**: To manage and execute the CI/CD pipeline.
- **SonarQube**: For static code analysis.
- **Docker**: To build and store containerized applications.
- **ArgoCD**: For automated deployment to Kubernetes.
- **Kubernetes**: To host the application.
- **GitHub**: To manage source code and Kubernetes manifests.

### Required Jenkins Plugins
- Pipeline
- Git
- Docker Pipeline
- SonarQube Scanner

### Credentials
- **SonarQube**: A pre-configured SonarQube environment in Jenkins.
- **Docker Hub**: Docker credentials (`docker-cred`) must be stored in Jenkins.
- **GitHub**: GitHub personal access token stored in Jenkins (`github`).

## Folder Structure

.
├── Jenkinsfile        # Jenkins pipeline definition
├── deploy/
│   └── deploy.yaml    # Kubernetes manifest
├── Dockerfile         # Docker build instructions
└── src/               # Application source code


## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/gbengard/python-jenkins-argocd-k8s.git
    ```

```markdown
## Setup Jenkins
- Import the `Jenkinsfile` into your Jenkins job.
- Configure the required credentials and tools in Jenkins.

## Configure SonarQube
- Ensure SonarQube is configured as a tool in Jenkins with the name `Sonar`.

## Run the Pipeline
- Trigger the pipeline from Jenkins. Each stage will execute sequentially.

## Monitor Deployment
- ArgoCD will automatically detect changes pushed to the GitHub repository and deploy the updated application to Kubernetes.

## Key Features
- Automated static code analysis for quality assurance.
- Docker-based application packaging and versioning.
- Continuous delivery via ArgoCD for seamless deployment to Kubernetes.
- Automated GitHub updates for deployment manifests.

## Contact
For questions or support, please contact [gbengardo@gmail.com](mailto:gbengardo@gmail.com).
```

