# Go Web App 2

This repository is responsible for building and deploying a Docker image for the Go web application from the [go-web-app](https://github.com/AlexanderLashov/go-web-app2) repository. The image is then deployed to a Kubernetes cluster using Minikube and Helm charts.

## Workflows

### Docker Build and Push (`docker.yaml`)

This workflow is triggered by a dispatch event from the `go-web-app` repository. It performs the following steps:

1. Build a multi-platform Docker image using the latest release binary from `go-web-app`.
2. Push the Docker image to DockerHub.

### Kubernetes Deployment (`kubernetes.yml`)

This workflow is triggered after the Docker image is successfully pushed to DockerHub. It performs the following steps:

1. Set up Minikube for Kubernetes deployment.
2. Set up `kubeconfig` for Kubernetes access.
3. Set up Helm for managing Kubernetes packages.
4. Use Helm to deploy or upgrade the Go web application in the Kubernetes cluster.
5. Verify the deployment by checking the status of the Kubernetes deployment and running a `curl` command to ensure the service is running correctly.

