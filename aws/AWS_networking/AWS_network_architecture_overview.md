# AWS Networking Overview

## 1. Virtual Private Cloud (VPC)
A **VPC** is your isolated virtual network inside AWS where you define your own IP ranges, subnets, routing, and security.

### Example CIDR
```
VPC CIDR: 10.0.0.0/16
```

---

## 2. Subnets (Public & Private)

### Public Subnet
- Has a route to the **Internet Gateway (IGW)**
- Used for Load Balancers, Bastion Hosts, NAT Gateways

Example:
```
Public Subnet 1: 10.0.1.0/24
```

### Private Subnet
- No direct route to the internet
- Used for EC2 backend servers, databases, internal services

Example:
```
Private Subnet 1: 10.0.2.0/24
```

### ASCII Diagram
```
                +----------------------+
                |        VPC           |
                |   10.0.0.0/16        |
                +----------------------+
                |       |        |     |
        +-------+   IGW |        | NAT +--------+
        |               |        | Gateway      |
        v               v        v              v
+---------------+  +---------------+    +---------------+
| Public Subnet |  | Private Subnet|    | Private Subnet|
| 10.0.1.0/24   |  | 10.0.2.0/24   |    | 10.0.3.0/24   |
+---------------+  +---------------+    +---------------+
```

---

## 3. Internet Gateway (IGW)
An IGW allows public subnets to access the internet.

Route Example:
```
0.0.0.0/0 -> Internet Gateway
```

---

## 4. NAT Gateway
Allows **private subnet EC2 instances** to access the internet **outbound** while staying unreachable from the public internet.

Route Example:
```
0.0.0.0/0 -> NAT Gateway
```

ASCII:
```
Private EC2 ---> NAT Gateway ---> Internet
```

---

## 5. Route Tables

### Public Route Table
```
Local (10.0.0.0/16)
0.0.0.0/0 -> IGW
```

### Private Route Table
```
Local (10.0.0.0/16)
0.0.0.0/0 -> NAT Gateway
```

---

## 6. Network ACL (NACL)
Subnet-level stateless firewall.

- Public subnets often allow inbound 80/443.
- Private subnets restrict public inbound.

---

## 7. Security Groups (SG)
Instance-level stateful firewalls.

Example:
```
Allow inbound: SSH from Bastion (10.0.1.10)
Allow outbound: All
```

---

## 8. Accessing Private EC2

### **Method 1: Bastion Host (Jump Server)**

ASCII Diagram:
```
You -> Bastion (Public EC2) -> Private EC2
```

Steps:
- Bastion sits in the public subnet.
- You SSH into Bastion using public IP.
- Bastion SSH → private EC2 via internal IP (10.0.x.x).

### **Method 2: AWS SSM Session Manager**

Benefits:
- No public IP needed.
- No open SSH ports.
- Works over AWS internal SSM endpoint.

ASCII:
```
You -> SSM -> Private EC2
```

---

## 9. Route 53 (DNS)
High-level DNS service used to map domain names to:

- EC2 public IPs
- Load Balancers
- CloudFront
- Private Hosted Zones (internal domains)

Example:
```
api.example.com -> ALB DNS
```

---

## 10. Full Architecture Diagram (ASCII)
```
                       Internet
                           |
                           v
                    +-------------+
                    |   Internet  |
                    |   Gateway   |
                    +-------------+
                           |
                 +---------+---------+
                 |   Public Subnet   |
                 |   10.0.1.0/24     |
                 +-------------------+
                 | Bastion | NAT GW  |
                 +-------------------+
                     |         |
          SSH --------         |
                               v
                     Private Subnet
                       10.0.2.0/24
                     +-------------+
                     |  EC2 App    |
                     +-------------+
```

---

## 11. Summary
This README covers:
- VPC, Subnets, IGW, NAT, NACLs, Route Tables
- Public vs Private networking
- How IP routing works internally
- Private EC2 access via Bastion or SSM
- Route 53 basics

### **NOTE:** 
**THIS FILE ONLY GIVES THE OVERVIEW OF AWS NETWORKING AND IT'S BASIC ARCHITECTURE FOR NEWBIES.**
