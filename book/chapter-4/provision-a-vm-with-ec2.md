# Provision a VM with EC2

## Prerequisites

* [The Cloud](../chapter-1/the-cloud.md)
* [Web Security](../chapter-1/web-security.md)

## Concepts

* If the instance is replaced in the future, it will lose its public IP address. To ensure the webserverelastic IP needed

## Steps

1. In the AWS Web Console navigate to the EC2 service dashboard and launch and instance.

2. Choose an AMI (Amazon Machine Image). This determines the operating system and applications your virtual machine will be initialized with. Select an Amazon Linux AMI, for example **Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type** with ID `ami-467ca739`.

3. Select an instance type. The instance type determines the hardware resources like virtual CPUs, RAM, and storage volumes that are allocated to your virtual machine. Instance types that use more resources generally perform better but cost more. Select an instance type based on the needs of your application. For this tutorial, select **t2.micro**.

4. Add the instance to the `readvpc-1a` subnet of the `readvpc` VPC and enable **Auto-assign Public IP**.

5. Add a tag with Key `Name` and Value `readproxy-v1`.

6. Create a new **security group** with name `readproxy-sg` and description `readproxy-sg`. Add the following rules:

Type  | Protocol | Port | Source
------|----------|------|--------------------
SSH   | TCP      | 22   | Anywhere: 0.0.0.0/0
HTTP  | TCP      | 80   | Anywhere: 0.0.0.0/0
HTTPS | TCP      | 443  | Anywhere: 0.0.0.0/0

7. Create a new key pair named `aws`. Download the private key file `aws.pem` and copy it to `~/.ssh/aws.pem`. Ensure only you can read the private key with the command `chmod 400 ~/.ssh/aws.pem`.

8. Finally, launch the instance then navigate to the EC2 dashboard. Take note of the instance's public and private IPs and DNS Hostnames.

·          | Hostname                                  | IP
-----------|-------------------------------------------|--------------
**Public** | ec2-54-227-175-11.compute-1.amazonaws.com | 54.227.175.11
**Private**| ip-10-0-0-127.ec2.internal                | 10.0.0.127

9. Navigate to the VPC dashboard, allocate a new Elastic IP, then associate the IP with the `readproxy-v1` instance. The public hostname and IP will change correspondingly.

·          | Hostname                                   | IP
-----------|--------------------------------------------|--------------
**Public** | ec2-52-201-208-126.compute-1.amazonaws.com | 52.201.208.126
**Private**| ip-10-0-0-127.ec2.internal                 | 10.0.0.127

## References

1. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html
2. https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc