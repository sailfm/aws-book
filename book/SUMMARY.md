# Summary

## Building Web Apps with AWS (WORK IN PROGRESS)

* [Introduction](README.md)

## Chapter 1. Background

* [Intro]()
* [Web Fundamentals](background/web.md)
* [Web App architecture](background/web-apps.md)
* [Web Developer tools](background/web-developer-tools.md)
* [The Cloud](background/cloud.md)
* [Major Cloud Vendors (2018)]()

## Chapter 2. AWS Fundamentals

* [Intro](aws/basics/about.md)
* [Services]()
* [Why use AWS]()
* [Documentation](aws/basics/docs.md)
* [Web Console](aws/basics/console.md)
* [Regions and AZs (Availability Zones)]()
* [IAM (Identity and Access Management)](aws/basics/IAM.md)
* [VPC (Virtual Private Clouds)](aws/basics/VPC.md)

## Chapter 3. AWS Services

* [Compute](aws/services/compute.md)
* [Storage](aws/services/storage.md)
* [Other](aws/services/other.md)

## Chapter 4. Simple Web App: Readability Proxy

* [Intro]()
* [Provision a VM with EC2](deploy/ec2/deploy.md)
* [Configure network rules]()
* [Install and run a NodeJS web app](deploy/server/index.md)
* [Register a custom domain name]()
* [Configure DNS records]()
* [Provision a Lets Encrypt SSL Certificate]()
* [Deploy with NGINX]()

## Chapter 5. Enhanced Web App: accounts and audio

* [Intro]()
* [Source Control with Gitlab](deploy/gitlab.md)
* [Deploy Postgres with RDS](deploy/rds.md)
* [Generate audio with Polly](deploy/docker.md)
* [Store files with S3](deploy/docker.md)

## Chapter 6. Making your web app scalable and reliable

* [Containerize with Docker]()
* [Store the Docker image in ECR]()
* [Add ELB Elastic Load Balancer]()
* []()

## Chapter 7. Background work: batch audio processing and email notifications

* [Run tasks with SQS]()
* [Process audio conversion jobs with AWS Batch]()
* [Send email notifications with SES]()

## Chapter 8. Manged Deployments with Elastic Beanstalk

* [Intro]()
* [NodeJS with Elastic Beanstalk](deploy/elastic-beanstalk.md)
* [Sending Email with SES](deploy/ses.md)
* [Task Queueue with SQS](deploy/sqs.md)
* [Redis with Elasticache](deploy/elasticache.md)
* [Continuous Integration and Deployment with Gitlab](deploy/gitlab-ci.md)

## Chapter 9. Infrastructure Automation

* [Intro]()
* [Cloudformationa and Terraform]()
* [Continuous Integration with Gitlab]()

## Chapter 10. Serverless Computing

* [Intro]()
* [Lambda]()
* [API Gateway]()
* [DynamoDB]()

## Chapter 11. Kubernetes

* [Intro]()