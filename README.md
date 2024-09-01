Continuous Integration and Continuous Delivery (CI/CD) for Spring Petclinic on EKS
This document outlines the CI/CD pipeline for deploying the Spring Petclinic application to an EKS cluster using a GitOps approach.

Prerequisites
1. ECR Image Repository: Create an Amazon Elastic Container Registry (ECR) repository to store the Docker image for the Spring Petclinic application.
2. IAM Role for ECR Push: Create an IAM role with appropriate permissions to read, write, and upload images to your ECR repository. Configure this role with OIDC authentication through your GitHub Actions workflow using the provided documentation: https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/   
3. GitOps Token: Generate a GitOps token for making commits to the k8s-deployment repository and store it as a secret in your GitHub repository (e.g., GIT_TOKEN).
AWS Region Secret: Create a secret in your GitHub repository (e.g., TEST_AWS_REGION) containing the AWS region where your ECR repository resides. This should match the region where your EKS cluster is located.
4. Prometheus Monitoring: Add the following dependency to your Spring Petclinic application's pom.xml to expose metrics to Prometheus for monitoring:
XML
<dependency>
  <groupId>io.micrometer</groupId>
  <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
Use code with caution.

5. Action Runner Workflow: Create a workflow file (e.g., .github/workflows/cicd.yml) for your CI/CD pipeline using GitHub Actions. This workflow will automate the following tasks:

Building the Docker image for your Spring Petclinic application.
Pushing the image to your ECR repository.
Triggering a GitOps deployment using the GitOps token to update the k8s-deployment repository with the new image version.

6. Dockerfile: Create a Dockerfile that defines the steps for building the Docker image for your Spring Petclinic application.

