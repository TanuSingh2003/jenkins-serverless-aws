# Jenkins + Serverless AWS Notes API

A serverless Notes API deployed with **AWS Lambda (Docker Image)**, **API Gateway**, and **Postgres on RDS**.  
Infrastructure is managed with **Terraform**, CI/CD with **Jenkins**, and monitoring via **CloudWatch**.

## Features
- CRUD Notes API (Flask + PostgreSQL)
- Lambda container image stored in ECR
- API Gateway HTTP API → Lambda → RDS
- Static assets served from S3
- Infrastructure as Code with Terraform modules
- Jenkins pipeline: build → push image → Terraform apply → smoke tests
- CloudWatch alarms & RDS automated backups
- IAM least-privilege, encrypted S3, Secrets Manager for DB creds

## Repo Structure
- `app/` → Flask app code
- `terraform/` → Terraform IaC modules
- `jenkins/` → Jenkins pipeline
- `scripts/` → Smoke test scripts
- `Dockerfile` → Lambda container image
- `README.md` → Documentation

## Code available at
👉 [github.com/TanuSingh2003/jenkins-serverless-aws](https://github.com/TanuSingh2003/jenkins-serverless-aws)
