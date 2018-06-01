# Create a VPC (WIP)

To run a web app, your must provision the server on which the web app will run, and to provision the server, you must specify the virtual private cloud the server belongs to. This section details how to create a basic virtual private cloud for the readability web app.

## Prerequisites

* [The Internet](../chapter-1/the-internet.md)

* [Virtual Private Clouds](../chapter-2/virtual-private-clouds.md)

## Concepts

In general AWS resources are provisioned in software-defined virtual private networks called VPCs. Deploying a web app means making it accessible to the world. This web app should run somewhere that users can access it over the internet. 

* ??

* internet routable

* secure

* single availability zone

* organized

* private instance IPs by default unless configured otherwise per-instance

* public DNS Hostnames

## Steps

1. In the AWS Web Console select the `N. Virginia (us-east-1)` region and navigate to the VPC service.

2. Create a VPC named `readvpc` and assign it the IPv4 CIDR block `10.0.0.0/22`, which contains 1024 IP addresses.

3. Select `readvpc` then enable **DNS Hostnames** using the **Actions** button.

3. Add a subnet to `readvpc` named `readvpc-1a` in the `us-east-1a` availability zone and assign it CIDR block `10.0.0.0/24`, which contains 256 IP addresses.

4. Create an internet gateway named `igw-readvpc` then attach it to `readvpc`.

5. Add a route table to `readvpc` named `rt-readvpc-1a`.

6. Add a new route to `rt-readvpc-1a` directing `0.0.0.0/0` to `igw-readvpc`.

7. Change the route table associated with `readvpc-1a` from the default `Main` to `rt-readvpc-1a`.

## References

