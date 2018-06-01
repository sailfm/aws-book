# VPC (Virtual Private Clouds) (WIP)

## Prerequisites

* [The Internet](../chapter-1/the-internet.md)

## VPC

A virtual private cloud is a private software-defined network connecting AWS resources within a single region. VPCs contain a range of IP addresses defined in [CIDR notation](../chapter-1/web-protocols.md#??Private_Networks).

Every [region](??) of an AWS account is initialized with a default VPC with CIDR 172.31.0.0/16 containing IP addresses in the range 172.31.0.0 - 172.31.255.255. You can create additional VPCs with custom CIDR blocks.

**Example default VPC for US East 2 region**

VPC ID       | Region           | IPv4 CIDR     | Route Table
-------------|------------------|---------------|-------------
vpc-4a53da22 | US East 2 (Ohio) | 172.31.0.0/16 | rtb-945e1ffc

## Subnets

Default VPCs are initialized with a default subnet for each availability zone within their region. A subnet is assigned a CIDR-defined subset of the IP addresses within its VPC and must be associated with a single [availabilty zone](??). The IP address ranges of two subnets may not conflict, and there may exist IP addresses within a VPC that are not assigned to a subnet. The first four and last IP addresses of a subnet are reserved and cannot be used. Certain AWS resources, like EC2 instances, must be assigned a specific subnet within a specific VPC to be created.


**Example default Subnets for default US East 2 VPC**

Subnet ID       | VPC ID       | IPv4 CIDR      | Availability Zone | Route Table
----------------|--------------|----------------|-------------------|-------------
subnet-b29419da | vpc-4a53da22 | 172.31.0.0/24  | us-east-2a        | rtb-945e1ffc
subnet-8d3d0dc0 | vpc-4a53da22 | 172.31.16.0/24 | us-east-2b        | rtb-945e1ffc
subnet-2df83d57 | vpc-4a53da22 | 172.31.32.0/24 | us-east-2c        | rtb-945e1ffc


## Route Tables

A route table is a list of rules that determine how traffic is routed within a subnet. Each entry in the list is a mapping from a CIDR-defined range of IP addresses to a target.

Every subnet must be associated with exactly one route table and multiple subnets can be associated with the same route table. When not explicitly assigned to a route table, a subnet is assigned to its VPC's Main route table. Every VPC is initialized with a Main route table that routes all IPs belonging to the VPC locally and all other IPs to an internet gateway. You can add additional route tables with custom rules to a VPC then associate subnets with the new route tables.

Every route table is initialized with an entry that routes IPs belonging to the VPC locally, and this entry cannot be removed. This means that every device within a VPC can talk to every other device within the VPC.

**Example Main Route Table initialized for default VPC**

Destination   | Target
--------------|-------------
172.31.0.0/16 | local
0.0.0.0/32    | igw-b8130fd1

## Private Subnets, Public Subnets, and Internet Gateways

## NAT Gateways

## Security Groups

"Security groups control inbound and outbound traffic for your instances"

## ACLs (Access Control Lists)

"network ACLs control inbound and outbound traffic for your subnets"

## DHCP

## Internal and External IPs and Hostnames

?? Example DNS/IP lookup from within and outside a VPC. Should show diff. Public to private mapping done by NAT.

Public IP addresses only assigned by default in default subnets of default VPC. Otherwise no public IP by default.

## Elastic IPs

## Metadata Interface

## Conclusion

VPCs are private networks containing a CIDR defined range of IP addresses. VPCs are split into subnets, which are 


## References

1. https://start.jcolemorrison.com/aws-vpc-core-concepts-analogy-guide/
1. https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc
1. https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html
