# The Internet (WIP)

The **internet** is a global collection of machines that are physically connected. Each machine connects to the internet through at least one **network interface**, and each network interface is assigned a unique number called an **IP (Internet Protocol)** address. A machine can send information to another machine on the internet if it knows the IP address of a network interface on the target machine. To be sent over the internet, information must be segmented and formatted into units called **IP packets**. To reach its destination, an IP packet may have to traverse multiple **links**, each connecting two intermediary machines called **routers**.

## IP Addresses

IP addresses come in two forms: 32-bit **IPv4** addresses and 128-bit **IPv6** addresses. Initially, only IPv4 addresses existed, but the internet architects came to realize that 32 bits can only uniquely identify about 4 billion devices - hardly enough for a world with more than 7 billion people. IPv6 addresses this issue by increasing the address length to 128-bits. IPv4 is still widely used by networks operators and taught in classrooms today because it works, it's simple, and address space exhaustion can be mitigated with tricks like [NAT (Network Address Translation)](??).

IPv4 addresses are usually written in **dot-decimal** notation, which splits 32-bits into four decimal encoded bytes. The following are all equivalent representations of the 32-bit IPv4 address *one-billion seventy-two*.

Decimal       | 32-Bit Binary                       | Hexadecimal | Dot-Decimal Notation 
--------------|-------------------------------------|-------------|----------------------
1,000,000,072 | 00111011_10011010_11001010_01001000 | 3B_9A_CA_48 | 59.154.202.72

## Autonomous Systems

In reality, the internet isn't a single network of machines. It's actually a cooperative of interconnected subnetworks called **ASs (autonomous systems)** administrated by independent organizations. Machines within an AS are assigned IP addresses from pools of IP addresses owned by the organization that controls the AS. The policies and protocols that determine how traffic is routed within an AS are usually governed by efficiency, while routing between ASs is usually governed by economics. When traffic passes from one AS to another AS, the receiving AS is compensated for accepting the traffic, unless the both ASs agree to [**peer ??**](https://en.wikipedia.org/wiki/Peering) traffic free-of-charge. If you are reading this from your web browser, data was likely transferred from your computer to an AS run by your **ISP (Internet Service Provider)**, through a few intermediary ASs and finally to a server running in my hosting provider's AS.

`TODO: AS example diagram`

## CIDR

Autonomous system administrators purchase IP addresses in groups called **subnets**, which are partitioned by bit prefix, meaning their size is always a power of two. Subnets are defined using **CIDR (Classless Inter-Domain Routing)** notation, which comprises an IP address representing the start of the subnet, then a forward slash, then a number called the **subnet mask** representing the size of the shared prefix. For example, 34.192.0.0/12 is an IPv4 CIDR that starts with 34.192.0.0, which is 00100011_11000000_00000000_00000000 in binary. The subnet mask /12 means that all IP addresses share the first 12 bits 00100011_1100. Therefore, the last IP address in the subnet is **00100011_1100**1111_11111111_11111111 or 34.207.255.255. The subnet mask /12 can also be represented by an IP address with the first 12 bits set to 1 and the remaining bits set to 0. For example, /12 is **11111111_1111**0000_00000000_00000000 in binary, which is FF_F0_00_00 in hexadecimal and 255.240.0.0 in dot-decimal.

`TODO: CIDR breakdown diagram`

**Example IPv4 CIDRs**

Use            | IPv4 CIDR      | Start Address | End Address     | Subnet Mask
---------------|----------------|---------------|-----------------|------------
AWS us-east-1  | 34.192.0.0/12  | 34.192.0.0    | 34.207.255.255  | 255.240.0.0
Apple Inc      | 17.0.0.0/8     | 17.0.0.0      | 17.255.255.255  | 255.0.0.0
Private Use    | 192.168.0.0/16 | 192.168.0.0   | 192.168.255.255 | 255.255.0.0
Private Use    | 10.0.0.0/8     | 10.0.0.0      | 10.255.255.255  | 255.0.0.0
ARIN           | 172.0.0.0/8	  | 172.0.0.0     | 172.255.255.255 | 255.0.0.0

## Private Networks

Although most organizations have neither the business need nor operational expertise to run an autonomous system, it often makes sense to connect their devices within a **private network**. A simple example is a home network with multiple computers and a printer all connected to a single home router. The typical home router is a multifunctional device that contains a **switch** to connect local devices, a **router** to interface with the internet, and a **DHCP (Dynamic Host Configuration Protocol)** server to assign IP addresses from the private **subnet** to connected devices. This simple setup enables free communication between devices within the local network, while also providing a protected **gateway** to the internet.

`TODO: Home network example with IP addresses listed diagram`

## IP Address Assignment

Devices in the home network communicate directly through the switch. When a new device is connected to the home router, it tries to requisition an IP address and determine its subnet by sending a DHCP discovery message to the broadcast IP address 255.255.255.255. This message arrives at the switch, which then broadcasts it to every connected devices in the subnet. Every device ignores the message except the DHCP server, which replies with an available IP address in the subnet and the subnet mask. Many home routers are configured to assign IP addresses from subnet 192.168.0.0/16, which is reserved for private networks. The new device associates this IP address and subnet mask with the network interface through which it sent the request. The DHCP server keeps track of the allocated IP address and the network interface to which it was assigned.

`TODO: ?? IP assignment steps diagram`

## IP Packets

Internet data is sent in well-defined, variable-length units called **IP packets**. Every IP packet begins with an **IP header** containing the packet's source IP address and destination IP address, the IP protocol version, a checksum to ensure data is not corrupted in transit, the packet size, and other fields. A packet's destination IP address is used by routers to forward the packet to its destination, while its source IP address informs the destination machine who to respond to. After the header comes the payload, which contains application-specific data.

`TODO: ?? IP packet diagram`

## Subnet Communication

Communication between devices within a subnet requires only a connection (often via a switch), not a router. After a computer determines an IP packet's destination address belongs to one of its network interface's subnets, it must then identify the network interface associated with the destination IP address. This is accomplished by broadcasting an **ARP (Address Resolution Protocol)** message asking who has the destination IP address to every network interface in the subnet. The device with the destination network interface will respond with the network interface's **MAC address**, which is a unique 48-bit number usually hardcoded by the manufacturer. Now aware of the MAC address associated with the destination IP address, the source device can direct IP packets to the correct network interface. For efficiency, devices maintain an ARP table that caches mappings from IP addresses to MAC addresses.

`TODO: ?? subnet communication example diagram`

<!-- Because the printer is connected to the same home router as the computer, the DHCP server should also have been assigned an IP address in the same subnet as the computer. it an IP address the destination addressIt sends these IP packets through its network interface to the switch, which notices the destination is another device on the local subnet, so it forwards the IP packets directly to the printer. At no point is the print job sent through the router to the internet. -->

## Internetwork Communication

Computers maintain a datastructure called a **routing table** to decide how to route IP packets. A routing table is a list of rules wherein each rule maps a destination subnet to a target **Gateway**.  Example destination subnets are a single IP address like 192.168.0.243/32, a local subnet like 192.168.0.0/16, and the complete internet address space 0.0.0.0/0. A gateway is a device that connects networks and is often an internet router. The rule with the most specific destination subnet matching an IP packet's destination address determines which gateway the IP packet is sent to.

**Example Route Table**

Destination             | Gateway              | Network Interface
------------------------|----------------------|------------------
0.0.0.0/0 (default)     | 192.168.0.1 (router) | ethernet0
192.168.0.0/16 (subnet) | 0.0.0.0 (local)      | ethernet0

Given the routing table above, an IP packet sent to 8.8.8.8 matches the default destination 0.0.0.0/0 and will therefore be sent through the ethernet0 network interface to the internet via the router at 192.168.0.1. An IP packet sent to 192.168.23.34 matches the more specific destination 192.168.0.0/16, which is associated with the gateway 0.0.0.0, which implies the packet should be sent to a host on the local subnet and dropped if no host is found.

**Commands for displaying your computer's network interfaces and routing table**

Operating System | List Network Interfaces | Show Routing Table
-----------------|-------------------------|-------------------
Linux & OSX      | ifconfig -a             | netstat -nr
Windows          | ??                      | ??

## Routers

A **router** is a computer that bridge subnets (necessating at least two network interfaces) and route packets between them (using a routing table). Many routers have a **firewall**, which enforces a list of rules describing the types of traffic that can or cannot leave or enter a subnet. Many also include a NAT ??

## Operating Systems, Ports, TCP

## References

1. https://web.stanford.edu/class/msande91si/www-spr04/readings/week1/InternetWhitepaper.htm
1. https://en.wikipedia.org/wiki/Internet
1. https://en.wikipedia.org/wiki/IPv4#Packet_structure
1. https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol
1. http://www.erg.abdn.ac.uk/users/gorry/course/inet-pages/arp.html
1. http://www.cse.uconn.edu/~vcb5043/MISC/IP%20Intranet.html
1. https://www.cloudflare.com/learning/dns/what-is-dns/
3. https://en.wikipedia.org/wiki/URL
4. https://en.wikipedia.org/wiki/Autonomous_system_(Internet)
5. https://en.wikipedia.org/wiki/Peering
