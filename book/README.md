# Deploying Web Apps with AWS (WORK IN PROGRESS)

*Deploying Web Apps with AWS* teaches the fundamentals of deploying web apps with AWS (Amazon Web Services). It couples practical examples with conceptual explanations so that you learn not just how to follow instructions but also what each instruction does and why.

The target audience is software developers who are comfortable with a general purpose programming language like Javascript, Python, or Java. Although the example projects are written using Javascript, familiarity with Javascript is not required because this book focuses on *architecting* and *deploying*, not *coding*, web apps.

This book is not an exhaustive reference of every service offered by AWS. It is a tutorial about deploying web app, and should be read sequentially, as each section assumes familiarity with the concepts explained in prior sections.

Because AWS does not provide the best solution to every problem, some examples in this book use non-AWS services like Lets Encrypt and Gitlab.

## Contents

Chapter 1 explains basic concepts about the web, the internet, web servers, and the cloud. It also discusses major cloud service providers as of 2018. 

Chapter 2 explains what AWS is, its relative merits, and how to navigate its documentation and web interface. It also describes fundamental AWS concepts like regions, availability zones, identity and access management, and virtual privace clouds.

Chapter 3 provides provides detailed overviews of commonly used AWS services like EC2 (Elastic Compute Cloud), S3 (Simple Storage Service), RDS (Relational Database Service), SQS (Simple Queue Service) and more.

Chapter 4 walks through deploying a simple web app. It shows how to provision a VM with EC2, run a NodeJS web app on this VM, register a custom domain name, configure DNS records, provision an SSL Certificate and deliver traffic over HTTPS.

Chapter 5 shows how to leverage additional AWS services like S3, RDS, Cognito, and Polly to add user accounts and audio playback to the Readability proxy.

Chapter 6 shows how to make your readability proxy scalable and reliable. It shows how to containerize your app with docker, store docker images in ECR (Elastic Container Registry), deploy docker images with ECS (Elastic Container Service), scale with Auto Scaling Groups, cache and rate-limit with Elasticache Redis, load balance with ELB (Elastic Load Balancer), and monitor instance health with CloudWatch.

Chapter 7 shows how to deploy a complex background job.

Chapter 8 shows how to deploy and manage your application with Elastic Beanstalk.

Chapter 9 shows how to automate your infrastructure with Terraform.

Chapter 10 introduces serverless computing with Lambda, API Gateway, and DynamoDB.

Chapter 11 explains how to use Kubernetes. Maybe.

## Feedback

If you encounter an error in this book, please [submit an issue on Github](https://github.com/sailfm/aws-book/issues) or email help@sail.fm.

## Credits

Copyright 2018, Sufyan Dawoodjee