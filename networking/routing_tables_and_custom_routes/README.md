# Routing Table and Custom Routes

## What is a Routing Table?
A routing table is like a GPS map inside a router. It contains rules that tell the router how to forward data packets to their destination.

### Key Components of a Routing Table:
- **Destination Network:** The IP address or network the packet is trying to reach.
- **Subnet Mask:** Defines the network size (how many IPs are in the network).
- **Next Hop:** The next device (usually another router) to which the packet should be sent.
- **Interface:** The router’s port through which the packet should go out.
- **Metric:** The cost of the route (lower is better). It helps choose the best path if multiple paths exist.
- **Route Type:** Indicates whether the route is:
  - **Directly Connected** (within the router's network)
  - **Static** (manually configured by an admin)
  - **Dynamic** (learned through routing protocols like OSPF, BGP)

---

## How Does a Router Use the Routing Table?
1. The router checks the **destination IP**.
2. Matches it with the most specific route (**longest subnet mask**).
3. If no match, uses the **default route**.
4. If still no match, the **packet is dropped**.

### Commands to View Routing Table:
```sh
ip route show
route -n
```

---

## Types of Routing Tables

### 1. Static Routing Table
A static routing table contains routes that are manually configured by a network administrator. These routes do not change automatically, even if the network topology changes.

### 2. Dynamic Routing Table
A dynamic routing table automatically updates based on changes in the network using routing protocols like OSPF, BGP, EIGRP, etc.

### 3. Default Routing Table
A default route (also called a **gateway of last resort**) handles traffic destined for unknown networks. It’s commonly used to route packets to the internet.

---

## What is Custom Routes?
**Custom routes** are manually defined routes that control how specific traffic is handled. They allow fine-grained control beyond the default routing behavior.

### Why Use Custom Routes?
- To define specific paths for certain networks.
- To optimize **performance** or **security**.
- Used for **VPNs**, **multi-ISP setups**, etc.

---

## Policy-Based Routing (PBR)

**Policy-Based Routing** allows routing decisions based on:
- **Source IP address**
- **Destination IP address**
- **Port number**
- **Protocol (TCP/UDP)**
- **Packet size**

---

## How Does PBR Work?
1. **Packet Arrival:** A packet arrives at the router or Linux system.
2. **Policy Check:** PBR rules are evaluated based on source, destination, ports, etc.
3. **Routing Decision:**
   - If a **rule matches** → Packet is forwarded according to the custom route.
   - If **no rule matches** → Packet follows the default routing table.

---

## Additional Notes:
- **Routing protocols** like OSPF, BGP, and RIP help in **dynamic routing**.
- **Administrative Distance (AD)** helps in choosing between multiple routes from different protocols.
- **NAT (Network Address Translation)** plays a role in routing by modifying source/destination addresses.

---

