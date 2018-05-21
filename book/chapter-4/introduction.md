# Chapter 4. Simple Web App: Readability Proxy (WIP)

This chapter teaches how to deploy a simple web app with a step-by-step example. Readers will deploy a readability proxy, which is an app that accepts a user-provided URL, fetches the page, and then displays the text of interest to the user.

The following steps will be taken:
1. Provision a VM (Virtual Machine) with EC2 (Elastic Compute Cloud)
2. Configure IAM (Identity and Access Management) and Network rules
3. Install and run the NodeJS Web App
4. Register a Domain Name
5. Configure DNS Records
6. Provision a Lets Encrypt SSL Certificate
7. Deploy the web app behind an NGINX reverse proxy

Two alternative ways to deploy the readability proxy are also presented:
1. Deploy with AWS Lightsail
2. Deploy wit Digital Ocean

Finally, section ?? shows how to automate the web app's deployment with Terraform.